// coverage:ignore-file

import 'dart:isolate';

import 'package:codenic_logger/src/message_log.dart';
import 'package:logger/logger.dart';

/// {@template MessageLogPrinter}
///
/// An adaption of [PrettyPrinter] that displays the content of a [MessageLog]
/// and prevents long texts from being truncated.
///
/// Output looks like this:
/// ```
/// ─ID────────────────────────
///  Identifier
/// ─Time───────────────────────
///  Time
/// ─Error────────────────────────
///  Error info
/// ─Stacktrace────────────────────────
///  Method stack history
/// ─Message────────────────────────
///  Message
/// ─Data────────────────────────
///  Data
/// ──────────────────────────
/// ```
///
/// {@endtemplate}
class MessageLogPrinter extends PrettyPrinter {
  /// {@macro MessageLogPrinter}
  MessageLogPrinter({
    super.stackTraceBeginIndex,
    super.methodCount,
    super.errorMethodCount,
    super.lineLength,
    super.colors,
    super.printEmojis,
    super.printTime = true,
    super.excludeBox,
    super.noBoxingByDefault,
    this.stackTraceBlocklistRegex,
  });

  /// A regex that matches stack trace lines that should be excluded from the
  /// output.
  final RegExp? stackTraceBlocklistRegex;

  static final _startTime = DateTime.now();

  /// Matches a stacktrace line as generated on Android/iOS devices.
  /// For example:
  /// #1      Logger.log (package:logger/src/logger.dart:115:29)
  static final _deviceStackTraceRegex =
      RegExp(r'#[0-9]+[\s]+(.+) \(([^\s]+)\)');

  /// Matches a stacktrace line as generated by Flutter web.
  /// For example:
  /// packages/logger/src/printers/pretty_printer.dart 91:37
  static final _webStackTraceRegex =
      RegExp(r'^((packages|dart-sdk)\/[^\s]+\/)');

  /// Matches a stacktrace line as generated by browser Dart.
  /// For example:
  /// dart:sdk_internal
  /// package:logger/src/logger.dart
  static final _browserStackTraceRegex =
      RegExp(r'^(?:package:)?(dart:[^\s]+|[^\s]+)');

  /// A replacement for [PrettyPrinter.getTime].
  ///
  /// The [PrettyPrinter.getTime] throws an [Exception] whenever it is
  /// called in an [Isolate]. The exception indicates that the
  /// `static nullable _startTime` of [PrettyPrinter] has not been initialized.
  /// As a workaround, a non-nullable [_startTime] has been created to
  /// alleviate the issue.
  @override
  String getTime() {
    String threeDigits(int n) {
      if (n >= 100) return '$n';
      if (n >= 10) return '0$n';
      return '00$n';
    }

    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    final now = DateTime.now();
    final h = twoDigits(now.hour);
    final min = twoDigits(now.minute);
    final sec = twoDigits(now.second);
    final ms = threeDigits(now.millisecond);
    final timeSinceStart = now.difference(_startTime).toString();
    return '$h:$min:$sec.$ms (+$timeSinceStart)';
  }

  @override
  List<String> log(LogEvent event) {
    String? stackTraceFormatted;

    if (event.stackTrace == null) {
      if (methodCount > 0) {
        stackTraceFormatted = formatStackTrace(StackTrace.current, methodCount);
      }
    } else if (errorMethodCount > 0) {
      stackTraceFormatted =
          formatStackTrace(event.stackTrace, errorMethodCount);
    }

    return _formatAndPrint(
      event.level,
      event.message as MessageLog,
      printTime ? getTime() : null,
      event.error?.toString(),
      stackTraceFormatted,
    );
  }

