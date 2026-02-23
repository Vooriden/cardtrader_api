import 'package:json_annotation/json_annotation.dart';
import 'money.dart';
import 'user.dart';

part 'ct0_box_item.g.dart';

/// Represents a CardTrader Zero (CT0) box item.
///
/// A CT0 Box Item is a product purchased via CardTrader Zero that has not
/// yet been sent to the buyer directly. Items are collected in the CT0 box
/// and periodically merged into a single shipment.
///
/// The [quantity] map contains counts by state:
/// - `ok`: Items in your CT0 box, ready to be delivered
/// - `pending`: Items on their way to your CT0 box
/// - `missing`: Items no longer available (refunded)
@JsonSerializable()
class Ct0BoxItem {
  /// A unique identifier for this CT0 box item.
  final int id;

  /// Quantity by state: `ok`, `pending`, `missing`.
  final Map<String, int> quantity;

  /// The seller's user info.
  final User seller;

  /// The ID of the product this item was created from.
  @JsonKey(name: 'product_id')
  final int productId;

  /// The ID of the blueprint this item's product is an instance of.
  @JsonKey(name: 'blueprint_id')
  final int blueprintId;

  /// The ID of the category this item belongs to.
  @JsonKey(name: 'category_id')
  final int categoryId;

  /// The ID of the game this item belongs to.
  @JsonKey(name: 'game_id')
  final int gameId;

  /// The name of this item.
  final String name;

  /// The name of the expansion this item belongs to.
  final String expansion;

  /// The number of items in the bundle. Can be null.
  @JsonKey(name: 'bundle_size')
  final int? bundleSize;

  /// The description of this item. Can be null.
  final String? description;

  /// Whether this item is graded.
  final bool graded;

  /// Key-value properties of this item.
  final Map<String, dynamic> properties;

  /// The price for the buyer, in the buyer's currency.
  @JsonKey(name: 'buyer_price')
  final Money buyerPrice;

  /// The formatted buyer price string (e.g., "€0.08").
  @JsonKey(name: 'formatted_price')
  final String formattedPrice;

  /// The Cardmarket ID for the blueprint. Can be null.
  @JsonKey(name: 'mkm_id')
  final dynamic mkmId;

  /// The TCGplayer ID for the blueprint. Can be null.
  @JsonKey(name: 'tcg_player_id')
  final dynamic tcgPlayerId;

  /// The Scryfall ID for the blueprint. Can be null.
  @JsonKey(name: 'scryfall_id')
  final String? scryfallId;

  /// Whether this was a presale item.
  final bool? presale;

  /// The date the presale ended, if applicable.
  @JsonKey(name: 'presale_ended_at')
  final DateTime? presaleEndedAt;

  /// The date this item was paid for.
  @JsonKey(name: 'paid_at')
  final DateTime paidAt;

  /// The estimated arrival date (for pending items).
  @JsonKey(name: 'estimated_arrived_at')
  final DateTime? estimatedArrivedAt;

  /// The actual arrival date (for items with `ok` state).
  @JsonKey(name: 'arrived_at')
  final DateTime? arrivedAt;

  /// The date this item was cancelled.
  @JsonKey(name: 'cancelled_at')
  final DateTime? cancelledAt;

  /// Whether this item should be returned to the seller.
  @JsonKey(name: 'return_to_seller')
  final bool? returnToSeller;

  /// Constructs a [Ct0BoxItem].
  Ct0BoxItem({
    required this.id,
    required this.quantity,
    required this.seller,
    required this.productId,
    required this.blueprintId,
    required this.categoryId,
    required this.gameId,
    required this.name,
    required this.expansion,
    this.bundleSize,
    this.description,
    required this.graded,
    required this.properties,
    required this.buyerPrice,
    required this.formattedPrice,
    this.mkmId,
    this.tcgPlayerId,
    this.scryfallId,
    this.presale,
    this.presaleEndedAt,
    required this.paidAt,
    this.estimatedArrivedAt,
    this.arrivedAt,
    this.cancelledAt,
    this.returnToSeller,
  });

  /// Creates a [Ct0BoxItem] from a JSON map.
  factory Ct0BoxItem.fromJson(Map<String, dynamic> json) =>
      _$Ct0BoxItemFromJson(json);

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() => _$Ct0BoxItemToJson(this);

  /// The number of items in `pending` state.
  int get pendingQuantity => quantity['pending'] ?? 0;

  /// The number of items in `ok` state (ready to be delivered).
  int get okQuantity => quantity['ok'] ?? 0;

  /// The number of items in `missing` state (refunded).
  int get missingQuantity => quantity['missing'] ?? 0;
}
