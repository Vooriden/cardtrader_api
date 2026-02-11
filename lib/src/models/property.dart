import 'package:json_annotation/json_annotation.dart';

part 'property.g.dart';

/// Represents a property that can be applied to an object.
///
/// Properties define characteristics that a product or card
/// can have, such as condition, language, or edition.
@JsonSerializable()
class Property {
  /// The name of the property.
  final String name;

  /// The data type of the property.
  final String type;

  /// The default value for this property, if any.
  @JsonKey(name: 'default_value')
  final String? defaultValue;

  /// List of possible values for this property.
  @JsonKey(name: 'possible_values')
  final List<dynamic> possibleValues;

  /// Constructs a [Property] with the given details.
  Property({
    required this.name,
    required this.type,
    this.defaultValue,
    required this.possibleValues,
  });

  /// Creates a [Property] from a JSON map.
  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  /// Converts the [Property] instance to a JSON map.
  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}
