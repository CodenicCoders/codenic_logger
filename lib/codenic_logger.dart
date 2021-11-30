import 'package:logger/logger.dart' as logs;
import 'package:meta/meta.dart';

import './src/message_log.dart';

export './src/message_log.dart';

class CodenicLogger {
  CodenicLogger({
    logs.Logger? logger,
  }) : _logger = logger ?? logs.Logger(printer: logs.PrettyPrinter());

  final logs.Logger _logger;

  String? userId;

  String formatMessageData(MessageLog message, Map<String, dynamic>? data) =>
      data != null
          ? '$message ${{if (userId != null) '__uid__': userId, ...data}}'
          : '$message';

  @mustCallSuper
  void verbose(
    MessageLog message, {
    Map<String, dynamic>? data,
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      _logger.v(formatMessageData(message, data), error, stackTrace);

  @mustCallSuper
  void debug(
    MessageLog message, {
    Map<String, dynamic>? data,
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      _logger.d(formatMessageData(message, data), error, stackTrace);

  @mustCallSuper
  void info(
    MessageLog message, {
    Map<String, dynamic>? data,
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      _logger.i(formatMessageData(message, data), error, stackTrace);

  @mustCallSuper
  void warn(
    MessageLog message, {
    Map<String, dynamic>? data,
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      _logger.w(formatMessageData(message, data), error, stackTrace);

  @mustCallSuper
  void error(
    MessageLog message, {
    Map<String, dynamic>? data,
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      _logger.e(formatMessageData(message, data), error, stackTrace);

  @mustCallSuper
  void wtf(
    MessageLog message, {
    Map<String, dynamic>? data,
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      _logger.wtf(formatMessageData(message, data), error, stackTrace);
}
