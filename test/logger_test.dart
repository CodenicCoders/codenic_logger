import 'package:codenic_logger/codenic_logger.dart';
import 'package:codenic_logger/src/message_log_printer.dart';
import 'package:codenic_logger/src/untruncated_log_output.dart';
import 'package:logger/logger.dart';
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
            'log verbose',
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
            'log debug',
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
            'log info',
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
            'log warn',
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
            'log error',
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
            'log wtf',
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
            'log message with user ID',
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

        test(
          'should untruncate text',
          () {
            final mockPrinter = MockPrinter();

            // Given
            final untruncatedLogOutput = UntruncatedLogOutput(
              printer: mockPrinter,
              textLengthLimit: 5,
            );

            final logger = Logger(
              output: untruncatedLogOutput,
              printer: MessageLogPrinter(),
            );

            final codenicLogger = CodenicLogger(logger: logger);

            final messageLog =
                MessageLog(id: 'sample-id', message: 'lorepipsum');

            // When
            codenicLogger.info(messageLog);

            // Then
            verify(() => mockPrinter.call('lorep')).called(1);
            verify(() => mockPrinter.call('ipsum')).called(1);
          },
        );
      });
    },
  );
}
