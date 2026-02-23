import 'package:json_annotation/json_annotation.dart';
import 'address.dart';
import 'money.dart';
import 'shipping_method.dart';
import 'user.dart';

part 'order.g.dart';

/// Represents a specific item within an [Order].
///
/// An OrderItem corresponds to a product that was sold/purchased,
/// with its price, quantity, and associated metadata.
@JsonSerializable()
class OrderItem {
  /// A unique identifier for this order item.
  final int id;

  /// The ID of the product this item was created from. Can be null.
  @JsonKey(name: 'product_id')
  final int? productId;

  /// The ID of the blueprint this item's product is an instance of.
  @JsonKey(name: 'blueprint_id')
  final int blueprintId;

  /// The ID of the category this item belongs to.
  @JsonKey(name: 'category_id')
  final int categoryId;

  /// The ID of the game this item belongs to.
  @JsonKey(name: 'game_id')
  final int gameId;

  /// The name of the product.
  final String name;

  /// The name of the expansion this item belongs to.
  final String expansion;

  /// Key-value properties of this item (condition, language, foil, etc.).
  final Map<String, dynamic> properties;

  /// The quantity sold.
  final int quantity;

  /// The number of items in the bundle.
  @JsonKey(name: 'bundle_size')
  final int? bundleSize;

  /// The description of the product.
  @JsonKey(defaultValue: '')
  final String description;

  /// The price for the seller, in the seller's currency.
  /// Visible only if you are the seller.
  @JsonKey(name: 'seller_price')
  final Money? sellerPrice;

  /// The price for the buyer, in the buyer's currency.
  /// Visible only if you are the buyer.
  @JsonKey(name: 'buyer_price')
  final Money? buyerPrice;

  /// The price charged for cancelled items.
  /// Visible only if you are the seller.
  @JsonKey(name: 'cancelled_price')
  final List<Money>? cancelledPrice;

  /// The extra amount charged for repurchase of this item.
  /// Visible only if you are the seller.
  @JsonKey(name: 'repurchase_price')
  final List<Money>? repurchasePrice;

  /// Tag, visible only to the seller.
  @JsonKey(defaultValue: '')
  final String tag;

  /// Whether this product is graded.
  @JsonKey(defaultValue: false)
  final bool graded;

  /// The formatted price string.
  @JsonKey(name: 'formatted_price')
  final String? formattedPrice;

  /// The Cardmarket ID for the blueprint. Can be int or String.
  @JsonKey(name: 'mkm_id')
  final dynamic mkmId;

  /// Custom user data field.
  @JsonKey(name: 'user_data_field')
  final String? userDataField;

  /// The TCGplayer ID for the blueprint. Can be int or String.
  @JsonKey(name: 'tcg_player_id')
  final dynamic tcgPlayerId;

  /// The Scryfall ID for the blueprint.
  @JsonKey(name: 'scryfall_id')
  final String? scryfallId;

  /// The date this item was deleted upon the buyer's request.
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  /// The date this item was created.
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// The hub pending order ID (for CT0 presale tracking).
  @JsonKey(name: 'hub_pending_order_id')
  final int? hubPendingOrderId;

  /// Constructs an [OrderItem].
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

  /// Creates an [OrderItem] from a JSON map.
  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

/// Represents an order in CardTrader.
///
/// An order is a purchase transaction. It contains information about
/// the buyer, seller, items, totals, addresses, and shipping details.
///
/// Orders go through a lifecycle of states:
/// - `hub_pending` (CT0 only): Items sold but not yet sent
/// - `paid`: Payment received, ready to ship
/// - `sent`: Shipped by seller
/// - `arrived`: Received by buyer
/// - `done`: Completed (after review or timeout)
/// - `request_for_cancel`: Cancellation requested
/// - `canceled`: Cancellation confirmed
/// - `lost`: Package lost in transit
@JsonSerializable()
class Order {
  /// A unique identifier for this order.
  final int id;

  /// A code to identify this order.
  final String code;

