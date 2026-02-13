import 'package:json_annotation/json_annotation.dart';

part 'money.g.dart';

/// Represents a monetary value in CardTrader.
///
/// Money values are stored as cents (integer) with a currency code.
/// This allows for precise calculations without floating-point errors.
///
/// The API may return the currency code as either `currency` or
/// `currency_iso`. Both are normalized into the [currency] field.
@JsonSerializable()
class Money {
  /// The amount in cents (e.g., 1000 = 10.00).
  final int cents;

  /// The currency code (e.g., "EUR", "USD").
  ///
  /// Reads from `currency` if present, otherwise falls back to `currency_iso`.
  @JsonKey(readValue: _readCurrency)
  final String currency;

  /// The currency symbol (e.g., "€", "$").
  @JsonKey(name: 'currency_symbol')
  final String? currencySymbol;

  /// The formatted price string (e.g., "€0.20").
  final String? formatted;

  /// Constructs a [Money] instance with the given [cents] and [currency].
  Money({
    required this.cents,
    required this.currency,
    this.currencySymbol,
    this.formatted,
  });

  /// Creates a [Money] instance from a JSON map.
  factory Money.fromJson(Map<String, dynamic> json) => _$MoneyFromJson(json);

  /// Converts the [Money] instance to a JSON map.
  Map<String, dynamic> toJson() => _$MoneyToJson(this);

  /// Returns the amount as a decimal number in the currency's units.
  ///
  /// Example: 1000 cents = 10.00 currency units.
  double get amount => cents / 100.0;

  /// Returns a string representation of the money value, using the formatted string if available,
  /// otherwise falling back to a default format of "amount currency".
  @override
  String toString() => formatted ?? '${amount.toStringAsFixed(2)} $currency';

  /// Reads the currency value from the JSON map.
  ///
  /// Falls back to `currency_iso` if `currency` is not present.
  static Object? _readCurrency(Map<dynamic, dynamic> json, String key) =>
      json['currency'] ?? json['currency_iso'];
}
