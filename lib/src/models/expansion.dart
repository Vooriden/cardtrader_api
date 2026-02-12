import 'package:json_annotation/json_annotation.dart';

part 'expansion.g.dart';

/// Represents an expansion (set) within a game in CardTrader.
///
/// Expansions are collections of products released together,
/// such as "Dominaria" or "Core Set 2021" in Magic: the Gathering.
@JsonSerializable()
class Expansion {
  /// The unique identifier for the expansion.
  final int id;

  /// The ID of the game this expansion belongs to.
  /// May be null in some API responses (e.g., marketplace products).
  @JsonKey(name: 'game_id')
  final int? gameId;

  /// The code/abbreviation for the expansion (e.g., "dom" for Dominaria).
  final String code;

  /// The full name of the expansion.
  /// Used in the /expansions endpoint.
  ///
  /// Note: This field may be null in marketplace product responses, where [nameEn] is used instead.
  /// Prefer using [displayName] to get the appropriate name based on the context.
  final String? name;

  /// The English name of the expansion.
  /// Used in marketplace product responses.
  ///
  /// Note: This field may be null in the /expansions endpoint, where [name] is used instead.
  /// Prefer using [displayName] to get the appropriate name based on the context.
  @JsonKey(name: 'name_en')
  final String? nameEn;

  /// Returns the display name, preferring [name] over [nameEn].
  String get displayName => name ?? nameEn ?? '';

  /// Constructs an [Expansion] with the given details.
  Expansion({
    required this.id,
    this.gameId,
    required this.code,
    this.name,
    this.nameEn,
  });

  /// Creates an [Expansion] from a JSON map.
  factory Expansion.fromJson(Map<String, dynamic> json) =>
      _$ExpansionFromJson(json);

  /// Converts the [Expansion] instance to a JSON map.
  Map<String, dynamic> toJson() => _$ExpansionToJson(this);
}
