import 'package:json_annotation/json_annotation.dart';
import 'property.dart';

part 'blueprint.g.dart';

@JsonSerializable()
class Blueprint {
  final int id;
  final String name;
  @JsonKey(name: 'game_id')
  final int gameId;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'expansion_id')
  final int expansionId;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'editable_properties')
  final List<Property> editableProperties;
  @JsonKey(name: 'scryfall_id')
  final String? scryfallId;
  @JsonKey(name: 'card_market_ids')
  final List<int>? cardMarketIds;
  @JsonKey(name: 'tcg_player_id')
  final int? tcgPlayerId;

  Blueprint({
    required this.id,
    required this.name,
    required this.gameId,
    required this.categoryId,
    required this.expansionId,
    this.imageUrl,
    required this.editableProperties,
    this.scryfallId,
    this.cardMarketIds,
    this.tcgPlayerId,
  });

  factory Blueprint.fromJson(Map<String, dynamic> json) =>
      _$BlueprintFromJson(json);

  Map<String, dynamic> toJson() => _$BlueprintToJson(this);
}
