// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Property',
      json,
      ($checkedConvert) {
        final val = Property(
          name: $checkedConvert('name', (v) => v as String),
          type: $checkedConvert('type', (v) => v as String),
          defaultValue: $checkedConvert('default_value', (v) => v as String?),
          possibleValues:
              $checkedConvert('possible_values', (v) => v as List<dynamic>),
        );
        return val;
      },
      fieldKeyMap: const {
        'defaultValue': 'default_value',
        'possibleValues': 'possible_values'
      },
    );

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      if (instance.defaultValue case final value?) 'default_value': value,
      'possible_values': instance.possibleValues,
    };
