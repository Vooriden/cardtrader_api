import 'package:json_annotation/json_annotation.dart';

part 'wishlist.g.dart';

@JsonSerializable()
class DeckItem {
  final int? quantity;
  @JsonKey(name: 'blueprint_id')
  final int? blueprintId;
  @JsonKey(name: 'meta_name')
  final String? metaName;
  @JsonKey(name: 'expansion_code')
  final String? expansionCode;
  @JsonKey(name: 'collector_number')
  final String? collectorNumber;
  final String? language;
  final String? condition;
  final String? foil;
  final String? reverse;
  @JsonKey(name: 'first_edition')
  final bool? firstEdition;

  DeckItem({
    this.quantity,
    this.blueprintId,
    this.metaName,
    this.expansionCode,
    this.collectorNumber,
    this.language,
    this.condition,
    this.foil,
    this.reverse,
    this.firstEdition,
  });

  factory DeckItem.fromJson(Map<String, dynamic> json) =>
      _$DeckItemFromJson(json);

  Map<String, dynamic> toJson() => _$DeckItemToJson(this);
}

@JsonSerializable()
class Wishlist {
  final int id;
  final String name;
  @JsonKey(name: 'game_id')
  final int gameId;
  @JsonKey(name: 'public')
  final bool isPublic;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final List<DeckItem>? items;

  Wishlist({
    required this.id,
    required this.name,
    required this.gameId,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
    this.items,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) =>
      _$WishlistFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistToJson(this);
}
