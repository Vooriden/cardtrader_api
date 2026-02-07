// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingMethodCost _$ShippingMethodCostFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ShippingMethodCost',
      json,
      ($checkedConvert) {
        final val = ShippingMethodCost(
          fromGrams: $checkedConvert('from_grams', (v) => (v as num).toInt()),
          toGrams: $checkedConvert('to_grams', (v) => (v as num).toInt()),
          price: $checkedConvert(
            'price',
            (v) => Money.fromJson(v as Map<String, dynamic>),
          ),
          formattedPrice: $checkedConvert(
            'formatted_price',
            (v) => v as String,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'fromGrams': 'from_grams',
        'toGrams': 'to_grams',
        'formattedPrice': 'formatted_price',
      },
    );

Map<String, dynamic> _$ShippingMethodCostToJson(ShippingMethodCost instance) =>
    <String, dynamic>{
      'from_grams': instance.fromGrams,
      'to_grams': instance.toGrams,
      'price': instance.price.toJson(),
      'formatted_price': instance.formattedPrice,
    };

ShippingMethod _$ShippingMethodFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ShippingMethod',
  json,
  ($checkedConvert) {
    final val = ShippingMethod(
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      name: $checkedConvert('name', (v) => v as String),
      minEstimateShippingDays: $checkedConvert(
        'min_estimate_shipping_days',
        (v) => (v as num?)?.toInt(),
      ),
      maxEstimateShippingDays: $checkedConvert(
        'max_estimate_shipping_days',
        (v) => (v as num?)?.toInt(),
      ),
      parcel: $checkedConvert('parcel', (v) => v as bool),
      tracked: $checkedConvert('tracked', (v) => v as bool),
      trackingLink: $checkedConvert('tracking_link', (v) => v as String?),
      trackingCode: $checkedConvert('tracking_code', (v) => v as String?),
      freeShippingThresholdQuantity: $checkedConvert(
        'free_shipping_threshold_quantity',
        (v) => (v as num?)?.toInt(),
      ),
      freeShippingThresholdPrice: $checkedConvert(
        'free_shipping_threshold_price',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      formattedFreeShippingThresholdPrice: $checkedConvert(
        'formatted_free_shipping_threshold_price',
        (v) => v as String?,
      ),
      maxCartSubtotalPrice: $checkedConvert(
        'max_cart_subtotal_price',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      formattedMaxCartSubtotalPrice: $checkedConvert(
        'formatted_max_cart_subtotal_price',
        (v) => v as String?,
      ),
      shippingMethodCosts: $checkedConvert(
        'shipping_method_costs',
        (v) => (v as List<dynamic>)
            .map((e) => ShippingMethodCost.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      sellerPrice: $checkedConvert(
        'seller_price',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      buyerPrice: $checkedConvert(
        'buyer_price',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      formattedPrice: $checkedConvert('formatted_price', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'minEstimateShippingDays': 'min_estimate_shipping_days',
    'maxEstimateShippingDays': 'max_estimate_shipping_days',
    'trackingLink': 'tracking_link',
    'trackingCode': 'tracking_code',
    'freeShippingThresholdQuantity': 'free_shipping_threshold_quantity',
    'freeShippingThresholdPrice': 'free_shipping_threshold_price',
    'formattedFreeShippingThresholdPrice':
        'formatted_free_shipping_threshold_price',
    'maxCartSubtotalPrice': 'max_cart_subtotal_price',
    'formattedMaxCartSubtotalPrice': 'formatted_max_cart_subtotal_price',
    'shippingMethodCosts': 'shipping_method_costs',
    'sellerPrice': 'seller_price',
    'buyerPrice': 'buyer_price',
    'formattedPrice': 'formatted_price',
  },
);

Map<String, dynamic> _$ShippingMethodToJson(
  ShippingMethod instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'min_estimate_shipping_days': ?instance.minEstimateShippingDays,
  'max_estimate_shipping_days': ?instance.maxEstimateShippingDays,
  'parcel': instance.parcel,
  'tracked': instance.tracked,
  'tracking_link': ?instance.trackingLink,
  'tracking_code': ?instance.trackingCode,
  'free_shipping_threshold_quantity': ?instance.freeShippingThresholdQuantity,
  'free_shipping_threshold_price': ?instance.freeShippingThresholdPrice
      ?.toJson(),
  'formatted_free_shipping_threshold_price':
      ?instance.formattedFreeShippingThresholdPrice,
  'max_cart_subtotal_price': ?instance.maxCartSubtotalPrice?.toJson(),
  'formatted_max_cart_subtotal_price': ?instance.formattedMaxCartSubtotalPrice,
  'shipping_method_costs': instance.shippingMethodCosts
      .map((e) => e.toJson())
      .toList(),
  'seller_price': ?instance.sellerPrice?.toJson(),
  'buyer_price': ?instance.buyerPrice?.toJson(),
  'formatted_price': ?instance.formattedPrice,
};
