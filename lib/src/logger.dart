import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart' as logs;

part 'message_log.dart';

class Logger {
  Logger({
    logs.Logger? logger,
  }) : _logger = logger ?? logs.Logger(printer: logs.PrettyPrinter());

  final logs.Logger _logger;

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

  /// Logs an error in the debug console and submits it to
  /// [FirebaseCrashlytics].
  @mustCallSuper
  void error(
    MessageLog message, {
    Map<String, dynamic>? data,
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      _logger.e(formatMessageData(message, data), error, stackTrace);

  String formatMessageData(MessageLog message, data) =>
      data != null ? '$message $data' : '$message';
}
