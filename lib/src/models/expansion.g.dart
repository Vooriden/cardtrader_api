// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expansion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expansion _$ExpansionFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Expansion',
      json,
      ($checkedConvert) {
        final val = Expansion(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          gameId: $checkedConvert('game_id', (v) => (v as num?)?.toInt()),
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String?),
          nameEn: $checkedConvert('name_en', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'gameId': 'game_id', 'nameEn': 'name_en'},
    );

Map<String, dynamic> _$ExpansionToJson(Expansion instance) => <String, dynamic>{
      'id': instance.id,
      if (instance.gameId case final value?) 'game_id': value,
      'code': instance.code,
      if (instance.name case final value?) 'name': value,
      if (instance.nameEn case final value?) 'name_en': value,
    };
