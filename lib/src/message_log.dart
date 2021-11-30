import 'dart:convert';

class MessageLog {
  const MessageLog({
    required this.message,
    this.details,
  });

  factory MessageLog.fromJson(String source) =>
      MessageLog.fromMap(json.decode(source));

  factory MessageLog.fromMap(Map<String, dynamic> map) =>
      MessageLog(message: map['message'], details: map['details']);

  /// The general log message.
  final String message;

  /// Additional details about the logged activity.
  final String? details;

  MessageLog copyWith({
    String? message,
    String? details,
  }) =>
      MessageLog(
        message: message ?? this.message,
        details: details ?? this.details,
      );

  /// Returned message format:
  ///
  /// ```dart
  /// MessageLog(message: 'Hello') => Hello
  ///
  /// MessageLog(message: 'Hello', details: 'world') => Hello – world
  /// ```
  @override
  String toString() => '$message${details != null ? ' – $details' : ''}';

  Map<String, dynamic> toMap() => {'message': message, 'details': details};

  String toJson() => json.encode(toMap());
}
