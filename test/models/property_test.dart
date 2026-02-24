import 'package:cardtrader_api/src/models/property.dart';
import 'package:test/test.dart';

void main() {
  group('Property', () {
    final json = {
      "name": "condition",
      "type": "string",
      "default_value": "Near Mint",
      "possible_values": ["Near Mint", "Excellent", "Good", "Poor"],
    };

    group('fromJson', () {
      test('parses JSON correctly with all fields', () {
        final property = Property.fromJson(json);

        expect(
          property,
          isA<Property>()
              .having((p) => p.name, 'name', 'condition')
              .having((p) => p.type, 'type', 'string')
              .having((p) => p.defaultValue, 'defaultValue', 'Near Mint')
              .having((p) => p.possibleValues, 'possibleValues', [
            "Near Mint",
            "Excellent",
            "Good",
            "Poor",
          ]),
        );
      });

      test('parses boolean possible_values correctly', () {
        final jsonBoolean = {
          "name": "foil",
          "type": "boolean",
          "default_value": "false",
          "possible_values": [true, false],
        };

        final property = Property.fromJson(jsonBoolean);

        expect(property.type, 'boolean');
        expect(property.defaultValue, 'false');
        expect(property.possibleValues, [true, false]);
        expect(property.possibleValues[0], isA<bool>());
        expect(property.possibleValues[1], isA<bool>());
      });

      test('parses JSON without default_value', () {
        final jsonNoDefault = {
          "name": "language",
          "type": "string",
          "possible_values": ["en", "it", "de"],
        };

        final property = Property.fromJson(jsonNoDefault);

        expect(property.defaultValue, isNull);
      });
    });

    group('toJson', () {
      test('converts to JSON correctly with all fields', () {
        final property = Property.fromJson(json);
        final jsonOutput = property.toJson();

        expect(jsonOutput, {
          'name': 'condition',
          'type': 'string',
          'default_value': 'Near Mint',
          'possible_values': ["Near Mint", "Excellent", "Good", "Poor"],
        });
      });
    });

    group('constructor', () {
      test('creates instance with all fields', () {
        final property = Property(
          name: 'condition',
          type: 'string',
          defaultValue: 'Near Mint',
          possibleValues: ['Near Mint', 'Excellent'],
        );

        expect(property.name, 'condition');
        expect(property.type, 'string');
        expect(property.defaultValue, 'Near Mint');
        expect(property.possibleValues, ['Near Mint', 'Excellent']);
      });

      test('creates instance without defaultValue', () {
        final property = Property(
          name: 'condition',
          type: 'string',
          possibleValues: ['Near Mint'],
        );

        expect(property.defaultValue, isNull);
      });
    });
  });
}
