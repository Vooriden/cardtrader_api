import 'package:json_annotation/json_annotation.dart';

part 'app_info.g.dart';

/// Represents information about the application.
/// This model is used to test the authentication.
@JsonSerializable()
class AppInfo {
  /// The unique identifier of the application.
  final int id;

  /// The name of the application.
  final String name;

  /// <p>The shared secret for authentication.</p>
  ///
  /// <b>Do not share this information.</b>
  /// Use it to verify the authenticity of the webhook notifications that CardTrader sends you.
  @JsonKey(name: 'shared_secret')
  final String sharedSecret;

  /// The user unique identifier.
  @JsonKey(name: 'user_id')
  final int userId;

  /// Constructs an [AppInfo] with the given details.
  AppInfo({
    required this.id,
    required this.name,
    required this.sharedSecret,
    required this.userId,
  });

  /// Creates an [AppInfo] from a JSON map.
  factory AppInfo.fromJson(Map<String, dynamic> json) =>
      _$AppInfoFromJson(json);

  /// Converts the [AppInfo] instance to a JSON map.
  Map<String, dynamic> toJson() => _$AppInfoToJson(this);
}
