import 'package:codenic_logger/src/message_log.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Message log',
    () {
      group(
        'from json',
        () {
          test(
            'construct object with complete fields from json',
            () {
              // Assign
              const json = '{"message":"lorep",'
                  '"details":"ipsum",'
                  '"data":{"fermentum": "enim"}}';

              // Act
              final messageLog = MessageLog.fromJson(json);

              // Assert
              expect(messageLog.toString(), 'lorep – ipsum {fermentum: enim}');
            },
          );

          test(
            'construct object with no details from json',
            () {
              // Assign
              const json = '{"message":"lorep","data":{"fermentum": "enim"}}';

              // Act
              final messageLog = MessageLog.fromJson(json);

              // Assert
              expect(messageLog.toString(), 'lorep {fermentum: enim}');
            },
          );

          test(
            'construct object with no data from json',
            () {
              // Assign
              const json = '{"message":"lorep","details":"ipsum"}';

              // Act
              final messageLog = MessageLog.fromJson(json);

              // Assert
              expect(messageLog.toString(), 'lorep – ipsum');
            },
          );
        },
      );

      group(
        'to json',
        () {
          test(
            'convert object with complete fields to json',
            () {
              // Assign
              final messageLog = MessageLog(
                message: 'lorep',
                details: 'ipsum',
                data: <String, dynamic>{'fermentum': 'enim'},
              );

              // Act
              final json = messageLog.toJson();

              // Assert
              expect(
                json,
                '{"message":"lorep",'
                '"details":"ipsum",'
                '"data":{"fermentum":"enim"}}',
              );
            },
          );

          test(
            'convert object with no details to json',
            () {
              // Assign
              final messageLog = MessageLog(
                message: 'lorep',
                data: <String, dynamic>{'fermentum': 'enim'},
              );

              // Act
              final json = messageLog.toJson();

              // Assert
              expect(
                json,
                '{"message":"lorep",'
                '"details":null,'
                '"data":{"fermentum":"enim"}}',
              );
            },
          );

          test(
            'convert object with no data to json',
            () {
              // Assign
              final messageLog = MessageLog(message: 'lorep', details: 'ipsum');

              // Act
              final json = messageLog.toJson();

              // Assert
              expect(
                json,
                '{"message":"lorep",'
                '"details":"ipsum",'
                '"data":null}',
              );
            },
          );
        },
      );

      group(
        'from map',
        () {
          test(
            'construct object with complete fields from map',
            () {
              // Assign
              final map = {
                'message': 'lorep',
                'details': 'ipsum',
                'data': {'arcu': true, 'dictum': 42},
              };

              // Act
              final messageLog = MessageLog.fromMap(map);

              // Assert
              expect(
                messageLog.toString(),
                'lorep – ipsum {arcu: true, dictum: 42}',
              );
            },
          );

          test(
            'construct object with no details from map',
            () {
              // Assign
              final map = {
                'message': 'lorep',
                'data': {'arcu': true, 'dictum': 42},
              };

              // Act
              final messageLog = MessageLog.fromMap(map);

              // Assert
              expect(
                messageLog.toString(),
                'lorep {arcu: true, dictum: 42}',
              );
            },
          );

          test(
            'construct object with no data from map',
            () {
              // Assign
              final map = {'message': 'lorep', 'details': 'ipsum'};

              // Act
              final messageLog = MessageLog.fromMap(map);

              // Assert
              expect(
                messageLog.toString(),
                'lorep – ipsum',
              );
            },
          );
        },
      );

      group(
        'to map',
        () {
          test(
            'convert object with complete fields to map',
            () {
              // Assign
              final messageLog = MessageLog(
                message: 'lorep',
                details: 'ipsum',
                data: <String, dynamic>{'arcu': true, 'dictum': 42},
              );

              // Act
              final map = messageLog.toMap();

              // Assert
              expect(
                map,
                {
                  'message': 'lorep',
                  'details': 'ipsum',
                  'data': <String, dynamic>{'arcu': true, 'dictum': 42},
                },
              );
            },
          );

          test(
            'convert object with no details to map',
            () {
              // Assign
              final messageLog = MessageLog(
                message: 'lorep',
                data: <String, dynamic>{'arcu': true, 'dictum': 42},
              );

              // Act
              final map = messageLog.toMap();

              // Assert
              expect(
                map,
                {
                  'message': 'lorep',
                  'details': null,
                  'data': <String, dynamic>{'arcu': true, 'dictum': 42},
                },
              );
            },
          );

          test(
            'convert object with no data to map',
            () {
              // Assign
              final messageLog = MessageLog(message: 'lorep', details: 'ipsum');

              // Act
              final map = messageLog.toMap();

              // Assert
              expect(
                map,
                {
                  'message': 'lorep',
                  'details': 'ipsum',
                  'data': null,
                },
              );
            },
          );
        },
      );

      group(
        'copy with',
        () {
          test(
            'copy object with new message',
            () {
              // Assign
              final messageLog = MessageLog(
                message: 'lorep',
                details: 'ipsum',
                data: <String, dynamic>{'arcu': true, 'dictum': 42},
              );

              // Act
              final newMessageLog = messageLog.copyWith(
                message: 'nunc',
              );

              // Assert
              expect(
                newMessageLog.toString(),
                'nunc – ipsum {arcu: true, dictum: 42}',
              );
            },
          );

          test(
            'copy object with new details',
            () {
              // Assign
              final messageLog = MessageLog(
                message: 'lorep',
                details: 'ipsum',
                data: <String, dynamic>{'arcu': true, 'dictum': 42},
              );

              // Act
              final newMessageLog = messageLog.copyWith(
                details: 'vel',
              );

              // Assert
              expect(
                newMessageLog.toString(),
                'lorep – vel {arcu: true, dictum: 42}',
              );
            },
          );

          test(
            'copy object with new data',
            () {
              // Assign
              final messageLog = MessageLog(
                message: 'lorep',
                details: 'ipsum',
                data: <String, dynamic>{'arcu': true, 'dictum': 42},
              );

              // Act
              final newMessageLog = messageLog.copyWith(
                data: <String, dynamic>{},
              );

              // Assert
              expect(
                newMessageLog.toString(),
                'lorep – ipsum',
              );
            },
          );
        },
      );
    },
  );
}
