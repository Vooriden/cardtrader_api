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
///
/// ## Error 422: Unprocessable Entity
/// If validation fails, the API may respond with a 422 error
/// containing an `errors` array instead of the standard format.
@JsonSerializable()
class CardTraderException implements Exception {
  /// The HTTP status code returned by the API.
  @JsonKey(name: 'status_code')
  final int statusCode;

  /// The error code returned by the API.
  /// Values are like `unauthorized`, `not_found`, etc.
  /// May be `null` when the API returns an `errors` array format.
  @JsonKey(name: 'error_code')
  final String? errorCode;

  /// Additional information about the error.
  /// This usually contains a human-readable message.
  /// May be `null` when the API returns an `errors` array format.
  final ExtraMessage? extra;

  /// The unique request ID for tracking purposes.
  /// May be `null` when the API returns an `errors` array format.
  @JsonKey(name: 'request_id')
  final String? requestId;

  /// A list of validation error messages.
  /// Present when the API returns the `{"errors": [...]}` format
  /// (e.g., 422 Unprocessable Entity).
  final List<String>? errors;

  /// Constructs a [CardTraderException] with the given details.
  CardTraderException({
    required this.statusCode,
    this.errorCode,
    this.extra,
    this.requestId,
    this.errors,
  });

  /// Creates a [CardTraderException] from a JSON map.
  factory CardTraderException.fromJson(
    Map<String, dynamic> json,
    int statusCode,
  ) {
    final data = Map<String, dynamic>.from(json);
    data.putIfAbsent('status_code', () => statusCode);
    return _$CardTraderExceptionFromJson(data);
  }

  /// Converts the [CardTraderException] to a JSON map.
  Map<String, dynamic> toJson() => _$CardTraderExceptionToJson(this);

  /// Returns a human-readable error message.
  ///
  /// If the error contains an `errors` array, the messages are joined.
  /// Otherwise, the `extra.message` is returned.
  String get message {
    if (errors != null && errors!.isNotEmpty) {
      return errors!.join(', ');
    }
    return extra?.message ?? 'Unknown error';
  }
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
