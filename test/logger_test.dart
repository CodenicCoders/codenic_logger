import 'dart:io';

import 'package:codenic_logger/codenic_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockLogger extends Mock implements Logger {}

class MockPrinter extends Mock {
  void call(Object? object);
}

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
            'should log verbose',
            () {
              // Assign
              final messageLog = MessageLog(id: 'lorep_ipsum');

              // Act
              logger.verbose(messageLog);

              // Assert
              verify(() => mockLogger.v(messageLog)).called(1);
            },
          );

          test(
            'should log debug',
            () {
              // Assign
              final messageLog = MessageLog(id: 'lorep_ipsum');

              // Act
              logger.debug(messageLog);

              // Assert
              verify(() => mockLogger.d(messageLog)).called(1);
            },
          );

          test(
            'should log info',
            () {
              // Assign
              final messageLog = MessageLog(id: 'lorep_ipsum');

              // Act
              logger.info(messageLog);

              // Assert
              verify(() => mockLogger.i(messageLog)).called(1);
            },
          );

          test(
            'should log warn',
            () {
              // Assign
              final messageLog = MessageLog(id: 'lorep_ipsum');

              // Act
              logger.warn(messageLog);

              // Assert
              verify(() => mockLogger.w(messageLog)).called(1);
            },
          );

          test(
            'should log error',
            () {
              // Assign
              final messageLog = MessageLog(id: 'lorep_ipsum');

              // Act
              logger.error(messageLog);

              // Assert
              verify(() => mockLogger.e(messageLog)).called(1);
            },
          );

          test(
            'should log wtf',
            () {
              // Assign
              final messageLog = MessageLog(id: 'lorep_ipsum');

              // Act
              logger.wtf(messageLog);

              // Assert
              verify(() => mockLogger.wtf(messageLog)).called(1);
            },
          );

          test(
            'should log message with user ID',
            () {
              // Assign
              logger.userId = 'sample-uid';
              final messageLog = MessageLog(
                id: 'lorep_ipsum',
                data: <String, dynamic>{'foo': 1},
              );

              // Act
              logger.info(messageLog);

              // Assert
              verify(
                () => mockLogger.i(
                  messageLog.copyWith(
                    data: <String, dynamic>{
                      '__uid__': 'sample-uid',
                      ...messageLog.data
                    },
                  ),
                ),
              ).called(1);
            },
          );
        },
      );

      group(
        'error',
        () {
          setUpAll(() {
            registerFallbackValue(StackTrace.empty);
          });

          test(
            'should log exception',
            () {
              // Given
              final mockLogger = MockLogger();
              final logger = CodenicLogger(logger: mockLogger);
              final messageLog = MessageLog(id: 'sample');

              // When
              try {
                throw const SocketException('no-internet');
              } catch (exception, stackTrace) {
                logger.error(
                  messageLog,
                  error: exception,
                  stackTrace: stackTrace,
                );
              }

              // Then
              verify(
                () => mockLogger.e(
                  messageLog,
                  const SocketException('no-internet'),
                  any<StackTrace>(),
                ),
              ).called(1);
            },
          );
        },
      );

      group('constructor', () {
        test(
            'should not throw an error when default constructor values are '
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
