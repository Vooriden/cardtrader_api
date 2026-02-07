// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartProduct _$CartProductFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CartProduct', json, ($checkedConvert) {
      final val = CartProduct(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        nameEn: $checkedConvert('name_en', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'nameEn': 'name_en'});

Map<String, dynamic> _$CartProductToJson(CartProduct instance) =>
    <String, dynamic>{'id': instance.id, 'name_en': instance.nameEn};

CartItem _$CartItemFromJson(Map<String, dynamic> json) => $checkedCreate(
  'CartItem',
  json,
  ($checkedConvert) {
    final val = CartItem(
      quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
      priceCents: $checkedConvert('price_cents', (v) => (v as num).toInt()),
      priceCurrency: $checkedConvert('price_currency', (v) => v as String),
      product: $checkedConvert(
        'product',
        (v) => CartProduct.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'priceCents': 'price_cents',
    'priceCurrency': 'price_currency',
  },
);

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
  'quantity': instance.quantity,
  'price_cents': instance.priceCents,
  'price_currency': instance.priceCurrency,
  'product': instance.product.toJson(),
};

Subcart _$SubcartFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Subcart',
  json,
  ($checkedConvert) {
    final val = Subcart(
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      seller: $checkedConvert(
        'seller',
        (v) => v == null ? null : User.fromJson(v as Map<String, dynamic>),
      ),
      cartItems: $checkedConvert(
        'cart_items',
        (v) => (v as List<dynamic>)
            .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      shippingCost: $checkedConvert(
        'shipping_cost',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      subtotal: $checkedConvert(
        'subtotal',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      safeguardFeeAmount: $checkedConvert(
        'safeguard_fee_amount',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      ct0FeeAmount: $checkedConvert(
        'ct_zero_fee_amount',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      paymentMethodFeePercentageAmount: $checkedConvert(
        'payment_method_fee_percentage_amount',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      paymentMethodFeeFixedAmount: $checkedConvert(
        'payment_method_fee_fixed_amount',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      billingAddress: $checkedConvert(
        'billing_address',
        (v) => v == null ? null : Address.fromJson(v as Map<String, dynamic>),
      ),
      shippingAddress: $checkedConvert(
        'shipping_address',
        (v) => v == null ? null : Address.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'cartItems': 'cart_items',
    'shippingCost': 'shipping_cost',
    'safeguardFeeAmount': 'safeguard_fee_amount',
    'ct0FeeAmount': 'ct_zero_fee_amount',
    'paymentMethodFeePercentageAmount': 'payment_method_fee_percentage_amount',
    'paymentMethodFeeFixedAmount': 'payment_method_fee_fixed_amount',
    'billingAddress': 'billing_address',
    'shippingAddress': 'shipping_address',
  },
);

Map<String, dynamic> _$SubcartToJson(Subcart instance) => <String, dynamic>{
  'id': instance.id,
  'seller': ?instance.seller?.toJson(),
  'cart_items': instance.cartItems.map((e) => e.toJson()).toList(),
  'shipping_cost': ?instance.shippingCost?.toJson(),
  'subtotal': ?instance.subtotal?.toJson(),
  'safeguard_fee_amount': ?instance.safeguardFeeAmount?.toJson(),
  'ct_zero_fee_amount': ?instance.ct0FeeAmount?.toJson(),
  'payment_method_fee_percentage_amount': ?instance
      .paymentMethodFeePercentageAmount
      ?.toJson(),
  'payment_method_fee_fixed_amount': ?instance.paymentMethodFeeFixedAmount
      ?.toJson(),
  'billing_address': ?instance.billingAddress?.toJson(),
  'shipping_address': ?instance.shippingAddress?.toJson(),
};

Cart _$CartFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Cart',
  json,
  ($checkedConvert) {
    final val = Cart(
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      createdAt: $checkedConvert(
        'created_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      updatedAt: $checkedConvert(
        'updated_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      subcarts: $checkedConvert(
        'subcarts',
        (v) => (v as List<dynamic>)
            .map((e) => Subcart.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      subtotal: $checkedConvert(
        'subtotal',
        (v) => Money.fromJson(v as Map<String, dynamic>),
      ),
      safeguardFeeAmount: $checkedConvert(
        'safeguard_fee_amount',
        (v) => Money.fromJson(v as Map<String, dynamic>),
      ),
      ct0FeeAmount: $checkedConvert(
        'ct_zero_fee_amount',
        (v) => Money.fromJson(v as Map<String, dynamic>),
      ),
      paymentMethodFeePercentageAmount: $checkedConvert(
        'payment_method_fee_percentage_amount',
        (v) => Money.fromJson(v as Map<String, dynamic>),
      ),
      paymentMethodFeeFixedAmount: $checkedConvert(
        'payment_method_fee_fixed_amount',
        (v) => Money.fromJson(v as Map<String, dynamic>),
      ),
      shippingCost: $checkedConvert(
        'shipping_cost',
        (v) => Money.fromJson(v as Map<String, dynamic>),
      ),
      billingAddress: $checkedConvert(
        'billing_address',
        (v) => v == null ? null : Address.fromJson(v as Map<String, dynamic>),
      ),
      shippingAddress: $checkedConvert(
        'shipping_address',
        (v) => v == null ? null : Address.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
    'safeguardFeeAmount': 'safeguard_fee_amount',
    'ct0FeeAmount': 'ct_zero_fee_amount',
    'paymentMethodFeePercentageAmount': 'payment_method_fee_percentage_amount',
    'paymentMethodFeeFixedAmount': 'payment_method_fee_fixed_amount',
    'shippingCost': 'shipping_cost',
    'billingAddress': 'billing_address',
    'shippingAddress': 'shipping_address',
  },
);

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
  'id': instance.id,
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
  'subcarts': instance.subcarts.map((e) => e.toJson()).toList(),
  'subtotal': instance.subtotal.toJson(),
  'safeguard_fee_amount': instance.safeguardFeeAmount.toJson(),
  'ct_zero_fee_amount': instance.ct0FeeAmount.toJson(),
  'payment_method_fee_percentage_amount': instance
      .paymentMethodFeePercentageAmount
      .toJson(),
  'payment_method_fee_fixed_amount': instance.paymentMethodFeeFixedAmount
      .toJson(),
  'shipping_cost': instance.shippingCost.toJson(),
  'billing_address': ?instance.billingAddress?.toJson(),
  'shipping_address': ?instance.shippingAddress?.toJson(),
};
