// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartProduct _$CartProductFromJson(Map<String, dynamic> json) => $checkedCreate(
      'CartProduct',
      json,
      ($checkedConvert) {
        final val = CartProduct(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          nameEn: $checkedConvert('name_en', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'nameEn': 'name_en'},
    );

Map<String, dynamic> _$CartProductToJson(CartProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
    };

CartItem _$CartItemFromJson(Map<String, dynamic> json) => $checkedCreate(
      'CartItem',
      json,
      ($checkedConvert) {
        final val = CartItem(
          quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
          priceCents: $checkedConvert('price_cents', (v) => (v as num).toInt()),
          priceCurrency: $checkedConvert('price_currency', (v) => v as String),
          product: $checkedConvert('product',
              (v) => CartProduct.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'priceCents': 'price_cents',
        'priceCurrency': 'price_currency'
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
              (v) =>
                  v == null ? null : User.fromJson(v as Map<String, dynamic>)),
          viaCardtraderZero:
              $checkedConvert('via_cardtrader_zero', (v) => v as bool?),
          cartItems: $checkedConvert(
              'cart_items',
              (v) => (v as List<dynamic>)
                  .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'viaCardtraderZero': 'via_cardtrader_zero',
        'cartItems': 'cart_items'
      },
    );

Map<String, dynamic> _$SubcartToJson(Subcart instance) => <String, dynamic>{
      'id': instance.id,
      if (instance.seller?.toJson() case final value?) 'seller': value,
      if (instance.viaCardtraderZero case final value?)
        'via_cardtrader_zero': value,
      'cart_items': instance.cartItems.map((e) => e.toJson()).toList(),
    };

Cart _$CartFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Cart',
      json,
      ($checkedConvert) {
        final val = Cart(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          total: $checkedConvert(
              'total', (v) => Money.fromJson(v as Map<String, dynamic>)),
          subcarts: $checkedConvert(
              'subcarts',
              (v) => (v as List<dynamic>)
                  .map((e) => Subcart.fromJson(e as Map<String, dynamic>))
                  .toList()),
          subtotal: $checkedConvert(
              'subtotal', (v) => Money.fromJson(v as Map<String, dynamic>)),
          safeguardFeeAmount: $checkedConvert('safeguard_fee_amount',
              (v) => Money.fromJson(v as Map<String, dynamic>)),
          ctZeroFeeAmount: $checkedConvert('ct_zero_fee_amount',
              (v) => Money.fromJson(v as Map<String, dynamic>)),
          paymentMethodFeePercentageAmount: $checkedConvert(
              'payment_method_fee_percentage_amount',
              (v) => Money.fromJson(v as Map<String, dynamic>)),
          paymentMethodFeeFixedAmount: $checkedConvert(
              'payment_method_fee_fixed_amount',
              (v) => Money.fromJson(v as Map<String, dynamic>)),
          shippingCost: $checkedConvert('shipping_cost',
              (v) => Money.fromJson(v as Map<String, dynamic>)),
          billingAddress: $checkedConvert(
              'billing_address',
              (v) => v == null
                  ? null
                  : Address.fromJson(v as Map<String, dynamic>)),
          shippingAddress: $checkedConvert(
              'shipping_address',
              (v) => v == null
                  ? null
                  : Address.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'safeguardFeeAmount': 'safeguard_fee_amount',
        'ctZeroFeeAmount': 'ct_zero_fee_amount',
        'paymentMethodFeePercentageAmount':
            'payment_method_fee_percentage_amount',
        'paymentMethodFeeFixedAmount': 'payment_method_fee_fixed_amount',
        'shippingCost': 'shipping_cost',
        'billingAddress': 'billing_address',
        'shippingAddress': 'shipping_address'
      },
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'id': instance.id,
      'total': instance.total.toJson(),
      'subcarts': instance.subcarts.map((e) => e.toJson()).toList(),
      'subtotal': instance.subtotal.toJson(),
      'safeguard_fee_amount': instance.safeguardFeeAmount.toJson(),
      'ct_zero_fee_amount': instance.ctZeroFeeAmount.toJson(),
      'payment_method_fee_percentage_amount':
          instance.paymentMethodFeePercentageAmount.toJson(),
      'payment_method_fee_fixed_amount':
          instance.paymentMethodFeeFixedAmount.toJson(),
      'shipping_cost': instance.shippingCost.toJson(),
      if (instance.billingAddress?.toJson() case final value?)
        'billing_address': value,
      if (instance.shippingAddress?.toJson() case final value?)
        'shipping_address': value,
    };
