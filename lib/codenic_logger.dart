import 'package:codenic_logger/src/message_log.dart';
import 'package:codenic_logger/src/message_log_printer.dart';
import 'package:logger/logger.dart' as logs;
import 'package:meta/meta.dart';

export 'package:codenic_logger/src/message_log.dart';
export 'package:codenic_logger/src/message_log_printer.dart';
export 'package:logger/logger.dart';

/// {@template CodenicLogger}
/// 
/// Creates a logger that appropriately displays information from a
/// [MessageLog].
/// 
/// {@endtemplate}
class CodenicLogger {
  /// {@macro CodenicLogger}
  CodenicLogger({logs.Logger? logger})
      : _logger = logger ?? logs.Logger(printer: MessageLogPrinter());

  /// An instance of the [logger package](https://pub.dev/packages/logger) used
  /// for generating log outputs.
  ///
  /// To customize the log output, provide a custom logger.
  final logs.Logger _logger;

  /// Associates the log messages with this user ID.
  String? userId;

  /// If the [userId] is not `null`, then this appends the [userId] in the
  /// [messageLog]'s data. Otherwise, [messageLog] is returned without any
  /// changes.
  MessageLog _tryAppendUserIdToMessageLog(MessageLog messageLog) =>
      userId != null
          ? messageLog.copyWith(
              data: <String, dynamic>{'__uid__': userId, ...messageLog.data},
            )
          : messageLog;

  /// Logs a message at verbose level.
  ///
  /// The [error] refers to the caught exception or error.
  ///
  /// The [stackTrace] conveys information about the call sequence that
  /// triggered the [error].
  @mustCallSuper
  void verbose(
    MessageLog messageLog, {
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      _logger.v(
        _tryAppendUserIdToMessageLog(messageLog),
        error,
        stackTrace,
      );

  /// Logs a message at debug level.
  ///
  /// The [error] refers to the caught exception or error.
  ///
  /// The [stackTrace] conveys information about the call sequence that
  /// triggered the [error].
  @mustCallSuper
  void debug(MessageLog messageLog, {dynamic error, StackTrace? stackTrace}) =>
      _logger.d(
        _tryAppendUserIdToMessageLog(messageLog),
        error,
        stackTrace,
      );

  /// Logs a message at info level.
  ///
  /// The [error] refers to the caught exception or error.
  ///
  /// The [stackTrace] conveys information about the call sequence that
  /// triggered the [error].
  @mustCallSuper
  void info(MessageLog messageLog, {dynamic error, StackTrace? stackTrace}) =>
      _logger.i(
        _tryAppendUserIdToMessageLog(messageLog),
        error,
        stackTrace,
      );

  /// Logs a message at warn level.
  ///
  /// The [error] refers to the caught exception or error.
  ///
  /// The [stackTrace] conveys information about the call sequence that
  /// triggered the [error].
  @mustCallSuper
  void warn(MessageLog messageLog, {dynamic error, StackTrace? stackTrace}) =>
      _logger.w(
        _tryAppendUserIdToMessageLog(messageLog),
        error,
        stackTrace,
      );

  /// Logs a message at error level.
  ///
  /// The [error] refers to the caught exception or error.
  ///
  /// The [stackTrace] conveys information about the call sequence that
  /// triggered the [error].
  @mustCallSuper
  void error(MessageLog messageLog, {dynamic error, StackTrace? stackTrace}) =>
      _logger.e(
        _tryAppendUserIdToMessageLog(messageLog),
        error,
        stackTrace,
      );

  /// Logs a message at wtf level.
  ///
  /// The [error] refers to the caught exception or error.
  ///
  /// The [stackTrace] conveys information about the call sequence that
  /// triggered the [error].
  @mustCallSuper
  void wtf(MessageLog messageLog, {dynamic error, StackTrace? stackTrace}) =>
      _logger.wtf(
        _tryAppendUserIdToMessageLog(messageLog),
        error,
        stackTrace,
      );
}
