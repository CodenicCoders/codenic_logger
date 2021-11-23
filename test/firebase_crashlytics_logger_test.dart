import 'package:codenic_logger/src/firebase_crashlytics_logger.dart';
import 'package:codenic_logger/src/logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart' as logs;
import 'package:mockito/mockito.dart';

class MockFirebaseCrashlytics extends Mock implements FirebaseCrashlytics {}

class MockLogger extends Mock implements logs.Logger {}

void main() {
  late MockFirebaseCrashlytics mockFirebaseCrashlytics;
  late MockLogger mockLogger;

  late FirebaseCrashlyticsLogger logger;

  setUp(
    () {
      mockFirebaseCrashlytics = MockFirebaseCrashlytics();
      mockLogger = MockLogger();
      logger = FirebaseCrashlyticsLogger(
        firebaseCrashlytics: mockFirebaseCrashlytics,
        logger: mockLogger,
      );
    },
  );

  test(
    'Send error message to Crashlytics',
    () {
      // Assign
      const message =
          MessageLog(message: 'Test message', details: 'Test details');
      const data = {'foo': 1};

      final exception = Exception();
      final stackTrace = StackTrace.fromString('Sample stack trace');

      // Act
      logger.error(
        message,
        data: data,
        error: exception,
        stackTrace: stackTrace,
      );

      // Assert
      verify(mockFirebaseCrashlytics.recordError(
        exception,
        stackTrace,
        reason: 'Test message – Test details {foo: 1}',
      )).called(1);
    },
  );
}
