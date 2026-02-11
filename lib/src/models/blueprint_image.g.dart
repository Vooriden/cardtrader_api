// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blueprint_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlueprintImageVariant _$BlueprintImageVariantFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BlueprintImageVariant', json, ($checkedConvert) {
  final val = BlueprintImageVariant(
    url: $checkedConvert('url', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$BlueprintImageVariantToJson(
  BlueprintImageVariant instance,
) => <String, dynamic>{'url': instance.url};

BlueprintImage _$BlueprintImageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BlueprintImage', json, ($checkedConvert) {
      final val = BlueprintImage(
        url: $checkedConvert('url', (v) => v as String),
        show: $checkedConvert(
          'show',
          (v) => v == null
              ? null
              : BlueprintImageVariant.fromJson(v as Map<String, dynamic>),
        ),
        preview: $checkedConvert(
          'preview',
          (v) => v == null
              ? null
              : BlueprintImageVariant.fromJson(v as Map<String, dynamic>),
        ),
        social: $checkedConvert(
          'social',
          (v) => v == null
              ? null
              : BlueprintImageVariant.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$BlueprintImageToJson(BlueprintImage instance) =>
    <String, dynamic>{
      'url': instance.url,
      'show': ?instance.show?.toJson(),
      'preview': ?instance.preview?.toJson(),
      'social': ?instance.social?.toJson(),
    };
