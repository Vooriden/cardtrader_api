// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Address',
  json,
  ($checkedConvert) {
    final val = Address(
      id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
      name: $checkedConvert('name', (v) => v as String),
      street: $checkedConvert('street', (v) => v as String),
      zip: $checkedConvert('zip', (v) => v as String),
      city: $checkedConvert('city', (v) => v as String),
      stateOrProvince: $checkedConvert('state_or_province', (v) => v as String),
      countryCode: $checkedConvert('country_code', (v) => v as String),
      country: $checkedConvert('country', (v) => v as String?),
      note: $checkedConvert('note', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'stateOrProvince': 'state_or_province',
    'countryCode': 'country_code',
  },
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'id': ?instance.id,
  'name': instance.name,
  'street': instance.street,
  'zip': instance.zip,
  'city': instance.city,
  'state_or_province': instance.stateOrProvince,
  'country_code': instance.countryCode,
  'country': ?instance.country,
  'note': ?instance.note,
};
