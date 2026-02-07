// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expansion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expansion _$ExpansionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Expansion', json, ($checkedConvert) {
      final val = Expansion(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        gameId: $checkedConvert('game_id', (v) => (v as num).toInt()),
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'gameId': 'game_id'});

Map<String, dynamic> _$ExpansionToJson(Expansion instance) => <String, dynamic>{
  'id': instance.id,
  'game_id': instance.gameId,
  'code': instance.code,
  'name': instance.name,
};
