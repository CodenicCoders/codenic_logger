import 'package:codenic_logger/codenic_logger.dart';
import 'package:codenic_logger/src/message_log.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockLogger extends Mock implements Logger {}

void main() {
  group(
    'Logger',
    () {
      group(
        'log message',
        () {
          late MockLogger mockLogger;
          late CodenicLogger logger;

          setUp(
            () {
              mockLogger = MockLogger();
              logger = CodenicLogger(logger: mockLogger);
            },
          );

          test(
            'log verbose',
            () {
              // Assign
              final message = MessageLog(message: 'Test message');

              // Act
              logger.verbose(message);

              // Assert
              verify(() => mockLogger.v('Test message')).called(1);
            },
          );

          test(
            'log debug',
            () {
              // Assign
              final message = MessageLog(message: 'Test message');

              // Act
              logger.debug(message);

              // Assert
              verify(() => mockLogger.d('Test message')).called(1);
            },
          );

          test(
            'log info',
            () {
              // Assign
              final message = MessageLog(message: 'Test message');

              // Act
              logger.info(message);

              // Assert
              verify(() => mockLogger.i('Test message')).called(1);
            },
          );

          test(
            'log warn',
            () {
              // Assign
              final message = MessageLog(message: 'Test message');

              // Act
              logger.warn(message);

              // Assert
              verify(() => mockLogger.w('Test message')).called(1);
            },
          );

          test(
            'log error',
            () {
              // Assign
              final message = MessageLog(message: 'Test message');

              // Act
              logger.error(message);

              // Assert
              verify(() => mockLogger.e('Test message')).called(1);
            },
          );

          test(
            'log wtf',
            () {
              // Assign
              final message = MessageLog(message: 'Test message');

              // Act
              logger.wtf(message);

              // Assert
              verify(() => mockLogger.wtf('Test message')).called(1);
            },
          );

          test(
            'log message with details',
            () {
              // Assign
              final message =
                  MessageLog(message: 'Test message', details: 'Test details');

              // Act
              logger.info(message);

              // Assert
              verify(() => mockLogger.i('Test message – Test details'))
                  .called(1);
            },
          );

          test(
            'log message with data',
            () {
              // Assign
              final message = MessageLog(
                message: 'Test message',
                details: 'Test details',
                data: <String, dynamic>{'foo': 1},
              );

              // Act
              logger.info(message);

              // Assert
              verify(() => mockLogger.i('Test message – Test details {foo: 1}'))
                  .called(1);
            },
          );

          test(
            'log message with user ID',
            () {
              // Assign
              logger.userId = 'sample-uid';
              final message = MessageLog(
                message: 'Test message',
                details: 'Test details',
                data: <String, dynamic>{'foo': 1},
              );

              // Act
              logger.info(message);

              // Assert
              verify(
                () => mockLogger.i(
                  'Test message – Test details {__uid__: sample-uid, foo: 1}',
                ),
              ).called(1);
            },
          );
        },
      );

      group(
        'constructor',
        () {
          test(
              'do not throw an error when default constructor values are '
              'initialized', () {
            // Assign
            CodenicLogger();

            // Act
            // Assert
            expect(true, true);
          });
        },
      );
    },
  );
}
