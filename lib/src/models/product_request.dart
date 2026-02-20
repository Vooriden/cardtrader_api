import 'package:json_annotation/json_annotation.dart';

part 'product_request.g.dart';

/// Request object for creating a product.
///
/// Used with [CardTraderClient.bulkCreateProducts] to specify the product
/// details in a type-safe manner.
///
/// Example:
/// ```dart
/// final request = ProductRequest(
///   blueprintId: 39063,
///   price: 5.00,
///   quantity: 4,
///   properties: {'condition': 'Near Mint', 'mtg_language': 'en'},
/// );
/// ```
@JsonSerializable()
class ProductRequest {
  /// The blueprint ID to base the product on.
  ///
  /// This is required and identifies the card or item template.
  @JsonKey(name: 'blueprint_id')
  final int blueprintId;

  /// The price as a double (e.g., 5.00 for €5.00).
  final double price;

  /// The quantity to list.
  final int quantity;

  /// Optional description for the product.
  @JsonKey(includeIfNull: false)
  final String? description;

  /// Optional custom user data field.
  ///
  /// Visible only via API, not on CardTrader website.
  @JsonKey(name: 'user_data_field', includeIfNull: false)
  final String? userDataField;

  /// Optional properties (condition, language, foil, etc.).
  ///
  /// The keys should match the editable properties defined in the blueprint.
  /// For example: `{'condition': 'Near Mint', 'mtg_language': 'en', 'mtg_foil': true}`
  @JsonKey(includeIfNull: false)
  final Map<String, dynamic>? properties;

  /// Whether the product is graded.
  @JsonKey(includeIfNull: false)
  final bool? graded;

  /// Constructs a [ProductRequest] with the given details.
  ///
  /// [blueprintId], [price], and [quantity] are required.
  /// Other fields are optional and will be omitted from the JSON if null.
  ProductRequest({
    required this.blueprintId,
    required this.price,
    required this.quantity,
    this.description,
    this.userDataField,
    this.properties,
    this.graded,
  });

  /// Creates a [ProductRequest] instance from a JSON map.
  factory ProductRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductRequestFromJson(json);

  /// Converts the [ProductRequest] instance to a JSON map.
  Map<String, dynamic> toJson() => _$ProductRequestToJson(this);

  @override
  String toString() =>
      'ProductRequest(blueprintId: $blueprintId, price: $price, quantity: $quantity)';
}
