import 'package:json_annotation/json_annotation.dart';

part 'wishlist.g.dart';

/// Represents an item in a wishlist deck.
///
/// A deck item specifies the desired card details such as blueprint,
/// expansion, language, condition, and other properties.
@JsonSerializable()
class DeckItem {
  /// The quantity of this item desired.
  final int quantity;

  /// The blueprint ID for this item.
  @JsonKey(name: 'blueprint_id')
  final int? blueprintId;

  /// The meta name used for text-based deck parsing.
  @JsonKey(name: 'meta_name')
  final String metaName;

  /// The expansion code (e.g., "DOM" for Dominaria).
  @JsonKey(name: 'expansion_code')
  final String? expansionCode;

  /// The collector number within the expansion.
  @JsonKey(name: 'collector_number')
  final String? collectorNumber;

  /// The language code (e.g., "en", "it").
  final String? language;

  /// The card condition (e.g., "Near Mint", "Played").
  final String? condition;

  /// Whether the card is foil.
  final String? foil;

  /// Whether the card is reverse foil.
  final String? reverse;

  /// Whether this is a first edition card.
  @JsonKey(name: 'first_edition')
  final bool? firstEdition;

  /// Constructs a [DeckItem] with the given details.
  DeckItem({
    required this.quantity,
    this.blueprintId,
    required this.metaName,
    this.expansionCode,
    this.collectorNumber,
    this.language,
    this.condition,
    this.foil,
    this.reverse,
    this.firstEdition,
  });

  /// Creates a [DeckItem] instance from a JSON map.
  factory DeckItem.fromJson(Map<String, dynamic> json) =>
      _$DeckItemFromJson(json);

  /// Converts the [DeckItem] instance to a JSON map.
  Map<String, dynamic> toJson() => _$DeckItemToJson(this);
}

/// Represents a wishlist containing desired cards.
///
/// Wishlists can be public or private and belong to a specific game.
/// They contain [DeckItem] entries specifying the desired cards.
@JsonSerializable()
class Wishlist {
  /// The unique identifier for this wishlist.
  final int id;

  /// The name of the wishlist.
  final String name;

  /// The game ID this wishlist belongs to.
  @JsonKey(name: 'game_id')
  final int gameId;

  /// Whether this wishlist is publicly visible.
  @JsonKey(name: 'public')
  final bool isPublic;

  /// When the wishlist was created.
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// When the wishlist was last updated.
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The items in this wishlist (only present in detail responses).
  final List<DeckItem>? items;

  /// Constructs a [Wishlist] with the given details.
  Wishlist({
    required this.id,
    required this.name,
    required this.gameId,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
    this.items,
  });

  /// Creates a [Wishlist] instance from a JSON map.
  factory Wishlist.fromJson(Map<String, dynamic> json) =>
      _$WishlistFromJson(json);

  /// Converts the [Wishlist] instance to a JSON map.
  Map<String, dynamic> toJson() => _$WishlistToJson(this);
}
