import 'dart:io' show Platform;

import 'package:logger/logger.dart';

/// Prints the entire log output without being truncated.
///
/// Some platforms such as Android and IOS truncates long texts displayed via a
/// single log call. As a solution, the log printing is done in small chunks to
/// ensure that it gets entirely printed.
///
/// See https://github.com/flutter/flutter/issues/22665#issuecomment-496130148
class CompleteLogOutput extends LogOutput {
  /// The default constructor.
  CompleteLogOutput({this.textLengthLimit = 1000, this.printer});

  /// The max text length allowed.
  ///
  /// If the text exceeds this limit, then it will be split into multiple parts.
  final int textLengthLimit;

  /// A callback method called for printing the texts.
  ///
  /// This defaults to the Dart's [print] function.
  final void Function(String? object)? printer;

  @override
  void output(OutputEvent event) =>
      event.lines.forEach(Platform.isAndroid ? _printWrapped : print);

  /// Prints the [text] by batch to ensure they do not get truncated.
  void _printWrapped(String text) {
    final pattern = RegExp('.{1,$textLengthLimit}');

    final preferredPrinter = printer ?? print;

    pattern
        .allMatches(text)
        .forEach((match) => preferredPrinter(match.group(0)));
  }
}