  /// The transaction code of the order.
  @JsonKey(name: 'transaction_code')
  final String? transactionCode;

  /// Whether this order was placed via CardTrader Zero.
  @JsonKey(name: 'via_cardtrader_zero')
  final bool viaCardtraderZero;

  /// The seller's user info. Visible only if you are the buyer.
  final User? seller;

  /// The buyer's user info. Visible only if you are the seller.
  final User? buyer;

  /// Your role in the order: "seller" or "buyer".
  @JsonKey(name: 'order_as')
  final String orderAs;

  /// The current state of the order.
  final String state;

  /// The number of items in this order.
  final int size;

  /// The date the order was paid.
  @JsonKey(name: 'paid_at')
  final DateTime? paidAt;

  /// The date the credit was transferred to the seller.
  @JsonKey(name: 'credit_added_to_seller_at')
  final DateTime? creditAddedToSellerAt;

  /// The date the order was sent.
  @JsonKey(name: 'sent_at')
  final DateTime? sentAt;

  /// The date the order was cancelled.
  @JsonKey(name: 'cancelled_at')
  final DateTime? cancelledAt;

  /// The user who requested cancellation. Can be null.
  @JsonKey(name: 'cancel_requester')
  final User? cancelRequester;

  /// The total for the buyer, in the buyer's currency.
  @JsonKey(name: 'buyer_total')
  final Money? buyerTotal;

  /// The total for the seller, in the seller's currency.
  @JsonKey(name: 'seller_total')
  final Money? sellerTotal;

  /// The date the presale ended, if applicable.
  @JsonKey(name: 'presale_ended_at')
  final DateTime? presaleEndedAt;

  /// The commission percentage on this order.
  @JsonKey(name: 'fee_percentage')
  final String? feePercentage;

  /// The commission amount for this order.
  @JsonKey(name: 'fee_amount')
  final Money? feeAmount;

  /// The total seller commission amount.
  @JsonKey(name: 'seller_fee_amount')
  final Money? sellerFeeAmount;

  /// The subtotal for the seller.
  @JsonKey(name: 'seller_subtotal')
  final Money? sellerSubtotal;

  /// The subtotal for the buyer.
  @JsonKey(name: 'buyer_subtotal')
  final Money? buyerSubtotal;

  /// A unique packing number for unshipped orders.
  @JsonKey(name: 'packing_number')
  final int? packingNumber;

  /// The shipping address for this order.
  @JsonKey(name: 'order_shipping_address')
  final Address? orderShippingAddress;

  /// The billing address for this order.
  @JsonKey(name: 'order_billing_address')
  final Address? orderBillingAddress;

  /// The shipping method for this order.
  @JsonKey(name: 'order_shipping_method')
  final ShippingMethod? orderShippingMethod;

  /// The formatted subtotal string.
  @JsonKey(name: 'formatted_subtotal')
  final String? formattedSubtotal;

  /// The formatted total string.
  @JsonKey(name: 'formatted_total')
  final String? formattedTotal;

  /// Whether this was a presale order.
  final bool? presale;

  /// The items in this order.
  @JsonKey(name: 'order_items')
  final List<OrderItem> orderItems;

  /// Constructs an [Order].
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

  /// Creates an [Order] from a JSON map.
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  /// Whether the order is in the `paid` state.
  bool get isPaid => state == 'paid';

  /// Whether the order is in the `sent` state.
  bool get isSent => state == 'sent';

  /// Whether the order is in the `hub_pending` state (CT0).
  bool get isHubPending => state == 'hub_pending';

  /// Whether the order is in the `arrived` state.
  bool get isArrived => state == 'arrived';

  /// Whether the order is in the `done` state.
  bool get isDone => state == 'done';

  /// Whether the order is in the `canceled` state.
  bool get isCanceled => state == 'canceled';

  /// Whether the order is in the `request_for_cancel` state.
  bool get isRequestForCancel => state == 'request_for_cancel';

  /// Whether the order is in the `lost` state.
  bool get isLost => state == 'lost';
}
