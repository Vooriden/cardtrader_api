// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductUpdateRequest _$ProductUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ProductUpdateRequest',
      json,
      ($checkedConvert) {
        final val = ProductUpdateRequest(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          price: $checkedConvert('price', (v) => (v as num?)?.toDouble()),
          quantity: $checkedConvert('quantity', (v) => (v as num?)?.toInt()),
          description: $checkedConvert('description', (v) => v as String?),
          userDataField:
              $checkedConvert('user_data_field', (v) => v as String?),
          properties:
              $checkedConvert('properties', (v) => v as Map<String, dynamic>?),
          graded: $checkedConvert('graded', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {'userDataField': 'user_data_field'},
    );

Map<String, dynamic> _$ProductUpdateRequestToJson(
        ProductUpdateRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      if (instance.price case final value?) 'price': value,
      if (instance.quantity case final value?) 'quantity': value,
      if (instance.description case final value?) 'description': value,
      if (instance.userDataField case final value?) 'user_data_field': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.graded case final value?) 'graded': value,
    };
