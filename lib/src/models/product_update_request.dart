import 'package:json_annotation/json_annotation.dart';

part 'product_update_request.g.dart';

/// Request object for updating a product.
///
/// Used with [CardTraderClient.bulkUpdateProducts] to specify the product
/// updates in a type-safe manner.
///
/// Only the [id] field is required. All other fields are optional and will
/// only be included in the request if provided.
///
/// Example:
/// ```dart
/// final request = ProductUpdateRequest(
///   id: 123456,
///   price: 5.00,
///   quantity: 10,
/// );
/// ```
@JsonSerializable()
class ProductUpdateRequest {
  /// The product ID to update.
  ///
  /// This is required and identifies which product to update.
  final int id;

  /// The new price as a double (e.g., 5.00 for €5.00).
  @JsonKey(includeIfNull: false)
  final double? price;

  /// The new quantity.
  @JsonKey(includeIfNull: false)
  final int? quantity;

  /// The new description for the product.
  @JsonKey(includeIfNull: false)
  final String? description;

  /// The new custom user data field.
  ///
  /// Visible only via API, not on CardTrader website.
  @JsonKey(name: 'user_data_field', includeIfNull: false)
  final String? userDataField;

  /// The new properties (condition, language, foil, etc.).
  ///
  /// The keys should match the editable properties defined in the blueprint.
  /// For example: `{'condition': 'Near Mint', 'mtg_language': 'en', 'mtg_foil': true}`
  @JsonKey(includeIfNull: false)
  final Map<String, dynamic>? properties;

  /// Whether the product is graded.
  @JsonKey(includeIfNull: false)
  final bool? graded;

  /// Constructs a [ProductUpdateRequest] with the given details.
  ///
  /// Only [id] is required. All other fields are optional.
  ProductUpdateRequest({
    required this.id,
    this.price,
    this.quantity,
    this.description,
    this.userDataField,
    this.properties,
    this.graded,
  });

  /// Creates a [ProductUpdateRequest] instance from a JSON map.
  factory ProductUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductUpdateRequestFromJson(json);

  /// Converts the [ProductUpdateRequest] instance to a JSON map.
  Map<String, dynamic> toJson() => _$ProductUpdateRequestToJson(this);

  @override
  String toString() => 'ProductUpdateRequest(id: $id)';
}
