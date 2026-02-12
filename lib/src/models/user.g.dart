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
      tooManyRequestForCancelAsSeller: $checkedConvert(
        'too_many_request_for_cancel_as_seller',
        (v) => v as bool?,
      ),
      canSellSealedWithCtZero: $checkedConvert(
        'can_sell_sealed_with_ct_zero',
        (v) => v as bool?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'canSellViaHub': 'can_sell_via_hub',
    'countryCode': 'country_code',
    'userType': 'user_type',
    'maxSellableIn24hQuantity': 'max_sellable_in24h_quantity',
    'tooManyRequestForCancelAsSeller': 'too_many_request_for_cancel_as_seller',
    'canSellSealedWithCtZero': 'can_sell_sealed_with_ct_zero',
  },
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'can_sell_via_hub': ?instance.canSellViaHub,
  'country_code': ?instance.countryCode,
  'user_type': ?instance.userType,
  'max_sellable_in24h_quantity': ?instance.maxSellableIn24hQuantity,
  'too_many_request_for_cancel_as_seller':
      ?instance.tooManyRequestForCancelAsSeller,
  'can_sell_sealed_with_ct_zero': ?instance.canSellSealedWithCtZero,
};
