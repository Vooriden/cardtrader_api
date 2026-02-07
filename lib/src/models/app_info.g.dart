// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInfo _$AppInfoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'AppInfo',
  json,
  ($checkedConvert) {
    final val = AppInfo(
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      name: $checkedConvert('name', (v) => v as String),
      sharedSecret: $checkedConvert('shared_secret', (v) => v as String),
      userId: $checkedConvert('user_id', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {'sharedSecret': 'shared_secret', 'userId': 'user_id'},
);

Map<String, dynamic> _$AppInfoToJson(AppInfo instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'shared_secret': instance.sharedSecret,
  'user_id': instance.userId,
};
