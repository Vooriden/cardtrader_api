import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String username;
  @JsonKey(name: 'can_sell_via_hub')
  final bool? canSellViaHub;
  @JsonKey(name: 'country_code')
  final String? countryCode;
  @JsonKey(name: 'user_type')
  final String? userType;
  @JsonKey(name: 'max_sellable_in24h_quantity')
  final int? maxSellableIn24hQuantity;

  User({
    required this.id,
    required this.username,
    this.canSellViaHub,
    this.countryCode,
    this.userType,
    this.maxSellableIn24hQuantity,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
