// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Product',
  json,
  ($checkedConvert) {
    final val = Product(
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      nameEn: $checkedConvert('name_en', (v) => v as String?),
      quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
      description: $checkedConvert('description', (v) => v as String? ?? ''),
      priceCents: $checkedConvert(
        'price_cents',
        (v) => (v as num).toInt(),
        readValue: Product._readPriceCents,
      ),
      priceCurrency: $checkedConvert(
        'price_currency',
        (v) => v as String,
        readValue: Product._readPriceCurrency,
      ),
      gameId: $checkedConvert('game_id', (v) => (v as num).toInt()),
      categoryId: $checkedConvert('category_id', (v) => (v as num).toInt()),
      blueprintId: $checkedConvert('blueprint_id', (v) => (v as num).toInt()),
      expansionId: $checkedConvert('expansion_id', (v) => (v as num?)?.toInt()),
      propertiesHash: $checkedConvert(
        'properties_hash',
        (v) => v as Map<String, dynamic>? ?? {},
        readValue: Product._readProperties,
      ),
      userId: $checkedConvert('user_id', (v) => (v as num?)?.toInt()),
      graded: $checkedConvert(
        'graded',
        (v) => v as bool? ?? false,
        readValue: Product._readGraded,
      ),
      tag: $checkedConvert('tag', (v) => v as String? ?? ''),
      userDataField: $checkedConvert(
        'user_data_field',
        (v) => v as String? ?? '',
      ),
      bundleSize: $checkedConvert(
        'bundle_size',
        (v) => (v as num?)?.toInt() ?? 1,
      ),
      bundledQuantity: $checkedConvert(
        'bundled_quantity',
        (v) => (v as num?)?.toInt(),
      ),
      uploadedImages: $checkedConvert(
        'uploaded_images',
        (v) => (v as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'nameEn': 'name_en',
    'priceCents': 'price_cents',
    'priceCurrency': 'price_currency',
    'gameId': 'game_id',
    'categoryId': 'category_id',
    'blueprintId': 'blueprint_id',
    'expansionId': 'expansion_id',
    'propertiesHash': 'properties_hash',
    'userId': 'user_id',
    'userDataField': 'user_data_field',
    'bundleSize': 'bundle_size',
    'bundledQuantity': 'bundled_quantity',
    'uploadedImages': 'uploaded_images',
  },
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'name_en': ?instance.nameEn,
  'quantity': instance.quantity,
  'description': instance.description,
  'price_cents': instance.priceCents,
  'price_currency': instance.priceCurrency,
  'game_id': instance.gameId,
  'category_id': instance.categoryId,
  'blueprint_id': instance.blueprintId,
  'expansion_id': ?instance.expansionId,
  'properties_hash': instance.propertiesHash,
  'user_id': ?instance.userId,
  'graded': instance.graded,
  'tag': instance.tag,
  'user_data_field': instance.userDataField,
  'bundle_size': instance.bundleSize,
  'bundled_quantity': ?instance.bundledQuantity,
  'uploaded_images': instance.uploadedImages,
};
