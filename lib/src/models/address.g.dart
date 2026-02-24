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
          userId: $checkedConvert('user_id', (v) => (v as num?)?.toInt()),
          name: $checkedConvert('name', (v) => v as String),
          street: $checkedConvert('street', (v) => v as String),
          zip: $checkedConvert('zip', (v) => v as String),
          city: $checkedConvert('city', (v) => v as String),
          stateOrProvince:
              $checkedConvert('state_or_province', (v) => v as String),
          countryCode: $checkedConvert('country_code', (v) => v as String),
          phone: $checkedConvert('phone', (v) => v as String?),
          keepOriginal: $checkedConvert('keep_original', (v) => v as bool?),
          defaultBillingAddress:
              $checkedConvert('default_billing_address', (v) => v as bool?),
          defaultShippingAddress:
              $checkedConvert('default_shipping_address', (v) => v as bool?),
          latitude: $checkedConvert('latitude', (v) => (v as num?)?.toDouble()),
          longitude:
              $checkedConvert('longitude', (v) => (v as num?)?.toDouble()),
          note: $checkedConvert('note', (v) => v as String?),
          createdAt: $checkedConvert('created_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
          updatedAt: $checkedConvert('updated_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'userId': 'user_id',
        'stateOrProvince': 'state_or_province',
        'countryCode': 'country_code',
        'keepOriginal': 'keep_original',
        'defaultBillingAddress': 'default_billing_address',
        'defaultShippingAddress': 'default_shipping_address',
        'createdAt': 'created_at',
        'updatedAt': 'updated_at'
      },
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.userId case final value?) 'user_id': value,
      'name': instance.name,
      'street': instance.street,
      'zip': instance.zip,
      'city': instance.city,
      'state_or_province': instance.stateOrProvince,
      'country_code': instance.countryCode,
      if (instance.phone case final value?) 'phone': value,
      if (instance.keepOriginal case final value?) 'keep_original': value,
      if (instance.defaultBillingAddress case final value?)
        'default_billing_address': value,
      if (instance.defaultShippingAddress case final value?)
        'default_shipping_address': value,
      if (instance.latitude case final value?) 'latitude': value,
      if (instance.longitude case final value?) 'longitude': value,
      if (instance.note case final value?) 'note': value,
      if (instance.createdAt?.toIso8601String() case final value?)
        'created_at': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updated_at': value,
    };
