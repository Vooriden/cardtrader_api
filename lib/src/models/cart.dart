import 'package:json_annotation/json_annotation.dart';
import 'address.dart';
import 'money.dart';
import 'user.dart';

part 'cart.g.dart';

@JsonSerializable()
class CartProduct {
  final int id;
  @JsonKey(name: 'name_en')
  final String nameEn;

  CartProduct({required this.id, required this.nameEn});

  factory CartProduct.fromJson(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductToJson(this);
}

@JsonSerializable()
class CartItem {
  final int quantity;
  @JsonKey(name: 'price_cents')
  final int priceCents;
  @JsonKey(name: 'price_currency')
  final String priceCurrency;
  final CartProduct product;

  CartItem({
    required this.quantity,
    required this.priceCents,
    required this.priceCurrency,
    required this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}

@JsonSerializable()
class Subcart {
  final int id;
  final User? seller;
  @JsonKey(name: 'cart_items')
  final List<CartItem> cartItems;
  @JsonKey(name: 'shipping_cost')
  final Money? shippingCost;
  final Money? subtotal;
  @JsonKey(name: 'safeguard_fee_amount')
  final Money? safeguardFeeAmount;
  @JsonKey(name: 'ct_zero_fee_amount')
  final Money? ct0FeeAmount;
  @JsonKey(name: 'payment_method_fee_percentage_amount')
  final Money? paymentMethodFeePercentageAmount;
  @JsonKey(name: 'payment_method_fee_fixed_amount')
  final Money? paymentMethodFeeFixedAmount;
  @JsonKey(name: 'billing_address')
  final Address? billingAddress;
  @JsonKey(name: 'shipping_address')
  final Address? shippingAddress;

  Subcart({
    required this.id,
    this.seller,
    required this.cartItems,
    this.shippingCost,
    this.subtotal,
    this.safeguardFeeAmount,
    this.ct0FeeAmount,
    this.paymentMethodFeePercentageAmount,
    this.paymentMethodFeeFixedAmount,
    this.billingAddress,
    this.shippingAddress,
  });

  factory Subcart.fromJson(Map<String, dynamic> json) =>
      _$SubcartFromJson(json);

  Map<String, dynamic> toJson() => _$SubcartToJson(this);
}

@JsonSerializable()
class Cart {
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  final List<Subcart> subcarts;
  final Money subtotal;
  @JsonKey(name: 'safeguard_fee_amount')
  final Money safeguardFeeAmount;
  @JsonKey(name: 'ct_zero_fee_amount')
  final Money ct0FeeAmount;
  @JsonKey(name: 'payment_method_fee_percentage_amount')
  final Money paymentMethodFeePercentageAmount;
  @JsonKey(name: 'payment_method_fee_fixed_amount')
  final Money paymentMethodFeeFixedAmount;
  @JsonKey(name: 'shipping_cost')
  final Money shippingCost;
  @JsonKey(name: 'billing_address')
  final Address? billingAddress;
  @JsonKey(name: 'shipping_address')
  final Address? shippingAddress;

  Cart({
    required this.id,
    this.createdAt,
    this.updatedAt,
    required this.subcarts,
    required this.subtotal,
    required this.safeguardFeeAmount,
    required this.ct0FeeAmount,
    required this.paymentMethodFeePercentageAmount,
    required this.paymentMethodFeeFixedAmount,
    required this.shippingCost,
    this.billingAddress,
    this.shippingAddress,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
