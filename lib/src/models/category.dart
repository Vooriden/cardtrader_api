import 'package:json_annotation/json_annotation.dart';
import 'property.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final int id;
  final String name;
  @JsonKey(name: 'game_id')
  final int gameId;
  final List<Property> properties;

  Category({
    required this.id,
    required this.name,
    required this.gameId,
    required this.properties,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
