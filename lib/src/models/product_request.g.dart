// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductRequest _$ProductRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ProductRequest',
  json,
  ($checkedConvert) {
    final val = ProductRequest(
      blueprintId: $checkedConvert('blueprint_id', (v) => (v as num).toInt()),
      price: $checkedConvert('price', (v) => (v as num).toDouble()),
      quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
      description: $checkedConvert('description', (v) => v as String?),
      userDataField: $checkedConvert('user_data_field', (v) => v as String?),
      properties: $checkedConvert(
        'properties',
        (v) => v as Map<String, dynamic>?,
      ),
      graded: $checkedConvert('graded', (v) => v as bool?),
    );
    return val;
  },
  fieldKeyMap: const {
    'blueprintId': 'blueprint_id',
    'userDataField': 'user_data_field',
  },
);

Map<String, dynamic> _$ProductRequestToJson(ProductRequest instance) =>
    <String, dynamic>{
      'blueprint_id': instance.blueprintId,
      'price': instance.price,
      'quantity': instance.quantity,
      'description': ?instance.description,
      'user_data_field': ?instance.userDataField,
      'properties': ?instance.properties,
      'graded': ?instance.graded,
    };
