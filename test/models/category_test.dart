import 'package:cardtrader_api/src/models/category.dart';
import 'package:cardtrader_api/src/models/property.dart';
import 'package:test/test.dart';

void main() {
  group('Category', () {
    final json = {
      "id": 1,
      "name": "Single Cards",
      "game_id": 1,
      "properties": [
        {
          "name": "condition",
          "type": "string",
          "possible_values": ["Near Mint", "Excellent", "Good", "Poor"],
        },
      ],
    };

    group('fromJson', () {
      test('parses JSON correctly with all fields', () {
        final category = Category.fromJson(json);

        expect(
          category,
          isA<Category>()
              .having((c) => c.id, 'id', 1)
              .having((c) => c.name, 'name', 'Single Cards')
              .having((c) => c.gameId, 'gameId', 1)
              .having((c) => c.properties.length, 'properties.length', 1),
        );
      });

      test('parses JSON with empty properties', () {
        final jsonEmpty = {
          "id": 2,
          "name": "Sealed Products",
          "game_id": 1,
          "properties": [],
        };

        final category = Category.fromJson(jsonEmpty);

        expect(category.properties, isEmpty);
      });

      test('correctly parses nested properties', () {
        final category = Category.fromJson(json);

        expect(
          category.properties.first,
          isA<Property>()
              .having((p) => p.name, 'name', 'condition')
              .having((p) => p.type, 'type', 'string'),
        );
      });
    });

    group('toJson', () {
      test('converts to JSON correctly with all fields', () {
        final category = Category.fromJson(json);
        final jsonOutput = category.toJson();

        expect(jsonOutput['id'], 1);
        expect(jsonOutput['name'], 'Single Cards');
        expect(jsonOutput['game_id'], 1);
        expect(jsonOutput['properties'], isList);
        expect((jsonOutput['properties'] as List).length, 1);
      });
    });

    group('constructor', () {
      test('creates instance with all fields', () {
        final property = Property(
          name: 'condition',
          type: 'string',
          possibleValues: ['Near Mint'],
        );

        final category = Category(
          id: 1,
          name: 'Single Cards',
          gameId: 1,
          properties: [property],
        );

        expect(category.id, 1);
        expect(category.name, 'Single Cards');
        expect(category.gameId, 1);
        expect(category.properties.length, 1);
        expect(category.properties.first.name, 'condition');
      });
    });
  });
}
