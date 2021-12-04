import 'package:codenic_logger/codenic_logger.dart';

final codenicLogger = CodenicLogger();
final messageLog = MessageLog(
  message: 'Sample message',
  data: <String, dynamic>{'foo': false, 'lorep': 'ipsum'},
);

void main() {
  // To run, type `dart --enable-asserts example/main.dart`.

  verboseWithUserId();
  verbose();
  debug();
  info();
  warn();
  error();
  wtf();
}

void verboseWithUserId() {
  messageLog.details = 'verbose';
  codenicLogger
    ..userId = 'sample-uid'
    ..info(messageLog)
    ..userId = null;
}

void verbose() {
  messageLog.details = 'verbose';
  codenicLogger.verbose(messageLog);
}

void debug() {
  messageLog.details = 'debug';
  codenicLogger.debug(messageLog);
}

void info() {
  messageLog.details = 'info';
  codenicLogger.info(messageLog);
}

void warn() {
  try {
    throw Exception('Test exception');
  } catch (exception, stackTrace) {
    messageLog.details = 'warn';
    codenicLogger.warn(messageLog, error: exception, stackTrace: stackTrace);
  }
}

void error() {
  try {
    throw Exception('Test exception');
  } catch (exception, stackTrace) {
    messageLog.details = 'error';
    codenicLogger.error(messageLog, error: exception, stackTrace: stackTrace);
  }
}

void wtf() {
  try {
    throw Exception('Test exception');
  } catch (exception, stackTrace) {
    messageLog.details = 'wtf';
    codenicLogger.wtf(messageLog, error: exception, stackTrace: stackTrace);
  }
}
