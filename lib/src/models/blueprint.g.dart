// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blueprint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Blueprint _$BlueprintFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Blueprint',
  json,
  ($checkedConvert) {
    final val = Blueprint(
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      name: $checkedConvert('name', (v) => v as String),
      gameId: $checkedConvert('game_id', (v) => (v as num).toInt()),
      categoryId: $checkedConvert('category_id', (v) => (v as num).toInt()),
      expansionId: $checkedConvert('expansion_id', (v) => (v as num).toInt()),
      imageUrl: $checkedConvert('image_url', (v) => v as String?),
      editableProperties: $checkedConvert(
        'editable_properties',
        (v) => (v as List<dynamic>)
            .map((e) => Property.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      scryfallId: $checkedConvert('scryfall_id', (v) => v as String?),
      cardMarketIds: $checkedConvert(
        'card_market_ids',
        (v) => (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
      ),
      tcgPlayerId: $checkedConvert(
        'tcg_player_id',
        (v) => (v as num?)?.toInt(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'gameId': 'game_id',
    'categoryId': 'category_id',
    'expansionId': 'expansion_id',
    'imageUrl': 'image_url',
    'editableProperties': 'editable_properties',
    'scryfallId': 'scryfall_id',
    'cardMarketIds': 'card_market_ids',
    'tcgPlayerId': 'tcg_player_id',
  },
);

Map<String, dynamic> _$BlueprintToJson(Blueprint instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'game_id': instance.gameId,
  'category_id': instance.categoryId,
  'expansion_id': instance.expansionId,
  'image_url': ?instance.imageUrl,
  'editable_properties': instance.editableProperties
      .map((e) => e.toJson())
      .toList(),
  'scryfall_id': ?instance.scryfallId,
  'card_market_ids': ?instance.cardMarketIds,
  'tcg_player_id': ?instance.tcgPlayerId,
};
