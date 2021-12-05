import 'dart:convert';

/// A container for log information.
class MessageLog {
  /// The default constructor.
  MessageLog({
    required this.message,
    this.details,
    Map<String, dynamic>? data,
  }) : data = data ?? <String, dynamic>{};

  /// Creates an instance from the given [source] json.
  factory MessageLog.fromJson(String source) =>
      MessageLog.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Creates an instance from the given [map] object.
  factory MessageLog.fromMap(Map<String, dynamic> map) => MessageLog(
        message: map['message'] as String,
        details: map['details'] as String?,
        data: map['data'] as Map<String, dynamic>? ?? <String, dynamic>{},
      );

  /// The general log message.
  String message;

  /// A collection of data providing more context about the log message.
  Map<String, dynamic> data;

  /// Additional details about the logged activity.
  String? details;

  /// Creates a copy of this object but replacing the old values with the new
  /// values, if any.
  MessageLog copyWith({
    String? message,
    String? details,
    Map<String, dynamic>? data,
  }) =>
      MessageLog(
        message: message ?? this.message,
        details: details ?? this.details,
        data: data ?? this.data,
      );

  /// Returns a formatted message log:
  ///
  /// ```dart
  /// MessageLog(message: 'Hello') => 'Hello'
  ///
  /// MessageLog(message: 'Hello', details: 'world') => 'Hello – world'
  ///
  /// MessageLog(
  ///     message: 'Hello',
  ///     details: 'world',
  ///     data: {'lorep': 'ipsum', 'mauris': 42},
  ///   ) => 'Hello – world { lorep: ipsum, mauris: 42 }'
  ///
  /// ```
  @override
  String toString() => '$message'
      '${details != null ? ' – $details' : ''}'
      '${data.isNotEmpty ? ' $data' : ''}';

  /// Converts this object into a map object.
  Map<String, dynamic> toMap() => <String, dynamic>{
        'message': message,
        'details': details,
        'data': data,
      };

  /// Converts this object into a JSON string.
  String toJson() => json.encode(toMap());
}
