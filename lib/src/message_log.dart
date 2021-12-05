/// A container for log information.
class MessageLog {
  /// The default constructor.
  MessageLog({
    required this.id,
    this.message,
    Map<String, dynamic>? data,
  }) : data = data ?? <String, dynamic>{};

  /// A unique identifier which tells where the message comes from.
  final String id;

  /// The main information of the log.
  String? message;

  /// A collection of data for providing more context.
  Map<String, dynamic> data;

  /// Creates a copy of this object but replacing the old values with the new
  /// values, if any.
  MessageLog copyWith({
    String? id,
    String? message,
    Map<String, dynamic>? data,
  }) =>
      MessageLog(
        id: id ?? this.id,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  /// Returns a formatted string message log.
  @override
  String toString() => 'identifier: $id'
      '${message != null ? '\nmessage: $message' : ''}'
      '${data.isNotEmpty ? '\ndata: $data' : ''}';
}
