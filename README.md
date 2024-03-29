![GitHub Workflow Status](https://img.shields.io/github/workflow/status/CodenicCoders/codenic_logger/main)
![CodeCov](https://codecov.io/gh/CodenicCoders/codenic_logger/branch/master/graph/badge.svg)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
![GitHub](https://img.shields.io/github/license/CodenicCoders/codenic_logger)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/CodenicCoders/codenic_logger)
![Pub Version](https://img.shields.io/pub/v/codenic_logger?color=blue)

A logger extension for providing structured and mutable log messages.

> This uses the [logger](https://github.com/leisim/logger) package to produce log messages.

<img src="https://github.com/CodenicCoders/codenic_logger/blob/master/doc/assets/sample_1.webp?raw=true" alt="Sample detailed log messages" width=640/>

## Features

Use this package in your app to:

- Structurally create mutable log messages.
- Initialize log messages early, populate it with data throughout the code execution, then printing them at a later point in time.
- Log messages on multiple log levels – verbose, debug, info, warning, error and wtf.
- Automatically add a user ID to all log data upon logging.

## Getting started

To get started, just create a Codenic logger instance:

```dart
final codenicLogger = CodenicLogger();

const messageLog = MessageLog(
  id: 'save_user_info',
  message: 'Save completed',
  data: { 'name': 'Jayce', 'age': 24 },
);

codenicLogger.info(messageLog);
```

## Usage

This section has examples of code for the following tasks:

- [Logging with different log levels](#logging-with-different-log-levels)
- [Logging an exception](#logging-an-exception)
- [Setting a user ID](#setting-a-user-id)
- [Updating message log properties](#updating-message-log-properties)
- [Customizing the logger](#customizing-the-logger)
- [Blocklisting stack trace line](#blocklisting-stack-trace-line)
- [Sample Integration: Firebase Crashlytics](#sample-integration-firebase-crashlytics)

### Logging with different log levels

```dart
final codenicLogger = CodenicLogger();

final messageLog = MessageLog(id: 'log_levels');

codenicLogger
  ..verbose(messageLog..message = 'Verbose log success')
  ..debug(messageLog..message = 'Debug log success')
  ..info(messageLog..message = 'Info log success')
  ..warn(messageLog..message = 'Warn log success')
  ..error(messageLog..message = 'Error log success')
  ..wtf(messageLog..message = 'Wtf log success');
```

### Logging an exception

```dart
try {
  throw Exception('Test exception');
} catch (exception, stackTrace) {
  messageLog.message = 'An error occurred';
  codenicLogger.error(messageLog, error: exception, stackTrace: stackTrace);
}
```
### Setting a user ID

When a user ID is provided, it will automatically be included in the log data.

```dart
codenicLogger.userId = 'sample-uid';
codenicLogger.info(messageLog);
```

<img src="https://github.com/CodenicCoders/codenic_logger/blob/master/doc/assets/sample_2.webp?raw=true" alt="Sample detailed log messages" width=640/>

To remove the user ID, simply set it back to `null`:

```dart
codenic.userId = null;
```

### Updating message log properties

```dart
final messageLog = MessageLog(id: 'update_message_log');

messageLog
  ..message = 'Update message log success'
  ..data.addAll({'lorep': 'ipsum', 'mauris': 42});

codenicLogger.verbose(messageLog);
```

### Customizing the logger

To customize the log output, provide a custom [logger](https://github.com/leisim/logger) instance:

```dart
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2, // number of method calls to be displayed
    errorMethodCount: 8, // number of method calls if stacktrace is provided
    lineLength: 120, // width of the output
    colors: true, // Colorful log messages
    printEmojis: true, // Print an emoji for each log message
    printTime: false // Should each log print contain a timestamp
  ),
);

final codenicLogger = CodenicLogger(logger: logger);
```

For more info, visit the [logger](https://github.com/leisim/logger) package.

### Blocklisting stack trace line

To prevent a stack trace line from being printed, you can use the `blocklistStackTraceLine` method:

```dart
// lines with `package:codenic_logger/` will not be printed
final codenicLogger = CodenicLogger(
  printer: MessageLogPrinter(
    stackTraceBlocklistRegex: RegExp('package:codenic_logger/'),
  ),
);
```

### Sample Integration: Firebase Crashlytics

```dart
class FirebaseLogger extends CodenicLogger {
  @override
  set userId(String? _userId) {
    super.userId = _userId;
    FirebaseCrashlytics.instance.setUserIdentifier(_userId ?? '');
  }

  @override
  void error(
    MessageLog messageLog, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    super.error(messageLog, error: error, stackTrace: stackTrace);

    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: messageLog,
    );
  }
}
```

## Additional information

### Contributing to this plugin

If you would like to contribute to the package, check out the [contribution guide](https://github.com/CodenicCoders/codenic_logger/blob/master/CONTRIBUTING.md).
