// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Category',
      json,
      ($checkedConvert) {
        final val = Category(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('name', (v) => v as String),
          gameId: $checkedConvert('game_id', (v) => (v as num).toInt()),
          properties: $checkedConvert(
              'properties',
              (v) => (v as List<dynamic>)
                  .map((e) => Property.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'gameId': 'game_id'},
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'game_id': instance.gameId,
      'properties': instance.properties.map((e) => e.toJson()).toList(),
    };
