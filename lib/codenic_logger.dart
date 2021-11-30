import 'package:logger/logger.dart' as logs;
import 'package:meta/meta.dart';

import './src/message_log.dart';

export './src/message_log.dart';

class CodenicLogger {
  CodenicLogger({
    logs.Logger? logger,
  }) : _logger = logger ?? logs.Logger(printer: logs.PrettyPrinter());

  /// An instance of the [logger package](https://pub.dev/packages/logger) used
  /// for generating log outputs.
  ///
  /// A new logger can be provided to customize the output.
  final logs.Logger _logger;

  /// Associates log messages with the user ID.
  String? userId;

  /// Formats the [MessageLog] and the data for logging.
  ///
  /// If the [userId] is not `null`, then it will be displayed inside the
  /// `data` section.
  String _formatMessageData(MessageLog message, Map<String, dynamic>? data) =>
      data != null
          ? '$message ${{if (userId != null) '__uid__': userId, ...data}}'
          : '$message';

  /// Logs a message at verbose level.
  ///
  /// Additional [data] provides more context about the log message.
  ///
  /// The [error] refers to the caught exception or error.
  ///
  /// The [stackTrace] conveys information about the call sequence that
  /// triggered the [error].
  @mustCallSuper
  void verbose(
    MessageLog message, {
    Map<String, dynamic>? data,
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      _logger.v(_formatMessageData(message, data), error, stackTrace);

  /// Logs a message at debug level.
  ///
  /// Additional [data] provides more context about the log message.
  ///
  /// The [error] refers to the caught exception or error.
  ///
  /// The [stackTrace] conveys information about the call sequence that
  /// triggered the [error].
  @mustCallSuper
  void debug(
    MessageLog message, {
    Map<String, dynamic>? data,
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      _logger.d(_formatMessageData(message, data), error, stackTrace);

  /// Logs a message at info level.
  ///
  /// Additional [data] provides more context about the log message.
  ///
  /// The [error] refers to the caught exception or error.
  ///
  /// The [stackTrace] conveys information about the call sequence that
  /// triggered the [error].
  @mustCallSuper
  void info(
    MessageLog message, {
    Map<String, dynamic>? data,
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      _logger.i(_formatMessageData(message, data), error, stackTrace);

  /// Logs a message at warn level.
  ///
  /// Additional [data] provides more context about the log message.
  ///
  /// The [error] refers to the caught exception or error.
  ///
  /// The [stackTrace] conveys information about the call sequence that
  /// triggered the [error].
  @mustCallSuper
  void warn(
    MessageLog message, {
    Map<String, dynamic>? data,
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      _logger.w(_formatMessageData(message, data), error, stackTrace);

  /// Logs a message at error level.
  ///
  /// Additional [data] provides more context about the log message.
  ///
  /// The [error] refers to the caught exception or error.
  ///
  /// The [stackTrace] conveys information about the call sequence that
  /// triggered the [error].
  @mustCallSuper
  void error(
    MessageLog message, {
    Map<String, dynamic>? data,
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      _logger.e(_formatMessageData(message, data), error, stackTrace);

  /// Logs a message at wtf level.
  ///
  /// Additional [data] provides more context about the log message.
  ///
  /// The [error] refers to the caught exception or error.
  ///
  /// The [stackTrace] conveys information about the call sequence that
  /// triggered the [error].
  @mustCallSuper
  void wtf(
    MessageLog message, {
    Map<String, dynamic>? data,
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      _logger.wtf(_formatMessageData(message, data), error, stackTrace);
}
