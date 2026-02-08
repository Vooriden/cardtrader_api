// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameList _$GameListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GameList', json, ($checkedConvert) {
      final val = GameList(
        array: $checkedConvert(
          'array',
          (v) => (v as List<dynamic>)
              .map((e) => Game.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$GameListToJson(GameList instance) => <String, dynamic>{
  'array': instance.array.map((e) => e.toJson()).toList(),
};

Game _$GameFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Game', json, ($checkedConvert) {
      final val = Game(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        name: $checkedConvert('name', (v) => v as String),
        displayName: $checkedConvert('display_name', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'displayName': 'display_name'});

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'display_name': instance.displayName,
};
