import 'package:json_annotation/json_annotation.dart';
import 'property.dart';

part 'category.g.dart';

/// Represents a category of products in CardTrader.
///
/// Categories are used to organize products by type within a game,
/// such as "Single Cards", "Sealed Products", "Accessories", etc.
@JsonSerializable()
class Category {
  /// The unique identifier for the category.
  final int id;

  /// The name of the category.
  final String name;

  /// The ID of the game this category belongs to.
  @JsonKey(name: 'game_id')
  final int gameId;

  /// List of properties that products in this category can have.
  final List<Property> properties;

  /// Constructs a [Category] with the given details.
  Category({
    required this.id,
    required this.name,
    required this.gameId,
    required this.properties,
  });

  /// Creates a [Category] from a JSON map.
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  /// Converts the [Category] instance to a JSON map.
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
