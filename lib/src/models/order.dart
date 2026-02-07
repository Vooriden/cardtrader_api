import 'package:json_annotation/json_annotation.dart';
import 'address.dart';
import 'money.dart';
import 'shipping_method.dart';
import 'user.dart';

part 'order.g.dart';

@JsonSerializable()
class OrderItem {
  final int id;
  @JsonKey(name: 'product_id')
  final int productId;
  @JsonKey(name: 'blueprint_id')
  final int blueprintId;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'game_id')
  final int gameId;
  final String name;
  final String expansion;
  final Map<String, dynamic> properties;
  final int quantity;
  @JsonKey(name: 'bundle_size')
  final int bundleSize;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(name: 'seller_price')
  final Money? sellerPrice;
  @JsonKey(name: 'buyer_price')
  final Money? buyerPrice;
  @JsonKey(name: 'cancelled_price')
  final List<Money>? cancelledPrice;
  @JsonKey(name: 'repurchase_price')
  final List<Money>? repurchasePrice;
  @JsonKey(defaultValue: '')
  final String tag;
  @JsonKey(defaultValue: false)
  final bool graded;
  @JsonKey(name: 'formatted_price')
  final String? formattedPrice;
  @JsonKey(name: 'mkm_id')
  final String? mkmId;
  @JsonKey(name: 'user_data_field')
  final String? userDataField;
  @JsonKey(name: 'tcg_player_id')
  final String? tcgPlayerId;
  @JsonKey(name: 'scryfall_id')
  final String? scryfallId;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'hub_pending_order_id')
  final int? hubPendingOrderId;

  OrderItem({
    required this.id,
    required this.productId,
    required this.blueprintId,
    required this.categoryId,
    required this.gameId,
    required this.name,
    required this.expansion,
    required this.properties,
    required this.quantity,
    required this.bundleSize,
    required this.description,
    this.sellerPrice,
    this.buyerPrice,
    this.cancelledPrice,
    this.repurchasePrice,
    required this.tag,
    required this.graded,
    this.formattedPrice,
    this.mkmId,
    this.userDataField,
    this.tcgPlayerId,
    this.scryfallId,
    this.deletedAt,
    required this.createdAt,
    this.hubPendingOrderId,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

@JsonSerializable()
class Order {
  final int id;
  final String code;
  @JsonKey(name: 'transaction_code')
  final String? transactionCode;
  @JsonKey(name: 'via_cardtrader_zero')
  final bool viaCardtraderZero;
  final User? seller;
  final User? buyer;
  @JsonKey(name: 'order_as')
  final String orderAs;
  final String state;
  final int size;
  @JsonKey(name: 'paid_at')
  final DateTime? paidAt;
  @JsonKey(name: 'credit_added_to_seller_at')
  final DateTime? creditAddedToSellerAt;
  @JsonKey(name: 'sent_at')
  final DateTime? sentAt;
  @JsonKey(name: 'cancelled_at')
  final DateTime? cancelledAt;
  @JsonKey(name: 'cancel_requester')
  final User? cancelRequester;
  @JsonKey(name: 'buyer_total')
  final Money? buyerTotal;
  @JsonKey(name: 'seller_total')
  final Money? sellerTotal;
  @JsonKey(name: 'presale_ended_at')
  final DateTime? presaleEndedAt;
  @JsonKey(name: 'fee_percentage')
  final String? feePercentage;
  @JsonKey(name: 'fee_amount')
  final Money? feeAmount;
  @JsonKey(name: 'seller_fee_amount')
  final Money? sellerFeeAmount;
  @JsonKey(name: 'seller_subtotal')
  final Money? sellerSubtotal;
  @JsonKey(name: 'buyer_subtotal')
  final Money? buyerSubtotal;
  @JsonKey(name: 'packing_number')
  final int? packingNumber;
  @JsonKey(name: 'order_shipping_address')
  final Address? orderShippingAddress;
  @JsonKey(name: 'order_billing_address')
  final Address? orderBillingAddress;
  @JsonKey(name: 'order_shipping_method')
  final ShippingMethod? orderShippingMethod;
  @JsonKey(name: 'formatted_subtotal')
  final String? formattedSubtotal;
  @JsonKey(name: 'formatted_total')
  final String? formattedTotal;
  final bool? presale;
  @JsonKey(name: 'order_items')
  final List<OrderItem> orderItems;

  Order({
    required this.id,
    required this.code,
    this.transactionCode,
    required this.viaCardtraderZero,
    this.seller,
    this.buyer,
    required this.orderAs,
    required this.state,
    required this.size,
    this.paidAt,
    this.creditAddedToSellerAt,
    this.sentAt,
    this.cancelledAt,
    this.cancelRequester,
    this.buyerTotal,
    this.sellerTotal,
    this.presaleEndedAt,
    this.feePercentage,
    this.feeAmount,
    this.sellerFeeAmount,
    this.sellerSubtotal,
    this.buyerSubtotal,
    this.packingNumber,
    this.orderShippingAddress,
    this.orderBillingAddress,
    this.orderShippingMethod,
    this.formattedSubtotal,
    this.formattedTotal,
    this.presale,
    required this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
