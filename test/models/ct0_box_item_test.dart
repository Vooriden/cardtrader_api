import 'package:cardtrader_api/src/models/ct0_box_item.dart';
import 'package:test/test.dart';

void main() {
  group('Ct0BoxItem', () {
    final json = {
      'id': 1917020,
      'quantity': {'pending': 1},
      'seller': {
        'id': 7343,
        'username': 'CardShop',
        'country_code': 'IT',
        'can_sell_via_hub': true,
      },
      'product_id': 99947732,
      'blueprint_id': 7842,
      'category_id': 1,
      'game_id': 1,
      'name': 'Deathcap Cultivator',
      'expansion': 'Shadows over Innistrad',
      'bundle_size': 1,
      'description': 'Express delivery',
      'graded': false,
      'properties': {
        'condition': 'Slightly Played',
        'mtg_language': 'en',
        'mtg_foil': false,
      },
      'buyer_price': {'cents': 8, 'currency': 'EUR'},
      'formatted_price': '€0.08',
      'mkm_id': 288973,
      'tcg_player_id': 115889,
      'scryfall_id': 'fc4aee46-ac42-4ede-ad06-906e2955a9d3',
      'presale': null,
      'presale_ended_at': null,
      'paid_at': '2021-10-02T16:14:54.000Z',
      'estimated_arrived_at': '2021-10-14T16:14:54.000Z',
      'arrived_at': null,
      'cancelled_at': null,
      'return_to_seller': false,
    };

    group('fromJson', () {
      test('parses all fields correctly', () {
        final item = Ct0BoxItem.fromJson(json);

        expect(item.id, 1917020);
        expect(item.quantity, {'pending': 1});
        expect(item.seller.id, 7343);
        expect(item.seller.username, 'CardShop');
        expect(item.productId, 99947732);
        expect(item.blueprintId, 7842);
        expect(item.categoryId, 1);
        expect(item.gameId, 1);
        expect(item.name, 'Deathcap Cultivator');
        expect(item.expansion, 'Shadows over Innistrad');
        expect(item.bundleSize, 1);
        expect(item.description, 'Express delivery');
        expect(item.graded, false);
        expect(item.properties['condition'], 'Slightly Played');
        expect(item.buyerPrice.cents, 8);
        expect(item.buyerPrice.currency, 'EUR');
        expect(item.formattedPrice, '€0.08');
        expect(item.mkmId, 288973);
        expect(item.tcgPlayerId, 115889);
        expect(item.scryfallId, 'fc4aee46-ac42-4ede-ad06-906e2955a9d3');
        expect(item.presale, isNull);
        expect(item.presaleEndedAt, isNull);
        expect(item.paidAt, DateTime.parse('2021-10-02T16:14:54.000Z'));
        expect(
          item.estimatedArrivedAt,
          DateTime.parse('2021-10-14T16:14:54.000Z'),
        );
        expect(item.arrivedAt, isNull);
        expect(item.cancelledAt, isNull);
        expect(item.returnToSeller, false);
      });

      test('handles null bundle_size and description', () {
        final minimalJson = Map<String, dynamic>.from(json);
        minimalJson.remove('bundle_size');
        minimalJson['description'] = null;

        final item = Ct0BoxItem.fromJson(minimalJson);

        expect(item.bundleSize, isNull);
        expect(item.description, isNull);
      });

      test('handles item with ok quantity', () {
        final okJson = {
          ...json,
          'quantity': {'ok': 2},
          'arrived_at': '2021-10-05T12:00:00.000Z',
          'estimated_arrived_at': null,
        };

        final item = Ct0BoxItem.fromJson(okJson);

        expect(item.okQuantity, 2);
        expect(item.pendingQuantity, 0);
        expect(item.missingQuantity, 0);
        expect(item.arrivedAt, isNotNull);
      });

      test('handles item with missing quantity', () {
        final missingJson = {
          ...json,
          'quantity': {'missing': 1},
          'cancelled_at': '2021-10-10T00:00:00.000Z',
        };

        final item = Ct0BoxItem.fromJson(missingJson);

        expect(item.missingQuantity, 1);
        expect(item.okQuantity, 0);
        expect(item.pendingQuantity, 0);
        expect(item.cancelledAt, isNotNull);
      });
    });

    group('quantity helpers', () {
      test('pendingQuantity returns correct value', () {
        final item = Ct0BoxItem.fromJson(json);
        expect(item.pendingQuantity, 1);
      });

      test('okQuantity returns 0 when not present', () {
        final item = Ct0BoxItem.fromJson(json);
        expect(item.okQuantity, 0);
      });

      test('missingQuantity returns 0 when not present', () {
        final item = Ct0BoxItem.fromJson(json);
        expect(item.missingQuantity, 0);
      });
    });

    group('toJson', () {
      test('roundtrip serialization', () {
        final item = Ct0BoxItem.fromJson(json);
        final serialized = item.toJson();

        expect(serialized['id'], 1917020);
        expect(serialized['name'], 'Deathcap Cultivator');
        expect(serialized['product_id'], 99947732);

        final item2 = Ct0BoxItem.fromJson(serialized);
        expect(item2.id, item.id);
        expect(item2.name, item.name);
        expect(item2.productId, item.productId);
        expect(item2.pendingQuantity, item.pendingQuantity);
      });
    });
  });
}
