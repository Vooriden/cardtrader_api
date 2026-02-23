import 'package:json_annotation/json_annotation.dart';
import 'money.dart';

part 'shipping_method.g.dart';

/// Represents a cost tier for a shipping method based on weight.
///
/// Each tier defines a weight range (in grams) and its corresponding price.
@JsonSerializable()
class ShippingMethodCost {
  /// The minimum weight in grams for this cost tier.
  @JsonKey(name: 'from_grams')
  final int fromGrams;

  /// The maximum weight in grams for this cost tier.
  @JsonKey(name: 'to_grams')
  final int toGrams;

  /// The shipping price for this weight range.
  final Money price;

  /// The formatted price string (e.g., "€3.30").
  @JsonKey(name: 'formatted_price')
  final String formattedPrice;

  /// Constructs a [ShippingMethodCost].
  ShippingMethodCost({
    required this.fromGrams,
    required this.toGrams,
    required this.price,
    required this.formattedPrice,
  });

  /// Creates a [ShippingMethodCost] from a JSON map.
  factory ShippingMethodCost.fromJson(Map<String, dynamic> json) =>
      _$ShippingMethodCostFromJson(json);

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => _$ShippingMethodCostToJson(this);
}

/// Represents a shipping method in CardTrader.
///
/// Used in both the marketplace (GET /shipping_methods) and order contexts.
/// In the order context, some marketplace-specific fields may be null.
@JsonSerializable()
class ShippingMethod {
  /// A unique identifier for this shipping method.
  final int id;

  /// The name of this shipping method.
  final String name;

  /// Minimum estimated shipping days. Can be null.
  @JsonKey(name: 'min_estimate_shipping_days')
  final int? minEstimateShippingDays;

  /// Maximum estimated shipping days. Can be null.
  @JsonKey(name: 'max_estimate_shipping_days')
  final int? maxEstimateShippingDays;

  /// Whether the delivery is via parcel (vs envelope).
  /// May be null in order context.
  final bool? parcel;

  /// Whether this shipping method provides tracking.
  final bool? tracked;

  /// The tracking link template with `{code}` placeholder. Can be null.
  @JsonKey(name: 'tracking_link')
  final String? trackingLink;

  /// The tracking code for this shipment. Can be null.
  @JsonKey(name: 'tracking_code')
  final String? trackingCode;

  /// Minimum number of products for free shipping. Can be null.
  @JsonKey(name: 'free_shipping_threshold_quantity')
  final int? freeShippingThresholdQuantity;

  /// Minimum value for free shipping. Can be null.
  @JsonKey(name: 'free_shipping_threshold_price')
  final Money? freeShippingThresholdPrice;

  /// Formatted free shipping threshold price. Can be null.
  @JsonKey(name: 'formatted_free_shipping_threshold_price')
  final String? formattedFreeShippingThresholdPrice;

  /// Maximum cart subtotal for this shipping method. Can be null.
  @JsonKey(name: 'max_cart_subtotal_price')
  final Money? maxCartSubtotalPrice;

  /// Formatted maximum cart subtotal price. Can be null.
  @JsonKey(name: 'formatted_max_cart_subtotal_price')
  final String? formattedMaxCartSubtotalPrice;

  /// Cost tiers by weight range. May be null/empty in order context.
  @JsonKey(name: 'shipping_method_costs')
  final List<ShippingMethodCost>? shippingMethodCosts;

  /// The shipping cost for the seller. Can be null.
  @JsonKey(name: 'seller_price')
  final Money? sellerPrice;

  /// The shipping cost for the buyer. Can be null.
  @JsonKey(name: 'buyer_price')
  final Money? buyerPrice;

  /// The formatted price string (e.g., "€1.50"). Can be null.
  @JsonKey(name: 'formatted_price')
  final String? formattedPrice;

  /// Constructs a [ShippingMethod].
  ShippingMethod({
    required this.id,
    required this.name,
    this.minEstimateShippingDays,
    this.maxEstimateShippingDays,
    this.parcel,
    this.tracked,
    this.trackingLink,
    this.trackingCode,
    this.freeShippingThresholdQuantity,
    this.freeShippingThresholdPrice,
    this.formattedFreeShippingThresholdPrice,
    this.maxCartSubtotalPrice,
    this.formattedMaxCartSubtotalPrice,
    this.shippingMethodCosts,
    this.sellerPrice,
    this.buyerPrice,
    this.formattedPrice,
  });

  /// Creates a [ShippingMethod] from a JSON map.
  factory ShippingMethod.fromJson(Map<String, dynamic> json) =>
      _$ShippingMethodFromJson(json);

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => _$ShippingMethodToJson(this);
}
