import 'package:json_annotation/json_annotation.dart';

import 'expansion.dart';
import 'money.dart';
import 'user.dart';

part 'marketplace_product.g.dart';

/// Represents a product listing in the CardTrader marketplace.
///
/// Marketplace products are items listed for sale by sellers,
/// including pricing, quantity, and seller information.
@JsonSerializable()
class MarketplaceProduct {
  /// The unique identifier for this product listing.
  final int id;

  /// The ID of the blueprint (card template) this product represents.
  @JsonKey(name: 'blueprint_id')
  final int blueprintId;

  /// The English name of the product.
  @JsonKey(name: 'name_en')
  final String nameEn;

  /// The available quantity for this listing.
  final int quantity;

  /// The price in cents (flat field).
  @JsonKey(name: 'price_cents')
  final int priceCents;

  /// The price currency code (flat field).
  @JsonKey(name: 'price_currency')
  final String priceCurrency;

  /// The detailed price object with formatting.
  final Money price;

  /// Additional description or notes from the seller.
  final String? description;

  /// Map of product properties (e.g., condition, language, foil status).
  @JsonKey(name: 'properties_hash')
  final Map<String, dynamic> propertiesHash;

  /// The expansion this product belongs to.
  final Expansion expansion;

  /// The seller of this product.
  final User user;

  /// Whether the product is graded.
  final bool graded;

  /// Whether the seller is currently on vacation.
  @JsonKey(name: 'on_vacation')
  final bool onVacation;

  /// Constructs a [MarketplaceProduct] with the given details.
  MarketplaceProduct({
    required this.id,
    required this.blueprintId,
    required this.nameEn,
    required this.quantity,
    required this.priceCents,
    required this.priceCurrency,
    required this.price,
    required this.description,
    required this.propertiesHash,
    required this.expansion,
    required this.user,
    required this.graded,
    required this.onVacation,
  });

  /// Creates a [MarketplaceProduct] instance from a JSON map.
  factory MarketplaceProduct.fromJson(Map<String, dynamic> json) =>
      _$MarketplaceProductFromJson(json);

  /// Converts the [MarketplaceProduct] instance to a JSON map.
  Map<String, dynamic> toJson() => _$MarketplaceProductToJson(this);
}
