import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

/// Represents the list of games available on CardTrader.
@JsonSerializable()
class GameList {
  /// The array of games.
  final List<Game> array;

  /// Constructs a [GameList] with the given array of games.
  GameList({required this.array});

  /// Creates a [GameList] from a JSON map.
  factory GameList.fromJson(Map<String, dynamic> json) =>
      _$GameListFromJson(json);

  /// Converts the [GameList] instance to a JSON map.
  Map<String, dynamic> toJson() => _$GameListToJson(this);
}

/// Represents a game on CardTrader.
@JsonSerializable()
class Game {
  /// The unique identifier of the game.
  final int id;

  /// The name of the game.
  final String name;

  /// The name of the game in a human-readable format.
  @JsonKey(name: 'display_name')
  final String displayName;

  /// Constructs a [Game] with the given details.
  Game({required this.id, required this.name, required this.displayName});

  /// Creates a [Game] from a JSON map.
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  /// Converts the [Game] instance to a JSON map.
  Map<String, dynamic> toJson() => _$GameToJson(this);
}
