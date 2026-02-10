import 'package:cardtrader_api/src/models/property.dart';
import 'package:test/test.dart';

void main() {
  group('Property', () {
    final json = {
      "name": "condition",
      "type": "string",
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
          "possible_values": [true, false],
        };

        final property = Property.fromJson(jsonBoolean);

        expect(property.type, 'boolean');
        expect(property.possibleValues, [true, false]);
        expect(property.possibleValues[0], isA<bool>());
        expect(property.possibleValues[1], isA<bool>());
      });
    });

    group('toJson', () {
      test('converts to JSON correctly with all fields', () {
        final property = Property.fromJson(json);
        final jsonOutput = property.toJson();

        expect(jsonOutput, {
          'name': 'condition',
          'type': 'string',
          'possible_values': ["Near Mint", "Excellent", "Good", "Poor"],
        });
      });
    });

    group('constructor', () {
      test('creates instance with all fields', () {
        final property = Property(
          name: 'condition',
          type: 'string',
          possibleValues: ['Near Mint', 'Excellent'],
        );

        expect(property.name, 'condition');
        expect(property.type, 'string');
        expect(property.possibleValues, ['Near Mint', 'Excellent']);
      });
    });
  });
}
