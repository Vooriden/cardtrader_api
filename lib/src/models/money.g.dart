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
      );
      return val;
    });

Map<String, dynamic> _$MoneyToJson(Money instance) => <String, dynamic>{
  'cents': instance.cents,
  'currency': instance.currency,
};
