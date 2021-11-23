import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart' as logs;

import './logger.dart';

/// A logger that sends messages to the console for all logs and Firebase
/// Crashlytics for error reports.
class FirebaseCrashlyticsLogger extends Logger {
  FirebaseCrashlyticsLogger({
    required FirebaseCrashlytics firebaseCrashlytics,
    logs.Logger? logger,
  })  : _firebaseCrashlytics = firebaseCrashlytics,
        super(logger: logger);

  /// An instance of [FirebaseCrashlytics].
  ///
  /// See https://pub.dev/packages/firebase_crashlytics.
  final FirebaseCrashlytics _firebaseCrashlytics;

  /// Sets a user identifier that will be associated with subsequent fatal and
  /// non-fatal reports in Firebase Crashlytics.
  Future<void> setUserId(String? userId) =>
      _firebaseCrashlytics.setUserIdentifier(userId ?? '');

  /// Logs an error in the debug console and submits it to
  /// [FirebaseCrashlytics].
  @override
  void error(
    MessageLog message, {
    Map<String, dynamic>? data,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    super.error(message, data: data, error: error, stackTrace: stackTrace);

    _firebaseCrashlytics.recordError(
      error,
      stackTrace,
      reason: formatMessageData(message, data),
    );
  }
}
