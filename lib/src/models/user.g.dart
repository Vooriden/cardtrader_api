// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => $checkedCreate(
  'User',
  json,
  ($checkedConvert) {
    final val = User(
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      username: $checkedConvert('username', (v) => v as String),
      canSellViaHub: $checkedConvert('can_sell_via_hub', (v) => v as bool?),
      countryCode: $checkedConvert('country_code', (v) => v as String?),
      userType: $checkedConvert('user_type', (v) => v as String?),
      maxSellableIn24hQuantity: $checkedConvert(
        'max_sellable_in24h_quantity',
        (v) => (v as num?)?.toInt(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'canSellViaHub': 'can_sell_via_hub',
    'countryCode': 'country_code',
    'userType': 'user_type',
    'maxSellableIn24hQuantity': 'max_sellable_in24h_quantity',
  },
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'can_sell_via_hub': ?instance.canSellViaHub,
  'country_code': ?instance.countryCode,
  'user_type': ?instance.userType,
  'max_sellable_in24h_quantity': ?instance.maxSellableIn24hQuantity,
};
