import 'package:codenic_logger/codenic_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockPrinter extends Mock {
  void call(Object? object);
}

void main() {
  group(
    'Extended log output',
    () {
      test(
        'split long texts then print them',
        () {
          // Assign
          final mockPrinter = MockPrinter();
          final extendedLogOutput = ExtendedLogOutput(
            printer: mockPrinter,
            textLengthLimit: 5,
          );

          final outputEvent = OutputEvent(
            Level.verbose,
            ['lorep', 'ipsum', 'virbatim'],
          );

          // Act
          extendedLogOutput.output(outputEvent);

          // Assert
          verify(() => mockPrinter.call('lorep')).called(1);
          verify(() => mockPrinter.call('ipsum')).called(1);
          verify(() => mockPrinter.call('virba')).called(1);
          verify(() => mockPrinter.call('tim')).called(1);
        },
      );
    },
  );
}
