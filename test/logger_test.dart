import 'package:codenic_logger/codenic_logger.dart';
import 'package:test/test.dart';

typedef PrinterCallback = List<String> Function(
  Level level,
  dynamic message,
  dynamic error,
  StackTrace? stackTrace,
);

class CallbackPrinter extends MessageLogPrinter {
  CallbackPrinter({required this.callback});

  final PrinterCallback callback;

  @override
  List<String> log(LogEvent event) {
    return callback(
      event.level,
      event.message,
      event.error,
      event.stackTrace,
    );
  }
}

void main() {
  group(
    'Logger',
    () {
      Level? printedLevel;
      dynamic printedMessage;
      dynamic printedError;
      StackTrace? printedStackTrace;

      final callbackPrinter = CallbackPrinter(
        callback: (level, message, error, stackTrace) {
          printedLevel = level;
          printedMessage = message;
          printedError = error;
          printedStackTrace = stackTrace;

          return [];
        },
      );

      late CodenicLogger logger;

      setUp(() {
        logger = CodenicLogger(printer: callbackPrinter);

        printedLevel = null;
        printedMessage = null;
        printedError = null;
        printedStackTrace = null;
      });

      group(
        'log levels',
        () {
          test(
            'should log verbose',
            () {
              // Assign
              final messageLog = MessageLog(id: 'lorep_ipsum');

              // Act
              logger.verbose(messageLog);

              // Assert
              expect(printedLevel, Level.verbose);
              expect(printedMessage, messageLog);
              expect(printedError, isNull);
              expect(printedStackTrace, isNull);
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
              expect(printedLevel, Level.debug);
              expect(printedMessage, messageLog);
              expect(printedError, isNull);
              expect(printedStackTrace, isNull);
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
              expect(printedLevel, Level.info);
              expect(printedMessage, messageLog);
              expect(printedError, isNull);
              expect(printedStackTrace, isNull);
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
              expect(printedLevel, Level.warning);
              expect(printedMessage, messageLog);
              expect(printedError, isNull);
              expect(printedStackTrace, isNull);
            },
          );

          test(
            'should log error',
            () {
              // Assign
              final messageLog = MessageLog(id: 'lorep_ipsum');
              final error = Exception();

              // Act
              logger.error(messageLog, error: error);

              // Assert
              expect(printedLevel, Level.error);
              expect(printedMessage, messageLog);
              expect(printedError, error);
              expect(printedStackTrace, isNull);
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
              expect(printedLevel, Level.wtf);
              expect(printedMessage, messageLog);
              expect(printedError, isNull);
              expect(printedStackTrace, isNull);
            },
          );

          test(
            'should log message with user ID',
            () {
              // Assign
              final messageLog = MessageLog(
                id: 'lorep_ipsum',
                data: <String, dynamic>{'foo': 1},
              );

              // Act
              logger
                ..userId = 'sample-uid'
                ..info(messageLog);

              // Assert
              expect(
                printedMessage,
                messageLog.copyWith(
                  data: <String, dynamic>{
                    '__uid__': 'sample-uid',
                    ...messageLog.data
                  },
                ),
              );
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
