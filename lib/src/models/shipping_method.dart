import 'package:json_annotation/json_annotation.dart';
import 'money.dart';

part 'shipping_method.g.dart';

@JsonSerializable()
class ShippingMethodCost {
  @JsonKey(name: 'from_grams')
  final int fromGrams;
  @JsonKey(name: 'to_grams')
  final int toGrams;
  final Money price;
  @JsonKey(name: 'formatted_price')
  final String formattedPrice;

  ShippingMethodCost({
    required this.fromGrams,
    required this.toGrams,
    required this.price,
    required this.formattedPrice,
  });

  factory ShippingMethodCost.fromJson(Map<String, dynamic> json) =>
      _$ShippingMethodCostFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingMethodCostToJson(this);
}

@JsonSerializable()
class ShippingMethod {
  final int id;
  final String name;
  @JsonKey(name: 'min_estimate_shipping_days')
  final int? minEstimateShippingDays;
  @JsonKey(name: 'max_estimate_shipping_days')
  final int? maxEstimateShippingDays;
  final bool parcel;
  final bool tracked;
  @JsonKey(name: 'tracking_link')
  final String? trackingLink;
  @JsonKey(name: 'tracking_code')
  final String? trackingCode;
  @JsonKey(name: 'free_shipping_threshold_quantity')
  final int? freeShippingThresholdQuantity;
  @JsonKey(name: 'free_shipping_threshold_price')
  final Money? freeShippingThresholdPrice;
  @JsonKey(name: 'formatted_free_shipping_threshold_price')
  final String? formattedFreeShippingThresholdPrice;
  @JsonKey(name: 'max_cart_subtotal_price')
  final Money? maxCartSubtotalPrice;
  @JsonKey(name: 'formatted_max_cart_subtotal_price')
  final String? formattedMaxCartSubtotalPrice;
  @JsonKey(name: 'shipping_method_costs')
  final List<ShippingMethodCost> shippingMethodCosts;
  @JsonKey(name: 'seller_price')
  final Money? sellerPrice;
  @JsonKey(name: 'buyer_price')
  final Money? buyerPrice;
  @JsonKey(name: 'formatted_price')
  final String? formattedPrice;

  ShippingMethod({
    required this.id,
    required this.name,
    this.minEstimateShippingDays,
    this.maxEstimateShippingDays,
    required this.parcel,
    required this.tracked,
    this.trackingLink,
    this.trackingCode,
    this.freeShippingThresholdQuantity,
    this.freeShippingThresholdPrice,
    this.formattedFreeShippingThresholdPrice,
    this.maxCartSubtotalPrice,
    this.formattedMaxCartSubtotalPrice,
    required this.shippingMethodCosts,
    this.sellerPrice,
    this.buyerPrice,
    this.formattedPrice,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) =>
      _$ShippingMethodFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingMethodToJson(this);
}
