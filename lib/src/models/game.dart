import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  final int id;
  final String name;
  @JsonKey(name: 'display_name')
  final String displayName;

  Game({required this.id, required this.name, required this.displayName});

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}
