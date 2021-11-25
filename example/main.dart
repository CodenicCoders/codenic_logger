import 'package:codenic_logger/codenic_logger.dart';

final logger = Logger();
const messageLog = MessageLog(message: 'Sample message');

void main() {
  // To run, type `dart --enable-asserts example/main.dart`.

  info();
  debug();
  warn();
  error();
}

void info() {
  try {
    throw Exception('Test exception');
  } catch (exception, stackTrace) {
    logger.info(
      messageLog.copyWith(details: 'A debug log'),
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
    logger.debug(
      messageLog.copyWith(details: 'A debug log'),
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
    logger.warn(
      messageLog.copyWith(details: 'A debug log'),
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
    logger.error(
      messageLog.copyWith(details: 'A debug log'),
      data: {'foo': 'bar'},
      error: exception,
      stackTrace: stackTrace,
    );
  }
}
