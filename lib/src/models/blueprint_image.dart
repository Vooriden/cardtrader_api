import 'package:json_annotation/json_annotation.dart';

part 'blueprint_image.g.dart';

/// Represents an image variant URL for a blueprint.
@JsonSerializable()
class BlueprintImageVariant {
  /// The URL of the image variant.
  final String url;

  /// Constructs a [BlueprintImageVariant] with the given URL.
  BlueprintImageVariant({required this.url});

  /// Creates a [BlueprintImageVariant] from a JSON map.
  factory BlueprintImageVariant.fromJson(Map<String, dynamic> json) =>
      _$BlueprintImageVariantFromJson(json);

  /// Converts the [BlueprintImageVariant] instance to a JSON map.
  Map<String, dynamic> toJson() => _$BlueprintImageVariantToJson(this);
}

/// Represents the image data for a blueprint with multiple size variants.
///
/// The urls are relative paths that can be appended to the base URL of
/// the CardTrader website (https://cardtrader.com).
@JsonSerializable()
class BlueprintImage {
  /// The URL of the main image for the blueprint.
  final String url;

  /// The show-size variant of the image.
  final BlueprintImageVariant? show;

  /// The preview-size variant of the image.
  final BlueprintImageVariant? preview;

  /// The social-size variant of the image.
  final BlueprintImageVariant? social;

  /// Constructs a [BlueprintImage] with the given URL and optional variants.
  BlueprintImage({required this.url, this.show, this.preview, this.social});

  /// Creates a [BlueprintImage] from a JSON map.
  factory BlueprintImage.fromJson(Map<String, dynamic> json) =>
      _$BlueprintImageFromJson(json);

  /// Converts the [BlueprintImage] instance to a JSON map.
  Map<String, dynamic> toJson() => _$BlueprintImageToJson(this);
}
