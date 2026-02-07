import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  final int quantity;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(name: 'price_cents')
  final int priceCents;
  @JsonKey(name: 'price_currency')
  final String priceCurrency;
  @JsonKey(name: 'game_id')
  final int gameId;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'blueprint_id')
  final int blueprintId;
  @JsonKey(name: 'properties_hash', defaultValue: {})
  final Map<String, dynamic> propertiesHash;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(defaultValue: false)
  final bool graded;
  @JsonKey(defaultValue: '')
  final String tag;
  @JsonKey(name: 'user_data_field', defaultValue: '')
  final String userDataField;
  @JsonKey(name: 'bundle_size', defaultValue: 1)
  final int bundleSize;
  @JsonKey(name: 'bundled_quantity')
  final int bundledQuantity;
  @JsonKey(name: 'uploaded_images', defaultValue: [])
  final List<String> uploadedImages;

  Product({
    required this.id,
    required this.nameEn,
    required this.quantity,
    required this.description,
    required this.priceCents,
    required this.priceCurrency,
    required this.gameId,
    required this.categoryId,
    required this.blueprintId,
    required this.propertiesHash,
    required this.userId,
    required this.graded,
    required this.tag,
    required this.userDataField,
    required this.bundleSize,
    required this.bundledQuantity,
    required this.uploadedImages,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  double get price => priceCents / 100.0;
}
