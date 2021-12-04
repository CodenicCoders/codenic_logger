import 'package:logger/logger.dart';

/// Prints the entire log output without being truncated.
class ExtendedLogOutput extends LogOutput {
  /// The default constructor.
  ExtendedLogOutput({this.textLengthLimit = 800, this.printer});

  /// The max text length allowed.
  ///
  /// If the text exceeds this limit, then it will be split into multiple parts.
  final int textLengthLimit;

  /// A callback method called for printing the texts.
  ///
  /// This defaults to the Dart's [print] function.
  final void Function(String? object)? printer;

  @override
  void output(OutputEvent event) => event.lines.forEach(_printWrapped);

  /// Prints the [text] by batch to ensure they do not get truncated.
  void _printWrapped(String text) {
    final pattern = RegExp('.{1,$textLengthLimit}');

    final preferredPrinter = printer ?? print;

    pattern
        .allMatches(text)
        .forEach((match) => preferredPrinter(match.group(0)));
  }
}
