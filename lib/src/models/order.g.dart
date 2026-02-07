// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => $checkedCreate(
  'OrderItem',
  json,
  ($checkedConvert) {
    final val = OrderItem(
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      productId: $checkedConvert('product_id', (v) => (v as num).toInt()),
      blueprintId: $checkedConvert('blueprint_id', (v) => (v as num).toInt()),
      categoryId: $checkedConvert('category_id', (v) => (v as num).toInt()),
      gameId: $checkedConvert('game_id', (v) => (v as num).toInt()),
      name: $checkedConvert('name', (v) => v as String),
      expansion: $checkedConvert('expansion', (v) => v as String),
      properties: $checkedConvert(
        'properties',
        (v) => v as Map<String, dynamic>,
      ),
      quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
      bundleSize: $checkedConvert('bundle_size', (v) => (v as num).toInt()),
      description: $checkedConvert('description', (v) => v as String? ?? ''),
      sellerPrice: $checkedConvert(
        'seller_price',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      buyerPrice: $checkedConvert(
        'buyer_price',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      cancelledPrice: $checkedConvert(
        'cancelled_price',
        (v) => (v as List<dynamic>?)
            ?.map((e) => Money.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      repurchasePrice: $checkedConvert(
        'repurchase_price',
        (v) => (v as List<dynamic>?)
            ?.map((e) => Money.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      tag: $checkedConvert('tag', (v) => v as String? ?? ''),
      graded: $checkedConvert('graded', (v) => v as bool? ?? false),
      formattedPrice: $checkedConvert('formatted_price', (v) => v as String?),
      mkmId: $checkedConvert('mkm_id', (v) => v as String?),
      userDataField: $checkedConvert('user_data_field', (v) => v as String?),
      tcgPlayerId: $checkedConvert('tcg_player_id', (v) => v as String?),
      scryfallId: $checkedConvert('scryfall_id', (v) => v as String?),
      deletedAt: $checkedConvert(
        'deleted_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      hubPendingOrderId: $checkedConvert(
        'hub_pending_order_id',
        (v) => (v as num?)?.toInt(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'productId': 'product_id',
    'blueprintId': 'blueprint_id',
    'categoryId': 'category_id',
    'gameId': 'game_id',
    'bundleSize': 'bundle_size',
    'sellerPrice': 'seller_price',
    'buyerPrice': 'buyer_price',
    'cancelledPrice': 'cancelled_price',
    'repurchasePrice': 'repurchase_price',
    'formattedPrice': 'formatted_price',
    'mkmId': 'mkm_id',
    'userDataField': 'user_data_field',
    'tcgPlayerId': 'tcg_player_id',
    'scryfallId': 'scryfall_id',
    'deletedAt': 'deleted_at',
    'createdAt': 'created_at',
    'hubPendingOrderId': 'hub_pending_order_id',
  },
);

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
  'id': instance.id,
  'product_id': instance.productId,
  'blueprint_id': instance.blueprintId,
  'category_id': instance.categoryId,
  'game_id': instance.gameId,
  'name': instance.name,
  'expansion': instance.expansion,
  'properties': instance.properties,
  'quantity': instance.quantity,
  'bundle_size': instance.bundleSize,
  'description': instance.description,
  'seller_price': ?instance.sellerPrice?.toJson(),
  'buyer_price': ?instance.buyerPrice?.toJson(),
  'cancelled_price': ?instance.cancelledPrice?.map((e) => e.toJson()).toList(),
  'repurchase_price': ?instance.repurchasePrice
      ?.map((e) => e.toJson())
      .toList(),
  'tag': instance.tag,
  'graded': instance.graded,
  'formatted_price': ?instance.formattedPrice,
  'mkm_id': ?instance.mkmId,
  'user_data_field': ?instance.userDataField,
  'tcg_player_id': ?instance.tcgPlayerId,
  'scryfall_id': ?instance.scryfallId,
  'deleted_at': ?instance.deletedAt?.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
  'hub_pending_order_id': ?instance.hubPendingOrderId,
};

Order _$OrderFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Order',
  json,
  ($checkedConvert) {
    final val = Order(
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      code: $checkedConvert('code', (v) => v as String),
      transactionCode: $checkedConvert('transaction_code', (v) => v as String?),
      viaCardtraderZero: $checkedConvert(
        'via_cardtrader_zero',
        (v) => v as bool,
      ),
      seller: $checkedConvert(
        'seller',
        (v) => v == null ? null : User.fromJson(v as Map<String, dynamic>),
      ),
      buyer: $checkedConvert(
        'buyer',
        (v) => v == null ? null : User.fromJson(v as Map<String, dynamic>),
      ),
      orderAs: $checkedConvert('order_as', (v) => v as String),
      state: $checkedConvert('state', (v) => v as String),
      size: $checkedConvert('size', (v) => (v as num).toInt()),
      paidAt: $checkedConvert(
        'paid_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      creditAddedToSellerAt: $checkedConvert(
        'credit_added_to_seller_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      sentAt: $checkedConvert(
        'sent_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      cancelledAt: $checkedConvert(
        'cancelled_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      cancelRequester: $checkedConvert(
        'cancel_requester',
        (v) => v == null ? null : User.fromJson(v as Map<String, dynamic>),
      ),
      buyerTotal: $checkedConvert(
        'buyer_total',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      sellerTotal: $checkedConvert(
        'seller_total',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      presaleEndedAt: $checkedConvert(
        'presale_ended_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      feePercentage: $checkedConvert('fee_percentage', (v) => v as String?),
      feeAmount: $checkedConvert(
        'fee_amount',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      sellerFeeAmount: $checkedConvert(
        'seller_fee_amount',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      sellerSubtotal: $checkedConvert(
        'seller_subtotal',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      buyerSubtotal: $checkedConvert(
        'buyer_subtotal',
        (v) => v == null ? null : Money.fromJson(v as Map<String, dynamic>),
      ),
      packingNumber: $checkedConvert(
        'packing_number',
        (v) => (v as num?)?.toInt(),
      ),
      orderShippingAddress: $checkedConvert(
        'order_shipping_address',
        (v) => v == null ? null : Address.fromJson(v as Map<String, dynamic>),
      ),
      orderBillingAddress: $checkedConvert(
        'order_billing_address',
        (v) => v == null ? null : Address.fromJson(v as Map<String, dynamic>),
      ),
      orderShippingMethod: $checkedConvert(
        'order_shipping_method',
        (v) => v == null
            ? null
            : ShippingMethod.fromJson(v as Map<String, dynamic>),
      ),
      formattedSubtotal: $checkedConvert(
        'formatted_subtotal',
        (v) => v as String?,
      ),
      formattedTotal: $checkedConvert('formatted_total', (v) => v as String?),
      presale: $checkedConvert('presale', (v) => v as bool?),
      orderItems: $checkedConvert(
        'order_items',
        (v) => (v as List<dynamic>)
            .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'transactionCode': 'transaction_code',
    'viaCardtraderZero': 'via_cardtrader_zero',
    'orderAs': 'order_as',
    'paidAt': 'paid_at',
    'creditAddedToSellerAt': 'credit_added_to_seller_at',
    'sentAt': 'sent_at',
    'cancelledAt': 'cancelled_at',
    'cancelRequester': 'cancel_requester',
    'buyerTotal': 'buyer_total',
    'sellerTotal': 'seller_total',
    'presaleEndedAt': 'presale_ended_at',
    'feePercentage': 'fee_percentage',
    'feeAmount': 'fee_amount',
    'sellerFeeAmount': 'seller_fee_amount',
    'sellerSubtotal': 'seller_subtotal',
    'buyerSubtotal': 'buyer_subtotal',
    'packingNumber': 'packing_number',
    'orderShippingAddress': 'order_shipping_address',
    'orderBillingAddress': 'order_billing_address',
    'orderShippingMethod': 'order_shipping_method',
    'formattedSubtotal': 'formatted_subtotal',
    'formattedTotal': 'formatted_total',
    'orderItems': 'order_items',
  },
);

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'transaction_code': ?instance.transactionCode,
  'via_cardtrader_zero': instance.viaCardtraderZero,
  'seller': ?instance.seller?.toJson(),
  'buyer': ?instance.buyer?.toJson(),
  'order_as': instance.orderAs,
  'state': instance.state,
  'size': instance.size,
  'paid_at': ?instance.paidAt?.toIso8601String(),
  'credit_added_to_seller_at': ?instance.creditAddedToSellerAt
      ?.toIso8601String(),
  'sent_at': ?instance.sentAt?.toIso8601String(),
  'cancelled_at': ?instance.cancelledAt?.toIso8601String(),
  'cancel_requester': ?instance.cancelRequester?.toJson(),
  'buyer_total': ?instance.buyerTotal?.toJson(),
  'seller_total': ?instance.sellerTotal?.toJson(),
  'presale_ended_at': ?instance.presaleEndedAt?.toIso8601String(),
  'fee_percentage': ?instance.feePercentage,
  'fee_amount': ?instance.feeAmount?.toJson(),
  'seller_fee_amount': ?instance.sellerFeeAmount?.toJson(),
  'seller_subtotal': ?instance.sellerSubtotal?.toJson(),
  'buyer_subtotal': ?instance.buyerSubtotal?.toJson(),
  'packing_number': ?instance.packingNumber,
  'order_shipping_address': ?instance.orderShippingAddress?.toJson(),
  'order_billing_address': ?instance.orderBillingAddress?.toJson(),
  'order_shipping_method': ?instance.orderShippingMethod?.toJson(),
  'formatted_subtotal': ?instance.formattedSubtotal,
  'formatted_total': ?instance.formattedTotal,
  'presale': ?instance.presale,
  'order_items': instance.orderItems.map((e) => e.toJson()).toList(),
};
