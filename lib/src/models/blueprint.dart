import 'package:json_annotation/json_annotation.dart';

import 'blueprint_image.dart';
import 'property.dart';

part 'blueprint.g.dart';

/// Represents a blueprint (template) for a product in CardTrader.
///
/// Blueprints define the basic information about a card or product,
/// including its name, associated expansion, category, and editable properties.
@JsonSerializable()
class Blueprint {
  /// The unique identifier for the blueprint.
  final int id;

  /// The name of the blueprint (card/product name).
  final String name;

  /// The version identifier (e.g., "001/038" for card numbering).
  final String? version;

  /// The ID of the game this blueprint belongs to.
  @JsonKey(name: 'game_id')
  final int gameId;

  /// The ID of the category this blueprint belongs to.
  @JsonKey(name: 'category_id')
  final int categoryId;

  /// The ID of the expansion this blueprint belongs to.
  @JsonKey(name: 'expansion_id')
  final int expansionId;

  /// The URL of the blueprint's image, if available.
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  /// The image object with multiple size variants.
  final BlueprintImage? image;

  /// The back image object with multiple size variants, if available.
  @JsonKey(name: 'back_image')
  final BlueprintImage? backImage;

  /// The fixed properties of the blueprint (read-only properties like collector number).
  @JsonKey(name: 'fixed_properties')
  final Map<String, dynamic> fixedProperties;

  /// List of properties that can be edited for products of this blueprint.
  @JsonKey(name: 'editable_properties')
  final List<Property> editableProperties;

  /// The Scryfall ID for Magic: the Gathering cards.
  @JsonKey(name: 'scryfall_id')
  final String? scryfallId;

  /// The Cardmarket IDs for this card.
  @JsonKey(name: 'card_market_ids')
  final List<int>? cardMarketIds;

  /// The TCGPlayer ID for this card.
  @JsonKey(name: 'tcg_player_id')
  final int? tcgPlayerId;

  /// Constructs a [Blueprint] with the given details.
  Blueprint({
    required this.id,
    required this.name,
    this.version,
    required this.gameId,
    required this.categoryId,
    required this.expansionId,
    this.imageUrl,
    this.image,
    this.backImage,
    required this.fixedProperties,
    required this.editableProperties,
    this.scryfallId,
    this.cardMarketIds,
    this.tcgPlayerId,
  });

  /// Creates a [Blueprint] from a JSON map.
  factory Blueprint.fromJson(Map<String, dynamic> json) =>
      _$BlueprintFromJson(json);

  /// Converts the [Blueprint] instance to a JSON map.
  Map<String, dynamic> toJson() => _$BlueprintToJson(this);
}
