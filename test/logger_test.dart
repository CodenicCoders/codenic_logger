import 'package:codenic_logger/codenic_logger.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockLogger extends Mock implements Logger {}

void main() {
  group(
    'Logger',
    () {
      group(
        'log levels',
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
              final message = MessageLog(id: 'lorep_ipsum');

              // Act
              logger.verbose(message);

              // Assert
              verify(() => mockLogger.v('identifier: lorep_ipsum')).called(1);
            },
          );

          test(
            'log debug',
            () {
              // Assign
              final message = MessageLog(id: 'lorep_ipsum');

              // Act
              logger.debug(message);

              // Assert
              verify(() => mockLogger.d('identifier: lorep_ipsum')).called(1);
            },
          );

          test(
            'log info',
            () {
              // Assign
              final message = MessageLog(id: 'lorep_ipsum');

              // Act
              logger.info(message);

              // Assert
              verify(() => mockLogger.i('identifier: lorep_ipsum')).called(1);
            },
          );

          test(
            'log warn',
            () {
              // Assign
              final message = MessageLog(id: 'lorep_ipsum');

              // Act
              logger.warn(message);

              // Assert
              verify(() => mockLogger.w('identifier: lorep_ipsum')).called(1);
            },
          );

          test(
            'log error',
            () {
              // Assign
              final message = MessageLog(id: 'lorep_ipsum');

              // Act
              logger.error(message);

              // Assert
              verify(() => mockLogger.e('identifier: lorep_ipsum')).called(1);
            },
          );

          test(
            'log wtf',
            () {
              // Assign
              final message = MessageLog(id: 'lorep_ipsum');

              // Act
              logger.wtf(message);

              // Assert
              verify(() => mockLogger.wtf('identifier: lorep_ipsum')).called(1);
            },
          );

          test(
            'log message with user ID',
            () {
              // Assign
              logger.userId = 'sample-uid';
              final message = MessageLog(
                id: 'lorep_ipsum',
                data: <String, dynamic>{'foo': 1},
              );

              // Act
              logger.info(message);

              // Assert
              verify(
                () => mockLogger.i(
                  'identifier: lorep_ipsum'
                  '\ndata: {__uid__: sample-uid, foo: 1}',
                ),
              ).called(1);
            },
          );
        },
      );

      group('constructor', () {
        test(
            'do not throw an error when default constructor values are '
            'initialized', () {
          // Assign
          CodenicLogger();

          // Act
          // Assert
          expect(true, true);
        });
      });
    },
  );
}
