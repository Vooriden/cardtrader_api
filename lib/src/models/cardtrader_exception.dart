import 'package:json_annotation/json_annotation.dart';

part 'cardtrader_exception.g.dart';

/// There are some standard error response that can
/// be returned by the CardTrader API.
///
/// ## Error 401: Unauthorized
/// If the authentication is incorrect, for example because
/// the Bearer Token is absent or incorrect, API responds
/// with a 401 Unauthorized error.
///
/// ## Error 404: Not Found
/// If a resource is not present, API responds with a 404
/// Not Found error.
@JsonSerializable()
class CardTraderException implements Exception {
  /// The HTTP status code returned by the API.
  @JsonKey(name: 'status_code')
  final int statusCode;

  /// The error code returned by the API.
  /// Values are like `unauthorized`, `not_found`, etc.
  @JsonKey(name: 'error_code')
  final String errorCode;

  /// Additional information about the error.
  /// This usually contains a human-readable message.
  final ExtraMessage extra;

  /// The unique request ID for tracking purposes.
  @JsonKey(name: 'request_id')
  final String requestId;

  /// Constructs a [CardTraderException] with the given details.
  CardTraderException({
    required this.statusCode,
    required this.errorCode,
    required this.extra,
    required this.requestId,
  });

  /// Creates a [CardTraderException] from a JSON map.
  factory CardTraderException.fromJson(
    Map<String, dynamic> json,
    int statusCode,
  ) => _$CardTraderExceptionFromJson(
    json..putIfAbsent('status_code', () => statusCode),
  );

  /// Converts the [CardTraderException] to a JSON map.
  Map<String, dynamic> toJson() => _$CardTraderExceptionToJson(this);
}

@JsonSerializable()
class ExtraMessage {
  /// A human-readable message providing additional information about the error.
  final String message;

  /// Constructs an [ExtraMessage] with the given message.
  ExtraMessage({required this.message});

  /// Creates an [ExtraMessage] from a JSON map.
  factory ExtraMessage.fromJson(Map<String, dynamic> json) =>
      _$ExtraMessageFromJson(json);

  /// Converts the [ExtraMessage] to a JSON map.
  Map<String, dynamic> toJson() => _$ExtraMessageToJson(this);
}
