import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

/// Represents a product in the CardTrader inventory.
///
/// Products are items that you list for sale on the marketplace.
/// Each product is associated with a blueprint and contains
/// pricing, quantity, and condition information.
///
/// This model handles two different JSON formats returned by the API:
/// - **Export format** (`GET /products/export`): uses `price_cents`,
///   `price_currency`, `properties_hash`, etc.
/// - **Resource format** (create/update/increment/delete responses): uses
///   `price: {cents, currency}`, `properties`, etc.
@JsonSerializable()
class Product {
  /// The unique product ID.
  final int id;

  /// The English name of the product.
  ///
  /// Present in the export format, may be absent in resource responses.
  @JsonKey(name: 'name_en')
  final String? nameEn;

  /// The quantity available.
  final int quantity;

  /// Optional description for the product.
  @JsonKey(defaultValue: '')
  final String description;

  /// The price in cents (e.g., 1000 = 10.00).
  ///
  /// Reads from `price_cents` (export format) or `price.cents`
  /// (resource format).
  @JsonKey(name: 'price_cents', readValue: _readPriceCents)
  final int priceCents;

  /// The currency code (e.g., "EUR", "USD").
  ///
  /// Reads from `price_currency` (export format) or `price.currency`
  /// (resource format).
  @JsonKey(name: 'price_currency', readValue: _readPriceCurrency)
  final String priceCurrency;

  /// The game ID this product belongs to.
  @JsonKey(name: 'game_id')
  final int gameId;

  /// The category ID (e.g., Single Cards, Sealed Products).
  @JsonKey(name: 'category_id')
  final int categoryId;

  /// The blueprint ID this product is based on.
  @JsonKey(name: 'blueprint_id')
  final int blueprintId;

  /// The expansion ID this product belongs to.
  ///
  /// Present in the resource format, may be absent in export format.
  @JsonKey(name: 'expansion_id')
  final int? expansionId;

  /// The properties hash containing condition, language, foil, etc.
  ///
  /// Reads from `properties_hash` (export format) or `properties`
  /// (resource format).
  @JsonKey(
    name: 'properties_hash',
    readValue: _readProperties,
    defaultValue: {},
  )
  final Map<String, dynamic> propertiesHash;

  /// The user ID of the product owner.
  ///
  /// Present in the export format, may be absent in resource responses.
  @JsonKey(name: 'user_id')
  final int? userId;

  /// Whether the product is graded.
  ///
  /// The API may return this as a boolean, integer (0/1), or string.
  /// All formats are normalized to a boolean.
  @JsonKey(readValue: _readGraded, defaultValue: false)
  final bool graded;

  /// Optional tag for the product.
  @JsonKey(defaultValue: '')
  final String tag;

  /// Custom user data field.
  @JsonKey(name: 'user_data_field', defaultValue: '')
  final String userDataField;

  /// The bundle size (number of items per bundle).
  @JsonKey(name: 'bundle_size', defaultValue: 1)
  final int bundleSize;

  /// The total bundled quantity.
  ///
  /// Present in the export format, may be absent in resource responses.
  @JsonKey(name: 'bundled_quantity')
  final int? bundledQuantity;

  /// List of uploaded image URLs.
  @JsonKey(name: 'uploaded_images', defaultValue: [])
  final List<String> uploadedImages;

  /// Creates a [Product] instance.
  Product({
    required this.id,
    this.nameEn,
    required this.quantity,
    required this.description,
    required this.priceCents,
    required this.priceCurrency,
    required this.gameId,
    required this.categoryId,
    required this.blueprintId,
    this.expansionId,
    required this.propertiesHash,
    this.userId,
    required this.graded,
    required this.tag,
    required this.userDataField,
    required this.bundleSize,
    this.bundledQuantity,
    required this.uploadedImages,
  });

  /// Creates a [Product] from a JSON map.
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  /// Converts this [Product] to a JSON map.
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  /// Returns the price as a double (e.g., 1000 cents = 10.00).
  double get price => priceCents / 100.0;

  // ========== readValue helpers ==========

  /// Reads price cents from either `price_cents` (export) or
  /// `price.cents` (resource) format.
  static Object? _readPriceCents(Map<dynamic, dynamic> json, String key) {
    if (json.containsKey('price_cents')) return json['price_cents'];
    final price = json['price'];
    if (price is Map) return price['cents'];
    return null;
  }

  /// Reads price currency from either `price_currency` (export) or
  /// `price.currency` (resource) format.
  static Object? _readPriceCurrency(Map<dynamic, dynamic> json, String key) {
    if (json.containsKey('price_currency')) return json['price_currency'];
    final price = json['price'];
    if (price is Map) return price['currency'];
    return null;
  }

  /// Reads properties from either `properties_hash` (export) or
  /// `properties` (resource) format.
  static Object? _readProperties(Map<dynamic, dynamic> json, String key) =>
      json['properties_hash'] ?? json['properties'] ?? <String, dynamic>{};

  /// Normalizes the `graded` field which may be a bool, int, or string.
  static Object? _readGraded(Map<dynamic, dynamic> json, String key) {
    final value = json['graded'];
    if (value is bool) return value;
    if (value is int) return value != 0;
    if (value is String) {
      return value.isNotEmpty && value != '0' && value.toLowerCase() != 'false';
    }
    return false;
  }
}
