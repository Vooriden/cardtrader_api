import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

/// Represents a physical address for billing or shipping.
///
/// Used in cart operations for specifying delivery and billing information.
@JsonSerializable()
class Address {
  /// The unique identifier for the address.
  final int? id;

  /// The user ID associated with this address.
  @JsonKey(name: 'user_id')
  final int? userId;

  /// The recipient or company name.
  final String name;

  /// The street address (including number).
  final String street;

  /// The postal/ZIP code.
  final String zip;

  /// The city name.
  final String city;

  /// The state or province name.
  @JsonKey(name: 'state_or_province')
  final String stateOrProvince;

  /// The country code (ISO 3166-1 alpha-2, e.g., "IT", "US").
  @JsonKey(name: 'country_code')
  final String countryCode;

  /// Phone number for contact.
  final String? phone;

  /// Whether to keep the original address format.
  @JsonKey(name: 'keep_original')
  final bool? keepOriginal;

  /// Whether this is the default billing address.
  @JsonKey(name: 'default_billing_address')
  final bool? defaultBillingAddress;

  /// Whether this is the default shipping address.
  @JsonKey(name: 'default_shipping_address')
  final bool? defaultShippingAddress;

  /// The latitude coordinate for the address.
  final double? latitude;

  /// The longitude coordinate for the address.
  final double? longitude;

  /// Additional delivery notes or instructions.
  final String? note;

  /// When the address was created.
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  /// When the address was last updated.
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  /// Constructs an [Address] with the given details.
  Address({
    this.id,
    this.userId,
    required this.name,
    required this.street,
    required this.zip,
    required this.city,
    required this.stateOrProvince,
    required this.countryCode,
    this.phone,
    this.keepOriginal,
    this.defaultBillingAddress,
    this.defaultShippingAddress,
    this.latitude,
    this.longitude,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  /// Creates an [Address] instance from a JSON map.
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  /// Converts the [Address] instance to a JSON map.
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
