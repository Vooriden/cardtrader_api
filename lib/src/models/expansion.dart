import 'package:json_annotation/json_annotation.dart';

part 'expansion.g.dart';

@JsonSerializable()
class Expansion {
  final int id;
  @JsonKey(name: 'game_id')
  final int gameId;
  final String code;
  final String name;

  Expansion({
    required this.id,
    required this.gameId,
    required this.code,
    required this.name,
  });

  factory Expansion.fromJson(Map<String, dynamic> json) =>
      _$ExpansionFromJson(json);

  Map<String, dynamic> toJson() => _$ExpansionToJson(this);
}
