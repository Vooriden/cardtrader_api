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
  @JsonKey(name: 'game_id')
  final int gameId;

  /// The code/abbreviation for the expansion (e.g., "dom" for Dominaria).
  final String code;

  /// The full name of the expansion.
  final String name;

  /// Constructs an [Expansion] with the given details.
  Expansion({
    required this.id,
    required this.gameId,
    required this.code,
    required this.name,
  });

  /// Creates an [Expansion] from a JSON map.
  factory Expansion.fromJson(Map<String, dynamic> json) =>
      _$ExpansionFromJson(json);

  /// Converts the [Expansion] instance to a JSON map.
  Map<String, dynamic> toJson() => _$ExpansionToJson(this);
}
