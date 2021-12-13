import 'package:codenic_logger/codenic_logger.dart';
import 'package:codenic_logger/src/message_log_printer.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Message log printer',
    () {
      group(
        'log',
        () {
          test(
            'should print more line when error occurs',
            () {
              // Given
              final messageLogPrinter = MessageLogPrinter(
                methodCount: 3,
                errorMethodCount: 4,
              );

              final messageLog = MessageLog(
                id: 'sample',
                message: 'lorep',
                data: <String, dynamic>{'aliquam': 'arcu'},
              );

              final logEvent = LogEvent(Level.info, messageLog, null, null);

              final errorLogEvent = LogEvent(
                Level.error,
                messageLog,
                Exception(),
                StackTrace.current,
              );

              // When

              final output = messageLogPrinter.log(logEvent);
              final errorOutput = messageLogPrinter.log(errorLogEvent);

              // Then
              expect(errorOutput.length > output.length, true);
            },
          );
        },
      );
    },
  );
}
