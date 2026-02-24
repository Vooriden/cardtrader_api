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
          productId: $checkedConvert('product_id', (v) => (v as num?)?.toInt()),
          blueprintId:
              $checkedConvert('blueprint_id', (v) => (v as num).toInt()),
          categoryId: $checkedConvert('category_id', (v) => (v as num).toInt()),
          gameId: $checkedConvert('game_id', (v) => (v as num).toInt()),
          name: $checkedConvert('name', (v) => v as String),
          expansion: $checkedConvert('expansion', (v) => v as String),
          properties:
              $checkedConvert('properties', (v) => v as Map<String, dynamic>),
          quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
          bundleSize:
              $checkedConvert('bundle_size', (v) => (v as num?)?.toInt()),
          description:
              $checkedConvert('description', (v) => v as String? ?? ''),
          sellerPrice: $checkedConvert(
              'seller_price',
              (v) =>
                  v == null ? null : Money.fromJson(v as Map<String, dynamic>)),
          buyerPrice: $checkedConvert(
              'buyer_price',
              (v) =>
                  v == null ? null : Money.fromJson(v as Map<String, dynamic>)),
          cancelledPrice: $checkedConvert(
              'cancelled_price',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Money.fromJson(e as Map<String, dynamic>))
                  .toList()),
          repurchasePrice: $checkedConvert(
              'repurchase_price',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Money.fromJson(e as Map<String, dynamic>))
                  .toList()),
          tag: $checkedConvert('tag', (v) => v as String? ?? ''),
          graded: $checkedConvert('graded', (v) => v as bool? ?? false),
          formattedPrice:
              $checkedConvert('formatted_price', (v) => v as String?),
          mkmId: $checkedConvert('mkm_id', (v) => v),
          userDataField:
              $checkedConvert('user_data_field', (v) => v as String?),
          tcgPlayerId: $checkedConvert('tcg_player_id', (v) => v),
          scryfallId: $checkedConvert('scryfall_id', (v) => v as String?),
          deletedAt: $checkedConvert('deleted_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
          createdAt:
              $checkedConvert('created_at', (v) => DateTime.parse(v as String)),
          hubPendingOrderId: $checkedConvert(
              'hub_pending_order_id', (v) => (v as num?)?.toInt()),
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
        'hubPendingOrderId': 'hub_pending_order_id'
      },
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      if (instance.productId case final value?) 'product_id': value,
      'blueprint_id': instance.blueprintId,
      'category_id': instance.categoryId,
      'game_id': instance.gameId,
      'name': instance.name,
      'expansion': instance.expansion,
      'properties': instance.properties,
      'quantity': instance.quantity,
      if (instance.bundleSize case final value?) 'bundle_size': value,
      'description': instance.description,
      if (instance.sellerPrice?.toJson() case final value?)
        'seller_price': value,
      if (instance.buyerPrice?.toJson() case final value?) 'buyer_price': value,
      if (instance.cancelledPrice?.map((e) => e.toJson()).toList()
          case final value?)
        'cancelled_price': value,
      if (instance.repurchasePrice?.map((e) => e.toJson()).toList()
          case final value?)
        'repurchase_price': value,
      'tag': instance.tag,
      'graded': instance.graded,
      if (instance.formattedPrice case final value?) 'formatted_price': value,
      if (instance.mkmId case final value?) 'mkm_id': value,
      if (instance.userDataField case final value?) 'user_data_field': value,
      if (instance.tcgPlayerId case final value?) 'tcg_player_id': value,
      if (instance.scryfallId case final value?) 'scryfall_id': value,
      if (instance.deletedAt?.toIso8601String() case final value?)
        'deleted_at': value,
      'created_at': instance.createdAt.toIso8601String(),
      if (instance.hubPendingOrderId case final value?)
        'hub_pending_order_id': value,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Order',
      json,
      ($checkedConvert) {
        final val = Order(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          code: $checkedConvert('code', (v) => v as String),
          transactionCode:
              $checkedConvert('transaction_code', (v) => v as String?),
          viaCardtraderZero:
              $checkedConvert('via_cardtrader_zero', (v) => v as bool),
          seller: $checkedConvert(
              'seller',
              (v) =>
                  v == null ? null : User.fromJson(v as Map<String, dynamic>)),
          buyer: $checkedConvert(
              'buyer',
              (v) =>
                  v == null ? null : User.fromJson(v as Map<String, dynamic>)),
          orderAs: $checkedConvert('order_as', (v) => v as String),
          state: $checkedConvert('state', (v) => v as String),
          size: $checkedConvert('size', (v) => (v as num).toInt()),
          paidAt: $checkedConvert(
              'paid_at', (v) => v == null ? null : DateTime.parse(v as String)),
          creditAddedToSellerAt: $checkedConvert('credit_added_to_seller_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
          sentAt: $checkedConvert(
              'sent_at', (v) => v == null ? null : DateTime.parse(v as String)),
          cancelledAt: $checkedConvert('cancelled_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
          cancelRequester: $checkedConvert(
              'cancel_requester',
              (v) =>
                  v == null ? null : User.fromJson(v as Map<String, dynamic>)),
          buyerTotal: $checkedConvert(
              'buyer_total',
              (v) =>
                  v == null ? null : Money.fromJson(v as Map<String, dynamic>)),
          sellerTotal: $checkedConvert(
              'seller_total',
              (v) =>
                  v == null ? null : Money.fromJson(v as Map<String, dynamic>)),
          presaleEndedAt: $checkedConvert('presale_ended_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
          feePercentage: $checkedConvert('fee_percentage', (v) => v as String?),
          feeAmount: $checkedConvert(
              'fee_amount',
              (v) =>
                  v == null ? null : Money.fromJson(v as Map<String, dynamic>)),
          sellerFeeAmount: $checkedConvert(
              'seller_fee_amount',
              (v) =>
                  v == null ? null : Money.fromJson(v as Map<String, dynamic>)),
          sellerSubtotal: $checkedConvert(
              'seller_subtotal',
              (v) =>
                  v == null ? null : Money.fromJson(v as Map<String, dynamic>)),
          buyerSubtotal: $checkedConvert(
              'buyer_subtotal',
              (v) =>
                  v == null ? null : Money.fromJson(v as Map<String, dynamic>)),
          packingNumber:
              $checkedConvert('packing_number', (v) => (v as num?)?.toInt()),
          orderShippingAddress: $checkedConvert(
              'order_shipping_address',
              (v) => v == null
                  ? null
                  : Address.fromJson(v as Map<String, dynamic>)),
          orderBillingAddress: $checkedConvert(
              'order_billing_address',
              (v) => v == null
                  ? null
                  : Address.fromJson(v as Map<String, dynamic>)),
          orderShippingMethod: $checkedConvert(
              'order_shipping_method',
              (v) => v == null
                  ? null
                  : ShippingMethod.fromJson(v as Map<String, dynamic>)),
          formattedSubtotal:
              $checkedConvert('formatted_subtotal', (v) => v as String?),
          formattedTotal:
              $checkedConvert('formatted_total', (v) => v as String?),
          presale: $checkedConvert('presale', (v) => v as bool?),
          orderItems: $checkedConvert(
              'order_items',
              (v) => (v as List<dynamic>)
                  .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
                  .toList()),
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
        'orderItems': 'order_items'
      },
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      if (instance.transactionCode case final value?) 'transaction_code': value,
      'via_cardtrader_zero': instance.viaCardtraderZero,
      if (instance.seller?.toJson() case final value?) 'seller': value,
      if (instance.buyer?.toJson() case final value?) 'buyer': value,
      'order_as': instance.orderAs,
      'state': instance.state,
      'size': instance.size,
      if (instance.paidAt?.toIso8601String() case final value?)
        'paid_at': value,
      if (instance.creditAddedToSellerAt?.toIso8601String() case final value?)
        'credit_added_to_seller_at': value,
      if (instance.sentAt?.toIso8601String() case final value?)
        'sent_at': value,
      if (instance.cancelledAt?.toIso8601String() case final value?)
        'cancelled_at': value,
      if (instance.cancelRequester?.toJson() case final value?)
        'cancel_requester': value,
      if (instance.buyerTotal?.toJson() case final value?) 'buyer_total': value,
      if (instance.sellerTotal?.toJson() case final value?)
        'seller_total': value,
      if (instance.presaleEndedAt?.toIso8601String() case final value?)
        'presale_ended_at': value,
      if (instance.feePercentage case final value?) 'fee_percentage': value,
      if (instance.feeAmount?.toJson() case final value?) 'fee_amount': value,
      if (instance.sellerFeeAmount?.toJson() case final value?)
        'seller_fee_amount': value,
      if (instance.sellerSubtotal?.toJson() case final value?)
        'seller_subtotal': value,
      if (instance.buyerSubtotal?.toJson() case final value?)
        'buyer_subtotal': value,
      if (instance.packingNumber case final value?) 'packing_number': value,
      if (instance.orderShippingAddress?.toJson() case final value?)
        'order_shipping_address': value,
      if (instance.orderBillingAddress?.toJson() case final value?)
        'order_billing_address': value,
      if (instance.orderShippingMethod?.toJson() case final value?)
        'order_shipping_method': value,
      if (instance.formattedSubtotal case final value?)
        'formatted_subtotal': value,
      if (instance.formattedTotal case final value?) 'formatted_total': value,
      if (instance.presale case final value?) 'presale': value,
      'order_items': instance.orderItems.map((e) => e.toJson()).toList(),
    };
