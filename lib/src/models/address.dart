import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final int? id;
  final String name;
  final String street;
  final String zip;
  final String city;
  @JsonKey(name: 'state_or_province')
  final String stateOrProvince;
  @JsonKey(name: 'country_code')
  final String countryCode;
  final String? country;
  final String? note;

  Address({
    this.id,
    required this.name,
    required this.street,
    required this.zip,
    required this.city,
    required this.stateOrProvince,
    required this.countryCode,
    this.country,
    this.note,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
