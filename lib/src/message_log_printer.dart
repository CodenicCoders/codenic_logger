import 'package:codenic_logger/src/message_log.dart';
import 'package:logger/logger.dart';

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
class MessageLogPrinter extends PrettyPrinter {
  /// The default constructor.
  MessageLogPrinter({
    int stackTraceBeginIndex = 0,
    int methodCount = 2,
    int errorMethodCount = 8,
    int lineLength = 120,
    bool colors = true,
    bool printEmojis = true,
    bool printTime = true,
    Map<Level, bool> excludeBox = const {},
    bool noBoxingByDefault = false,
  })  : divider = '–' * lineLength,
        super(
          stackTraceBeginIndex: stackTraceBeginIndex,
          methodCount: methodCount,
          errorMethodCount: errorMethodCount,
          lineLength: lineLength,
          colors: colors,
          printEmojis: printEmojis,
          printTime: printTime,
          excludeBox: excludeBox,
          noBoxingByDefault: noBoxingByDefault,
        );

  /// The printed divider.
  final String divider;

  @override
  String? formatStackTrace(StackTrace? stackTrace, int methodCount) {
    final stackTraceSplit = stackTrace.toString().split('\n')
      ..removeWhere((str) => str.contains('package:codenic_logger'));

    final stackTraceSanitizedStr = stackTraceSplit.join('\n');

    return super.formatStackTrace(
      StackTrace.fromString(stackTraceSanitizedStr),
      methodCount,
    );
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
