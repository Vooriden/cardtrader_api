// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketplace_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketplaceProduct _$MarketplaceProductFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'MarketplaceProduct',
      json,
      ($checkedConvert) {
        final val = MarketplaceProduct(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          blueprintId: $checkedConvert(
            'blueprint_id',
            (v) => (v as num).toInt(),
          ),
          nameEn: $checkedConvert('name_en', (v) => v as String),
          quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
          price: $checkedConvert(
            'price',
            (v) => Money.fromJson(v as Map<String, dynamic>),
          ),
          description: $checkedConvert('description', (v) => v as String),
          propertiesHash: $checkedConvert(
            'properties_hash',
            (v) => v as Map<String, dynamic>,
          ),
          expansion: $checkedConvert(
            'expansion',
            (v) => Expansion.fromJson(v as Map<String, dynamic>),
          ),
          user: $checkedConvert(
            'user',
            (v) => User.fromJson(v as Map<String, dynamic>),
          ),
          graded: $checkedConvert('graded', (v) => v as bool),
          onVacation: $checkedConvert('on_vacation', (v) => v as bool),
          bundleSize: $checkedConvert('bundle_size', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'blueprintId': 'blueprint_id',
        'nameEn': 'name_en',
        'propertiesHash': 'properties_hash',
        'onVacation': 'on_vacation',
        'bundleSize': 'bundle_size',
      },
    );

Map<String, dynamic> _$MarketplaceProductToJson(MarketplaceProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'blueprint_id': instance.blueprintId,
      'name_en': instance.nameEn,
      'quantity': instance.quantity,
      'price': instance.price.toJson(),
      'description': instance.description,
      'properties_hash': instance.propertiesHash,
      'expansion': instance.expansion.toJson(),
      'user': instance.user.toJson(),
      'graded': instance.graded,
      'on_vacation': instance.onVacation,
      'bundle_size': instance.bundleSize,
    };
