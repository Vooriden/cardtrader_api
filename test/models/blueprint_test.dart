import 'package:cardtrader_api/src/models/blueprint.dart';
import 'package:cardtrader_api/src/models/blueprint_image.dart';
import 'package:cardtrader_api/src/models/property.dart';
import 'package:test/test.dart';

void main() {
  group('Blueprint', () {
    final json = {
      "id": 293286,
      "name": "Flareon GX",
      "version": "001/038",
      "game_id": 5,
      "category_id": 73,
      "expansion_id": 3794,
      "fixed_properties": {
        "collector_number": "001",
        "pokemon_rarity": "Fixed",
      },
      "editable_properties": [
        {
          "name": "condition",
          "type": "string",
          "default_value": "Near Mint",
          "possible_values": ["Near Mint", "Slightly Played"],
        },
      ],
      "card_market_ids": [564841],
      "tcg_player_id": null,
      "scryfall_id": "",
      "image_url": "https://cardtrader.com/image.jpg",
      "image": {
        "url": "/uploads/blueprints/image/293286/flareon-gx.jpg",
        "show": {"url": "/uploads/blueprints/image/293286/show_flareon-gx.jpg"},
        "preview": {
          "url": "/uploads/blueprints/image/293286/preview_flareon-gx.jpg",
        },
        "social": {
          "url": "/uploads/blueprints/image/293286/social_flareon-gx.jpg",
        },
      },
      "back_image": null,
    };

    group('fromJson', () {
      test('parses JSON correctly with all fields', () {
        final blueprint = Blueprint.fromJson(json);

        expect(
          blueprint,
          isA<Blueprint>()
              .having((b) => b.id, 'id', 293286)
              .having((b) => b.name, 'name', 'Flareon GX')
              .having((b) => b.version, 'version', '001/038')
              .having((b) => b.gameId, 'gameId', 5)
              .having((b) => b.categoryId, 'categoryId', 73)
              .having((b) => b.expansionId, 'expansionId', 3794)
              .having(
                (b) => b.imageUrl,
                'imageUrl',
                'https://cardtrader.com/image.jpg',
              )
              .having(
                (b) => b.editableProperties.length,
                'editableProperties.length',
                1,
              )
              .having((b) => b.scryfallId, 'scryfallId', '')
              .having((b) => b.cardMarketIds, 'cardMarketIds', [564841]).having(
                  (b) => b.tcgPlayerId, 'tcgPlayerId', null),
        );
      });

      test('parses fixed_properties correctly', () {
        final blueprint = Blueprint.fromJson(json);

        expect(blueprint.fixedProperties['collector_number'], '001');
        expect(blueprint.fixedProperties['pokemon_rarity'], 'Fixed');
      });

      test('parses image object correctly', () {
        final blueprint = Blueprint.fromJson(json);

        expect(blueprint.image, isNotNull);
        expect(
          blueprint.image!.url,
          '/uploads/blueprints/image/293286/flareon-gx.jpg',
        );
        expect(blueprint.image!.show, isNotNull);
        expect(blueprint.image!.preview, isNotNull);
        expect(blueprint.image!.social, isNotNull);
      });

      test(
        'correctly parses nested editable properties with default_value',
        () {
          final blueprint = Blueprint.fromJson(json);

          expect(
            blueprint.editableProperties.first,
            isA<Property>()
                .having((p) => p.name, 'name', 'condition')
                .having((p) => p.type, 'type', 'string')
                .having((p) => p.defaultValue, 'defaultValue', 'Near Mint'),
          );
        },
      );
    });

    group('toJson', () {
      test('converts to JSON correctly with all fields', () {
        final blueprint = Blueprint.fromJson(json);
        final jsonOutput = blueprint.toJson();

        expect(jsonOutput['id'], 293286);
        expect(jsonOutput['name'], 'Flareon GX');
        expect(jsonOutput['version'], '001/038');
        expect(jsonOutput['game_id'], 5);
        expect(jsonOutput['category_id'], 73);
        expect(jsonOutput['expansion_id'], 3794);
        expect(jsonOutput['image_url'], 'https://cardtrader.com/image.jpg');
        expect(jsonOutput['image'], isMap);
        expect(jsonOutput['fixed_properties'], isMap);
        expect(jsonOutput['editable_properties'], isList);
        expect(jsonOutput['scryfall_id'], '');
        expect(jsonOutput['card_market_ids'], [564841]);
        expect(jsonOutput['tcg_player_id'], null);
      });
    });

    group('constructor', () {
      test('creates instance with all fields', () {
        final property = Property(
          name: 'condition',
          type: 'string',
          defaultValue: 'Near Mint',
          possibleValues: ['Near Mint'],
        );

        final image = BlueprintImage(
          url: '/image.jpg',
          show: BlueprintImageVariant(url: '/show.jpg'),
        );

        final blueprint = Blueprint(
          id: 293286,
          name: 'Flareon GX',
          version: '001/038',
          gameId: 5,
          categoryId: 73,
          expansionId: 3794,
          imageUrl: 'https://example.com/image.jpg',
          image: image,
          fixedProperties: {'collector_number': '001'},
          editableProperties: [property],
          scryfallId: 'abc123',
          cardMarketIds: [111, 222],
          tcgPlayerId: 333,
        );

        expect(blueprint.id, 293286);
        expect(blueprint.name, 'Flareon GX');
        expect(blueprint.version, '001/038');
        expect(blueprint.gameId, 5);
        expect(blueprint.categoryId, 73);
        expect(blueprint.expansionId, 3794);
        expect(blueprint.imageUrl, 'https://example.com/image.jpg');
        expect(blueprint.image, isNotNull);
        expect(blueprint.fixedProperties, isNotNull);
        expect(blueprint.editableProperties.length, 1);
        expect(blueprint.scryfallId, 'abc123');
        expect(blueprint.cardMarketIds, [111, 222]);
        expect(blueprint.tcgPlayerId, 333);
      });
    });
  });
}
