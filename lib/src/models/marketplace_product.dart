import 'package:json_annotation/json_annotation.dart';
import 'expansion.dart';
import 'money.dart';
import 'user.dart';

part 'marketplace_product.g.dart';

@JsonSerializable()
class MarketplaceProduct {
  final int id;
  @JsonKey(name: 'blueprint_id')
  final int blueprintId;
  @JsonKey(name: 'name_en')
  final String nameEn;
  final int quantity;
  final Money price;
  final String description;
  @JsonKey(name: 'properties_hash')
  final Map<String, dynamic> propertiesHash;
  final Expansion expansion;
  final User user;
  final bool graded;
  @JsonKey(name: 'on_vacation')
  final bool onVacation;
  @JsonKey(name: 'bundle_size')
  final int bundleSize;

  MarketplaceProduct({
    required this.id,
    required this.blueprintId,
    required this.nameEn,
    required this.quantity,
    required this.price,
    required this.description,
    required this.propertiesHash,
    required this.expansion,
    required this.user,
    required this.graded,
    required this.onVacation,
    required this.bundleSize,
  });

  factory MarketplaceProduct.fromJson(Map<String, dynamic> json) =>
      _$MarketplaceProductFromJson(json);

  Map<String, dynamic> toJson() => _$MarketplaceProductToJson(this);
}
