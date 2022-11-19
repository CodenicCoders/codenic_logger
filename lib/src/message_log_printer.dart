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
/// ──────────────────────────
///  Identifier
/// ──────────────────────────
///  Time
/// ──────────────────────────
///  Error info
/// ──────────────────────────
///  Method stack history
/// ──────────────────────────
///  Message
/// ──────────────────────────
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
  }) : divider = '–' * lineLength;

  /// The printed divider.
  final String divider;

  static final _startTime = DateTime.now();

  @override
  String? formatStackTrace(StackTrace? stackTrace, int methodCount) {
    final stackTraceSplit = stackTrace.toString().split('\n')
      ..removeWhere(
        (str) =>
            str.contains('package:codenic_logger') ||
            str.contains('packages/codenic_logger'),
      );

    final stackTraceSanitizedStr = stackTraceSplit.join('\n');

    return super.formatStackTrace(
      StackTrace.fromString(stackTraceSanitizedStr),
      methodCount,
    );
  }

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

    if (includeBox[level]!) buffer.add(color(divider));

    final emoji = _getEmoji(level);

    buffer.add(color('$emoji${messageLog.id}'));
    if (includeBox[level]!) buffer.add(color(divider));

    if (time != null) {
      buffer.add(color(time));
      if (includeBox[level]!) buffer.add(color(divider));
    }

    if (error != null) {
      for (final line in error.split('\n')) {
        buffer.add(color(line));
      }

      if (includeBox[level]!) buffer.add(color(divider));
    }

    if (stacktrace != null) {
      for (final line in stacktrace.split('\n')) {
        buffer.add(color(line));
      }
      if (includeBox[level]!) buffer.add(color(divider));
    }

    final message = messageLog.message;

    if (message != null) {
      _splitText(message).forEach((text) => buffer.add(color(text)));
      if (includeBox[level]!) buffer.add(color(divider));
    }

    if (messageLog.data.isNotEmpty) {
      final data = messageLog.data.toString();

      _splitText(data).forEach((text) => buffer.add(color(text)));

      if (includeBox[level]!) buffer.add(color(divider));
    }

    return buffer;
  }

  /// Flutter truncates
  Iterable<String> _splitText(String text) =>
      RegExp('.{1,1023}').allMatches(text).map((e) => e.group(0) ?? '');
}
