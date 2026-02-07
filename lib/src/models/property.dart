import 'package:json_annotation/json_annotation.dart';

part 'property.g.dart';

@JsonSerializable()
class Property {
  final String name;
  final String type;
  @JsonKey(name: 'possible_values')
  final List<dynamic> possibleValues;

  Property({
    required this.name,
    required this.type,
    required this.possibleValues,
  });

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}
