// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cardtrader_exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardTraderException _$CardTraderExceptionFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CardTraderException',
      json,
      ($checkedConvert) {
        final val = CardTraderException(
          statusCode: $checkedConvert('status_code', (v) => (v as num).toInt()),
          errorCode: $checkedConvert('error_code', (v) => v as String?),
          extra: $checkedConvert(
            'extra',
            (v) => v == null
                ? null
                : ExtraMessage.fromJson(v as Map<String, dynamic>),
          ),
          requestId: $checkedConvert('request_id', (v) => v as String?),
          errors: $checkedConvert(
            'errors',
            (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'statusCode': 'status_code',
        'errorCode': 'error_code',
        'requestId': 'request_id',
      },
    );

Map<String, dynamic> _$CardTraderExceptionToJson(
  CardTraderException instance,
) => <String, dynamic>{
  'status_code': instance.statusCode,
  'error_code': ?instance.errorCode,
  'extra': ?instance.extra?.toJson(),
  'request_id': ?instance.requestId,
  'errors': ?instance.errors,
};

ExtraMessage _$ExtraMessageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ExtraMessage', json, ($checkedConvert) {
      final val = ExtraMessage(
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ExtraMessageToJson(ExtraMessage instance) =>
    <String, dynamic>{'message': instance.message};
