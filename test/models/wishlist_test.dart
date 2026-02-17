import 'package:cardtrader_api/src/models/wishlist.dart';
import 'package:test/test.dart';

void main() {
  group('DeckItem', () {
    final json = {
      "quantity": 2,
      "blueprint_id": 12345,
      "meta_name": "Lightning Bolt",
      "expansion_code": "LEA",
      "collector_number": "161",
      "language": "en",
      "condition": "Near Mint",
      "foil": null,
      "reverse": null,
      "first_edition": false,
    };

    group('fromJson', () {
      test('parses JSON correctly with all fields', () {
        final item = DeckItem.fromJson(json);

        expect(item.quantity, 2);
        expect(item.blueprintId, 12345);
        expect(item.metaName, 'Lightning Bolt');
        expect(item.expansionCode, 'LEA');
        expect(item.collectorNumber, '161');
        expect(item.language, 'en');
        expect(item.condition, 'Near Mint');
        expect(item.foil, isNull);
        expect(item.reverse, isNull);
        expect(item.firstEdition, false);
      });

      test('parses JSON with minimal fields', () {
        final jsonMinimal = <String, dynamic>{
          "quantity": 1,
          "meta_name": "Unknown Card",
        };

        final item = DeckItem.fromJson(jsonMinimal);

        expect(item.quantity, 1);
        expect(item.metaName, 'Unknown Card');
        expect(item.blueprintId, isNull);
        expect(item.expansionCode, isNull);
        expect(item.language, isNull);
        expect(item.firstEdition, isNull);
      });
    });

    group('toJson', () {
      test('converts to JSON correctly', () {
        final item = DeckItem.fromJson(json);
        final jsonOutput = item.toJson();

        expect(jsonOutput['quantity'], 2);
        expect(jsonOutput['blueprint_id'], 12345);
        expect(jsonOutput['meta_name'], 'Lightning Bolt');
        expect(jsonOutput['expansion_code'], 'LEA');
        expect(jsonOutput['collector_number'], '161');
        expect(jsonOutput['language'], 'en');
        expect(jsonOutput['condition'], 'Near Mint');
        expect(jsonOutput['first_edition'], false);
      });
    });

    group('constructor', () {
      test('creates instance with all fields', () {
        final item = DeckItem(
          quantity: 4,
          blueprintId: 999,
          metaName: 'Island',
          expansionCode: 'LEA',
          collectorNumber: '287',
          language: 'en',
          condition: 'Played',
          foil: 'foil',
          reverse: null,
          firstEdition: false,
        );

        expect(item.quantity, 4);
        expect(item.blueprintId, 999);
        expect(item.metaName, 'Island');
        expect(item.foil, 'foil');
      });
    });
  });

  group('Wishlist', () {
    final json = {
      "id": 1,
      "name": "My MTG Wishlist",
      "game_id": 1,
      "public": true,
      "created_at": "2024-01-15T10:30:00.000Z",
      "updated_at": "2024-06-20T14:00:00.000Z",
      "items": [
        {
          "quantity": 2,
          "blueprint_id": 12345,
          "meta_name": "Lightning Bolt",
          "expansion_code": "LEA",
          "collector_number": "161",
          "language": "en",
          "condition": "Near Mint",
          "foil": null,
          "reverse": null,
          "first_edition": false,
        },
      ],
    };

    group('fromJson', () {
      test('parses JSON correctly with items', () {
        final wishlist = Wishlist.fromJson(json);

        expect(wishlist.id, 1);
        expect(wishlist.name, 'My MTG Wishlist');
        expect(wishlist.gameId, 1);
        expect(wishlist.isPublic, true);
        expect(wishlist.createdAt, isNotNull);
        expect(wishlist.updatedAt, isNotNull);
        expect(wishlist.items, isNotNull);
        expect(wishlist.items!.length, 1);
        expect(wishlist.items!.first.metaName, 'Lightning Bolt');
      });

      test('parses JSON without items', () {
        final jsonNoItems = {
          "id": 2,
          "name": "Yu-Gi-Oh Cards",
          "game_id": 3,
          "public": false,
          "created_at": "2024-03-01T08:00:00.000Z",
          "updated_at": "2024-05-10T16:45:00.000Z",
        };

        final wishlist = Wishlist.fromJson(jsonNoItems);

        expect(wishlist.id, 2);
        expect(wishlist.name, 'Yu-Gi-Oh Cards');
        expect(wishlist.gameId, 3);
        expect(wishlist.isPublic, false);
        expect(wishlist.items, isNull);
      });
    });

    group('toJson', () {
      test('converts to JSON correctly', () {
        final wishlist = Wishlist.fromJson(json);
        final jsonOutput = wishlist.toJson();

        expect(jsonOutput['id'], 1);
        expect(jsonOutput['name'], 'My MTG Wishlist');
        expect(jsonOutput['game_id'], 1);
        expect(jsonOutput['public'], true);
        expect(jsonOutput['items'], isA<List>());
        expect((jsonOutput['items'] as List).length, 1);
      });
    });

    group('constructor', () {
      test('creates instance with required fields', () {
        final wishlist = Wishlist(
          id: 1,
          name: 'Test Wishlist',
          gameId: 1,
          isPublic: false,
          createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
        );

        expect(wishlist.id, 1);
        expect(wishlist.name, 'Test Wishlist');
        expect(wishlist.gameId, 1);
        expect(wishlist.isPublic, false);
        expect(wishlist.items, isNull);
      });

      test('creates instance with items', () {
        final wishlist = Wishlist(
          id: 1,
          name: 'Test',
          gameId: 1,
          isPublic: true,
          createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          updatedAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          items: [
            DeckItem(quantity: 1, metaName: 'Test Card', blueprintId: 100),
          ],
        );

        expect(wishlist.items, isNotNull);
        expect(wishlist.items!.length, 1);
        expect(wishlist.items!.first.blueprintId, 100);
      });
    });
  });
}
