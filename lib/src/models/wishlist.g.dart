// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeckItem _$DeckItemFromJson(Map<String, dynamic> json) => $checkedCreate(
      'DeckItem',
      json,
      ($checkedConvert) {
        final val = DeckItem(
          quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
          blueprintId:
              $checkedConvert('blueprint_id', (v) => (v as num?)?.toInt()),
          metaName: $checkedConvert('meta_name', (v) => v as String),
          expansionCode: $checkedConvert('expansion_code', (v) => v as String?),
          collectorNumber:
              $checkedConvert('collector_number', (v) => v as String?),
          language: $checkedConvert('language', (v) => v as String?),
          condition: $checkedConvert('condition', (v) => v as String?),
          foil: $checkedConvert('foil', (v) => v as String?),
          reverse: $checkedConvert('reverse', (v) => v as String?),
          firstEdition: $checkedConvert('first_edition', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {
        'blueprintId': 'blueprint_id',
        'metaName': 'meta_name',
        'expansionCode': 'expansion_code',
        'collectorNumber': 'collector_number',
        'firstEdition': 'first_edition'
      },
    );

Map<String, dynamic> _$DeckItemToJson(DeckItem instance) => <String, dynamic>{
      'quantity': instance.quantity,
      if (instance.blueprintId case final value?) 'blueprint_id': value,
      'meta_name': instance.metaName,
      if (instance.expansionCode case final value?) 'expansion_code': value,
      if (instance.collectorNumber case final value?) 'collector_number': value,
      if (instance.language case final value?) 'language': value,
      if (instance.condition case final value?) 'condition': value,
      if (instance.foil case final value?) 'foil': value,
      if (instance.reverse case final value?) 'reverse': value,
      if (instance.firstEdition case final value?) 'first_edition': value,
    };

Wishlist _$WishlistFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Wishlist',
      json,
      ($checkedConvert) {
        final val = Wishlist(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('name', (v) => v as String),
          gameId: $checkedConvert('game_id', (v) => (v as num).toInt()),
          isPublic: $checkedConvert('public', (v) => v as bool),
          createdAt:
              $checkedConvert('created_at', (v) => DateTime.parse(v as String)),
          updatedAt:
              $checkedConvert('updated_at', (v) => DateTime.parse(v as String)),
          items: $checkedConvert(
              'items',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => DeckItem.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'gameId': 'game_id',
        'isPublic': 'public',
        'createdAt': 'created_at',
        'updatedAt': 'updated_at'
      },
    );

Map<String, dynamic> _$WishlistToJson(Wishlist instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'game_id': instance.gameId,
      'public': instance.isPublic,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      if (instance.items?.map((e) => e.toJson()).toList() case final value?)
        'items': value,
    };
