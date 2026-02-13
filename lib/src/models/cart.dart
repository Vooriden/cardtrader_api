import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'money.dart';
import 'user.dart';

part 'cart.g.dart';

/// Represents a product reference within a cart item.
///
/// Contains minimal product information for cart display.
@JsonSerializable()
class CartProduct {
  /// The unique identifier for the product.
  final int id;

  /// The English name of the product.
  @JsonKey(name: 'name_en')
  final String nameEn;

  /// Constructs a [CartProduct] with the given details.
  CartProduct({required this.id, required this.nameEn});

  /// Creates a [CartProduct] instance from a JSON map.
  factory CartProduct.fromJson(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);

  /// Converts the [CartProduct] instance to a JSON map.
  Map<String, dynamic> toJson() => _$CartProductToJson(this);
}

/// Represents an item in the shopping cart.
///
/// Contains quantity, price, and product details.
@JsonSerializable()
class CartItem {
  /// The quantity of this item in the cart.
  final int quantity;

  /// The price in cents.
  @JsonKey(name: 'price_cents')
  final int priceCents;

  /// The currency code for the price.
  @JsonKey(name: 'price_currency')
  final String priceCurrency;

  /// The product details.
  final CartProduct product;

  /// Constructs a [CartItem] with the given details.
  CartItem({
    required this.quantity,
    required this.priceCents,
    required this.priceCurrency,
    required this.product,
  });

  /// Creates a [CartItem] instance from a JSON map.
  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  /// Converts the [CartItem] instance to a JSON map.
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}

/// Represents a subcart grouped by seller.
///
/// Each subcart contains items from a single seller.
@JsonSerializable()
class Subcart {
  /// The unique identifier for this subcart.
  final int id;

  /// The seller information.
  final User? seller;

  /// Whether this subcart uses CardTrader Zero.
  @JsonKey(name: 'via_cardtrader_zero')
  final bool? viaCardtraderZero;

  /// The items in this subcart.
  @JsonKey(name: 'cart_items')
  final List<CartItem> cartItems;

  /// Constructs a [Subcart] with the given details.
  Subcart({
    required this.id,
    this.seller,
    this.viaCardtraderZero,
    required this.cartItems,
  });

  /// Creates a [Subcart] instance from a JSON map.
  factory Subcart.fromJson(Map<String, dynamic> json) =>
      _$SubcartFromJson(json);

  /// Converts the [Subcart] instance to a JSON map.
  Map<String, dynamic> toJson() => _$SubcartToJson(this);
}

/// Represents the shopping cart.
///
/// Contains one or more subcarts (grouped by seller),
/// totals, fees, and delivery addresses.
@JsonSerializable()
class Cart {
  /// The unique identifier for this cart.
  final int id;

  /// The total amount for the cart (including fees).
  final Money total;

  /// The subcarts grouped by seller.
  final List<Subcart> subcarts;

  /// The subtotal for all items.
  final Money subtotal;

  /// The total safeguard fee amount.
  @JsonKey(name: 'safeguard_fee_amount')
  final Money safeguardFeeAmount;

  /// The total CardTrader Zero fee amount.
  @JsonKey(name: 'ct_zero_fee_amount')
  final Money ctZeroFeeAmount;

  /// The total percentage-based payment method fee.
  @JsonKey(name: 'payment_method_fee_percentage_amount')
  final Money paymentMethodFeePercentageAmount;

  /// The total fixed payment method fee.
  @JsonKey(name: 'payment_method_fee_fixed_amount')
  final Money paymentMethodFeeFixedAmount;

  /// The total shipping cost.
  @JsonKey(name: 'shipping_cost')
  final Money shippingCost;

  /// The billing address for the cart.
  @JsonKey(name: 'billing_address')
  final Address? billingAddress;

  /// The shipping address for the cart.
  @JsonKey(name: 'shipping_address')
  final Address? shippingAddress;

  /// Constructs a [Cart] with the given details.
  Cart({
    required this.id,
    required this.total,
    required this.subcarts,
    required this.subtotal,
    required this.safeguardFeeAmount,
    required this.ctZeroFeeAmount,
    required this.paymentMethodFeePercentageAmount,
    required this.paymentMethodFeeFixedAmount,
    required this.shippingCost,
    this.billingAddress,
    this.shippingAddress,
  });

  /// Creates a [Cart] instance from a JSON map.
  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  /// Converts the [Cart] instance to a JSON map.
  Map<String, dynamic> toJson() => _$CartToJson(this);
}
