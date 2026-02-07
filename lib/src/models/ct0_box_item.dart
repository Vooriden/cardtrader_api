import 'package:json_annotation/json_annotation.dart';
import 'money.dart';
import 'user.dart';

part 'ct0_box_item.g.dart';

@JsonSerializable()
class Ct0BoxItem {
  final int id;
  final Map<String, int> quantity;
  final User seller;
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
  @JsonKey(name: 'bundle_size')
  final int bundleSize;
  final String description;
  final bool graded;
  final Map<String, dynamic> properties;
  @JsonKey(name: 'buyer_price')
  final Money buyerPrice;
  @JsonKey(name: 'formatted_price')
  final String formattedPrice;
  @JsonKey(name: 'mkm_id')
  final String? mkmId;
  @JsonKey(name: 'tcg_player_id')
  final String? tcgPlayerId;
  @JsonKey(name: 'scryfall_id')
  final String? scryfallId;
  final bool? presale;
  @JsonKey(name: 'presale_ended_at')
  final DateTime? presaleEndedAt;
  @JsonKey(name: 'paid_at')
  final DateTime paidAt;
  @JsonKey(name: 'estimated_arrived_at')
  final DateTime? estimatedArrivedAt;
  @JsonKey(name: 'arrived_at')
  final DateTime? arrivedAt;
  @JsonKey(name: 'cancelled_at')
  final DateTime? cancelledAt;

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
    required this.bundleSize,
    required this.description,
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
  });

  factory Ct0BoxItem.fromJson(Map<String, dynamic> json) =>
      _$Ct0BoxItemFromJson(json);

  Map<String, dynamic> toJson() => _$Ct0BoxItemToJson(this);

  int get pendingQuantity => quantity['pending'] ?? 0;
  int get okQuantity => quantity['ok'] ?? 0;
  int get missingQuantity => quantity['missing'] ?? 0;
}
