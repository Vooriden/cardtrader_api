// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Money _$MoneyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Money', json, ($checkedConvert) {
      final val = Money(
        cents: $checkedConvert('cents', (v) => (v as num).toInt()),
        currency: $checkedConvert('currency', (v) => v as String),
        currencySymbol: $checkedConvert('currency_symbol', (v) => v as String?),
        formatted: $checkedConvert('formatted', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'currencySymbol': 'currency_symbol'});

Map<String, dynamic> _$MoneyToJson(Money instance) => <String, dynamic>{
  'cents': instance.cents,
  'currency': instance.currency,
  'currency_symbol': ?instance.currencySymbol,
  'formatted': ?instance.formatted,
};
