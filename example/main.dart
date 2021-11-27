import 'package:codenic_logger/codenic_logger.dart';

final codenicLogger = CodenicLogger();
const messageLog = MessageLog(message: 'Sample message');

void main() {
  // To run, type `dart --enable-asserts example/main.dart`.

  verbose();
  debug();
  info();
  warn();
  error();
  wtf();
}

void verbose() {
  try {
    throw Exception('Test exception');
  } catch (exception, stackTrace) {
    codenicLogger.verbose(
      messageLog.copyWith(details: 'verbose'),
      data: {'foo': 'bar'},
      error: exception,
      stackTrace: stackTrace,
    );
  }
}

void debug() {
  try {
    throw Exception('Test exception');
  } catch (exception, stackTrace) {
    codenicLogger.debug(
      messageLog.copyWith(details: 'debug'),
      data: {'foo': 'bar'},
      error: exception,
      stackTrace: stackTrace,
    );
  }
}

void info() {
  try {
    throw Exception('Test exception');
  } catch (exception, stackTrace) {
    codenicLogger.info(
      messageLog.copyWith(details: 'info'),
      data: {'foo': 'bar'},
      error: exception,
      stackTrace: stackTrace,
    );
  }
}

void warn() {
  try {
    throw Exception('Test exception');
  } catch (exception, stackTrace) {
    codenicLogger.warn(
      messageLog.copyWith(details: 'warn'),
      data: {'foo': 'bar'},
      error: exception,
      stackTrace: stackTrace,
    );
  }
}

void error() {
  try {
    throw Exception('Test exception');
  } catch (exception, stackTrace) {
    codenicLogger.error(
      messageLog.copyWith(details: 'error'),
      data: {'foo': 'bar'},
      error: exception,
      stackTrace: stackTrace,
    );
  }
}

void wtf() {
  try {
    throw Exception('Test exception');
  } catch (exception, stackTrace) {
    codenicLogger.wtf(
      messageLog.copyWith(details: 'What the f---'),
      data: {'foo': 'bar'},
      error: exception,
      stackTrace: stackTrace,
    );
  }
}