  @override
  String? formatStackTrace(StackTrace? stackTrace, int methodCount) {
    var lines = stackTrace.toString().split('\n');
    if (stackTraceBeginIndex > 0 && stackTraceBeginIndex < lines.length - 1) {
      lines = lines.sublist(stackTraceBeginIndex);
    }

    final formatted = <String>[];
    var count = 0;
    for (final line in lines) {
      if (_discardBlocklistedStacktraceLine(line) ||
          _discardDeviceStacktraceLine(line) ||
          _discardWebStacktraceLine(line) ||
          _discardBrowserStacktraceLine(line) ||
          line.isEmpty) {
        continue;
      }
      formatted.add('#$count   ${line.replaceFirst(RegExp(r'#\d+\s+'), '')}');
      if (++count == methodCount) {
        break;
      }
    }

    if (formatted.isEmpty) {
      return null;
    } else {
      return formatted.join('\n');
    }
  }

  bool _discardBlocklistedStacktraceLine(String line) {
    return stackTraceBlocklistRegex?.hasMatch(line) ?? false;
  }

  bool _discardDeviceStacktraceLine(String line) {
    final match = _deviceStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    return match.group(2)!.startsWith('package:logger') ||
        match.group(2)!.startsWith('package:codenic_logger');
  }

  bool _discardWebStacktraceLine(String line) {
    final match = _webStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    return match.group(1)!.startsWith('packages/logger') ||
        match.group(1)!.startsWith('packages/codenic_logger') ||
        match.group(1)!.startsWith('dart-sdk/lib');
  }

  bool _discardBrowserStacktraceLine(String line) {
    final match = _browserStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    return match.group(1)!.startsWith('package:logger') ||
        match.group(1)!.startsWith('package:codenic_logger') ||
        match.group(1)!.startsWith('dart:');
  }

  AnsiColor _getLevelColor(Level level) =>
      colors ? PrettyPrinter.levelColors[level]! : AnsiColor.none();

  String _getEmoji(Level level) =>
      printEmojis ? PrettyPrinter.levelEmojis[level]! : '';

  List<String> _formatAndPrint(
    Level level,
    MessageLog messageLog,
    String? time,
    String? error,
    String? stacktrace,
  ) {
    // This code is non trivial and a type annotation here helps understanding.
    // ignore: omit_local_variable_types
    final buffer = <String>[];

    final color = _getLevelColor(level);

    if (includeBox[level]!) buffer.add(color(_createDivider('ID')));

    final emoji = _getEmoji(level);

    buffer.add(color('$emoji${messageLog.id}'));

    if (time != null) {
      if (includeBox[level]!) buffer.add(color(_createDivider('Time')));
      buffer.add(color(time));
    }

    if (error != null) {
      if (includeBox[level]!) buffer.add(color(_createDivider('Error')));

      for (final line in error.split('\n')) {
        buffer.add(color(line));
      }
    }

    if (stacktrace != null) {
      if (includeBox[level]!) buffer.add(color(_createDivider('Stacktrace')));
      for (final line in stacktrace.split('\n')) {
        buffer.add(color(line));
      }
    }

    final message = messageLog.message;

    if (message != null) {
      if (includeBox[level]!) buffer.add(color(_createDivider('Message')));
      _splitText(message).forEach((text) => buffer.add(color(text)));
    }

    if (messageLog.data.isNotEmpty) {
      if (includeBox[level]!) buffer.add(color(_createDivider('Data')));

      final data = messageLog.data.toString();

      _splitText(data).forEach((text) => buffer.add(color(text)));
    }

    if (includeBox[level]!) buffer.add(color(_createDivider()));

    return buffer;
  }

  String _createDivider([String? title]) {
    final titleLength = title?.length ?? 0;

    if (lineLength < titleLength + 1) {
      return '─' * lineLength;
    }

    return '─${title ?? ''}${'-' * (lineLength - titleLength - 1)}';
  }

  /// Flutter truncates
  Iterable<String> _splitText(String text) =>
      RegExp('.{1,1023}').allMatches(text).map((e) => e.group(0) ?? '');
}
