import 'package:codenic_logger/src/codenic_logger.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockLogger extends Mock implements Logger {}

void main() {
  late MockLogger mockLogger;
  late CodenicLogger logger;

  setUp(
    () {
      mockLogger = MockLogger();
      logger = CodenicLogger(logger: mockLogger);
    },
  );

  test(
    'Log message',
    () {
      // Assign
      const message = MessageLog(message: 'Test message');

      // Act
      logger.info(message);

      // Assert
      verify(() => mockLogger.i('Test message')).called(1);
    },
  );

  test(
    'Log message with details',
    () {
      // Assign
      const message =
          MessageLog(message: 'Test message', details: 'Test details');

      // Act
      logger.info(message);

      // Assert
      verify(() => mockLogger.i('Test message – Test details')).called(1);
    },
  );

  test(
    'Log message with data',
    () {
      // Assign
      const message =
          MessageLog(message: 'Test message', details: 'Test details');
      const data = {'foo': 1};

      // Act
      logger.info(message, data: data);

      // Assert
      verify(() => mockLogger.i('Test message – Test details {foo: 1}'))
          .called(1);
    },
  );
}
