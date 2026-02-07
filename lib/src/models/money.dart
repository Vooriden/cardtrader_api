import 'package:json_annotation/json_annotation.dart';

part 'money.g.dart';

@JsonSerializable()
class Money {
  final int cents;
  final String currency;

  Money({required this.cents, required this.currency});

  factory Money.fromJson(Map<String, dynamic> json) => _$MoneyFromJson(json);

  Map<String, dynamic> toJson() => _$MoneyToJson(this);

  double get amount => cents / 100.0;

  @override
  String toString() => '${amount.toStringAsFixed(2)} $currency';
}
