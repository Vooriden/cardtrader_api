import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// Represents a user (seller) in the CardTrader marketplace.
///
/// Contains information about sellers including their selling preferences
/// and location details.
@JsonSerializable()
class User {
  /// The unique identifier for the user.
  final int id;

  /// The user's display name.
  final String username;

  /// Whether the user can sell via CardTrader Zero (hub).
  @JsonKey(name: 'can_sell_via_hub')
  final bool? canSellViaHub;

  /// The user's country code (ISO 3166-1 alpha-2, e.g., "IT", "US").
  @JsonKey(name: 'country_code')
  final String? countryCode;

  /// The type of user account (e.g., "normal", "professional").
  @JsonKey(name: 'user_type')
  final String? userType;

  /// Maximum quantity the user can sell in 24 hours.
  @JsonKey(name: 'max_sellable_in24h_quantity')
  final int? maxSellableIn24hQuantity;

  /// Whether the user has too many cancellation requests as a seller.
  @JsonKey(name: 'too_many_request_for_cancel_as_seller')
  final bool? tooManyRequestForCancelAsSeller;

  /// Whether the user can sell sealed products with CardTrader Zero.
  @JsonKey(name: 'can_sell_sealed_with_ct_zero')
  final bool? canSellSealedWithCtZero;

  /// Constructs a [User] with the given details.
  User({
    required this.id,
    required this.username,
    this.canSellViaHub,
    this.countryCode,
    this.userType,
    this.maxSellableIn24hQuantity,
    this.tooManyRequestForCancelAsSeller,
    this.canSellSealedWithCtZero,
  });

  /// Creates a [User] instance from a JSON map.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Converts the [User] instance to a JSON map.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
