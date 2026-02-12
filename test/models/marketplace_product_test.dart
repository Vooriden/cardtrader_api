import 'package:cardtrader_api/src/models/expansion.dart';
import 'package:cardtrader_api/src/models/marketplace_product.dart';
import 'package:cardtrader_api/src/models/money.dart';
import 'package:cardtrader_api/src/models/user.dart';
import 'package:test/test.dart';

void main() {
  group('MarketplaceProduct', () {
    final json = {
      "id": 302179007,
      "blueprint_id": 3138,
      "name_en": "Earl of Squirrel",
      "expansion": {"code": "pust", "id": 34, "name_en": "Unstable Promos"},
      "price_cents": 20,
      "price_currency": "EUR",
      "quantity": 1,
      "description": "",
      "properties_hash": {
        "condition": "Near Mint",
        "mtg_card_colors": "G",
        "tournament_legal": true,
        "collector_number": "108",
        "cmc": "6.0",
        "signed": false,
        "mtg_foil": true,
        "mtg_language": "it",
        "altered": false,
        "mtg_rarity": "Rare",
      },
      "graded": false,
      "on_vacation": false,
      "user": {
        "country_code": "IT",
        "too_many_request_for_cancel_as_seller": false,
        "user_type": "normal",
        "can_sell_sealed_with_ct_zero": false,
        "max_sellable_in24h_quantity": null,
        "id": 7343,
        "username": "Astaroth",
        "can_sell_via_hub": false,
      },
      "price": {
        "cents": 20,
        "currency": "EUR",
        "currency_symbol": "€",
        "formatted": "€0.20",
      },
    };

    group('fromJson', () {
      test('parses JSON correctly with all fields', () {
        final product = MarketplaceProduct.fromJson(json);

        expect(
          product,
          isA<MarketplaceProduct>()
              .having((p) => p.id, 'id', 302179007)
              .having((p) => p.blueprintId, 'blueprintId', 3138)
              .having((p) => p.nameEn, 'nameEn', 'Earl of Squirrel')
              .having((p) => p.quantity, 'quantity', 1)
              .having((p) => p.priceCents, 'priceCents', 20)
              .having((p) => p.priceCurrency, 'priceCurrency', 'EUR')
              .having((p) => p.description, 'description', '')
              .having((p) => p.graded, 'graded', false)
              .having((p) => p.onVacation, 'onVacation', false),
        );
      });

      test('parses nested price correctly', () {
        final product = MarketplaceProduct.fromJson(json);

        expect(
          product.price,
          isA<Money>()
              .having((m) => m.cents, 'cents', 20)
              .having((m) => m.currency, 'currency', 'EUR')
              .having((m) => m.currencySymbol, 'currencySymbol', '€')
              .having((m) => m.formatted, 'formatted', '€0.20'),
        );
      });

      test('parses nested expansion correctly (marketplace format)', () {
        final product = MarketplaceProduct.fromJson(json);

        expect(
          product.expansion,
          isA<Expansion>()
              .having((e) => e.id, 'id', 34)
              .having((e) => e.code, 'code', 'pust')
              .having((e) => e.nameEn, 'nameEn', 'Unstable Promos')
              .having((e) => e.gameId, 'gameId', isNull)
              .having((e) => e.name, 'name', isNull),
        );
      });

      test('parses nested user correctly', () {
        final product = MarketplaceProduct.fromJson(json);

        expect(
          product.user,
          isA<User>()
              .having((u) => u.id, 'id', 7343)
              .having((u) => u.username, 'username', 'Astaroth')
              .having((u) => u.countryCode, 'countryCode', 'IT')
              .having((u) => u.userType, 'userType', 'normal')
              .having((u) => u.canSellViaHub, 'canSellViaHub', false)
              .having(
                (u) => u.tooManyRequestForCancelAsSeller,
                'tooManyRequestForCancelAsSeller',
                false,
              )
              .having(
                (u) => u.canSellSealedWithCtZero,
                'canSellSealedWithCtZero',
                false,
              ),
        );
      });

      test('parses properties_hash correctly', () {
        final product = MarketplaceProduct.fromJson(json);

        expect(product.propertiesHash, isA<Map<String, dynamic>>());
        expect(product.propertiesHash['condition'], 'Near Mint');
        expect(product.propertiesHash['mtg_foil'], true);
        expect(product.propertiesHash['mtg_language'], 'it');
        expect(product.propertiesHash['mtg_rarity'], 'Rare');
      });

      test('parses JSON with graded product', () {
        final jsonGraded = Map<String, dynamic>.from(json);
        jsonGraded['graded'] = true;

        final product = MarketplaceProduct.fromJson(jsonGraded);

        expect(product.graded, true);
      });

      test('parses JSON with seller on vacation', () {
        final jsonVacation = Map<String, dynamic>.from(json);
        jsonVacation['on_vacation'] = true;

        final product = MarketplaceProduct.fromJson(jsonVacation);

        expect(product.onVacation, true);
      });
    });

    group('toJson', () {
      test('converts to JSON correctly', () {
        final product = MarketplaceProduct.fromJson(json);
        final jsonOutput = product.toJson();

        expect(jsonOutput['id'], 302179007);
        expect(jsonOutput['blueprint_id'], 3138);
        expect(jsonOutput['name_en'], 'Earl of Squirrel');
        expect(jsonOutput['quantity'], 1);
        expect(jsonOutput['price_cents'], 20);
        expect(jsonOutput['price_currency'], 'EUR');
        expect(jsonOutput['description'], '');
        expect(jsonOutput['graded'], false);
        expect(jsonOutput['on_vacation'], false);
      });

      test('converts nested objects correctly', () {
        final product = MarketplaceProduct.fromJson(json);
        final jsonOutput = product.toJson();

        expect(jsonOutput['price'], isA<Map<String, dynamic>>());
        expect((jsonOutput['price'] as Map)['cents'], 20);
        expect((jsonOutput['price'] as Map)['currency'], 'EUR');
        expect((jsonOutput['price'] as Map)['formatted'], '€0.20');

        expect(jsonOutput['expansion'], isA<Map<String, dynamic>>());
        expect((jsonOutput['expansion'] as Map)['id'], 34);
        expect((jsonOutput['expansion'] as Map)['code'], 'pust');

        expect(jsonOutput['user'], isA<Map<String, dynamic>>());
        expect((jsonOutput['user'] as Map)['id'], 7343);
        expect((jsonOutput['user'] as Map)['username'], 'Astaroth');
      });
    });

    group('constructor', () {
      test('creates instance with all fields', () {
        final product = MarketplaceProduct(
          id: 1,
          blueprintId: 100,
          nameEn: 'Test Card',
          quantity: 2,
          priceCents: 500,
          priceCurrency: 'USD',
          price: Money(cents: 500, currency: 'USD'),
          description: 'Test description',
          propertiesHash: {'condition': 'Good'},
          expansion: Expansion(id: 1, code: 'tst', nameEn: 'Test Set'),
          user: User(id: 1, username: 'testuser'),
          graded: false,
          onVacation: false,
        );

        expect(product.id, 1);
        expect(product.blueprintId, 100);
        expect(product.nameEn, 'Test Card');
        expect(product.quantity, 2);
        expect(product.priceCents, 500);
        expect(product.priceCurrency, 'USD');
        expect(product.price.cents, 500);
        expect(product.description, 'Test description');
        expect(product.propertiesHash['condition'], 'Good');
        expect(product.expansion.code, 'tst');
        expect(product.user.username, 'testuser');
        expect(product.graded, false);
        expect(product.onVacation, false);
      });
    });
  });
}
