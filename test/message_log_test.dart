import 'package:codenic_logger/codenic_logger.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Message log',
    () {
      group(
        'copy with',
        () {
          test(
            'preserve object when no changes',
            () {
              // Assign
              const messageLog = MessageLog(message: 'lorep', details: 'ipsum');

              // Act
              final newMessageLog = messageLog.copyWith();

              // Assert
              expect(newMessageLog.toString(), 'lorep – ipsum');
            },
          );

          test(
            'replace values',
            () {
              // Assign
              const messageLog = MessageLog(message: 'lorep', details: 'ipsum');

              // Act
              final newMessageLog =
                  messageLog.copyWith(message: 'convallis', details: 'dolor');

              // Assert
              expect(newMessageLog.toString(), 'convallis – dolor');
            },
          );
        },
      );

      group(
        'json',
        () {
          test(
            'instantiate object from json',
            () {
              // Assign
              const json = '{"message":"lorep","details":"ipsum"}';

              // Act
              final messageLog = MessageLog.fromJson(json);

              // Assert
              expect(messageLog.toString(), 'lorep – ipsum');
            },
          );

          test(
            'convert object to json',
            () {
              // Assign
              const json = '{"message":"lorep","details":"ipsum"}';

              // Act
              final messageLog = MessageLog.fromJson(json);

              // Assert
              expect(messageLog.toJson(), json);
            },
          );
        },
      );

      group(
        'map',
        () {
          test(
            'instantiate object from map',
            () {
              // Assign
              final map = {'message': 'lorep', 'details': 'ipsum'};

              // Act
              final messageLog = MessageLog.fromMap(map);

              // Assert
              expect(messageLog.toString(), 'lorep – ipsum');
            },
          );

          test(
            'convert object to map',
            () {
              // Assign
              final map = {'message': 'lorep', 'details': 'ipsum'};

              // Act
              final messageLog = MessageLog.fromMap(map);

              // Assert
              expect(messageLog.toMap(), map);
            },
          );
        },
      );
    },
  );
}
