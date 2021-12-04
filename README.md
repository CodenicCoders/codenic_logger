![GitHub Workflow Status](https://img.shields.io/github/workflow/status/CodenicCoders/codenic_logger/main)
![CodeCov](https://codecov.io/gh/CodenicCoders/codenic_logger/branch/master/graph/badge.svg)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
![GitHub](https://img.shields.io/github/license/CodenicCoders/codenic_logger)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/CodenicCoders/codenic_logger)
![Pub Version](https://img.shields.io/pub/v/codenic_logger?color=blue)

A logger for providing structured and detailed log messages.

> This uses the [logger](https://github.com/leisim/logger) package to produce log messages.

<img src="https://github.com/CodenicCoders/codenic_logger/blob/master/doc/assets/sample_1.webp?raw=true" alt="Sample detailed log messages"/>

## Features

Use this plugin in your app to:

- Structurally add log message, details and data.
- Log messages on multiple log levels – verbose, debug, info, warning, error and wtf.
- Automatically add a user ID to all log data upon logging.

## Getting started

To get started, just create a Codenic logger instance:

```dart
final codenicLogger = CodenicLogger();

const messageLog = MessageLog(
  message: 'Save age failed',
  details: 'No internet',
  data: { 'age': 24 },
);

codenicLogger.info(messageLog);
```

## Usage

This section has examples of code for the following tasks:

- [Logging with different log levels](#logging-with-different-log-levels)
- [Logging an exception](#logging-an-exception)
- [Setting a user ID](#setting-a-user-id)
- [Customizing the logger](#customizing-the-log-output)
- [Sample Integration: Firebase Crashlytics](#sample-integration-firebase-crashlytics)

### Logging with different log levels

```dart
final codenicLogger = CodenicLogger();

const messageLog = MessageLog(
  message: 'Sample message',
  data: { 'foo': false, 'lorep': 'ipsum' },
);

codenicLogger.verbose(messageLog, data: data);
codenicLogger.debug(messageLog, data: data);
codenicLogger.info(messageLog, data: data);
codenicLogger.warn(messageLog, data: data);
codenicLogger.error(messageLog, data: data);
codenicLogger.wtf(messageLog, data: data);
```

### Logging an exception

```dart
try {
    throw Exception('Test exception');
} catch (exception, stackTrace) {
  messageLog.details = 'An error has occurred';
  codenicLogger.error(
    messageLog,
    data: {'foo': false, 'lorep': 'ipsum'},
    error: exception,
    stackTrace: stackTrace,
  );
}
```

<img src="https://github.com/CodenicCoders/codenic_logger/blob/master/doc/assets/sample_2.webp?raw=true" alt="Sample detailed log messages" width=620/>

### Setting a user ID

When a user ID is provided, it will automatically be included in the log data.

```dart
codenicLogger.userId = 'sample-uid';
codenicLogger.info(messageLog, data: data);
```

<img src="https://github.com/CodenicCoders/codenic_logger/blob/master/doc/assets/sample_3.webp?raw=true" alt="Sample detailed log messages" width=620/>

To remove the user ID, simply set it back to `null`:

```dart
codenic.userId = null;
```

### Customizing the log output

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
    MessageLog message, {
    Map<String, dynamic>? data,
    error,
    StackTrace? stackTrace,
  }) {
    super.error(message, data: data, error: error, stackTrace: stackTrace);

    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: formatMessageData(message, data),
    );
  }
}
```

## Additional information

### Contributing to this plugin

If you would like to contribute to the package, check out the [contribution guide](https://github.com/CodenicCoders/codenic_logger/blob/master/CONTRIBUTING.md).
