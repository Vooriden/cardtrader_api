import 'package:cardtrader_api/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('CartProduct', () {
    final json = {"id": 302179007, "name_en": "Earl of Squirrel"};

    test('fromJson parses correctly', () {
      final product = CartProduct.fromJson(json);

      expect(product.id, 302179007);
      expect(product.nameEn, 'Earl of Squirrel');
    });

    test('toJson converts correctly', () {
      final product = CartProduct.fromJson(json);
      final jsonOutput = product.toJson();

      expect(jsonOutput['id'], 302179007);
      expect(jsonOutput['name_en'], 'Earl of Squirrel');
    });
  });

  group('CartItem', () {
    final json = {
      "quantity": 2,
      "price_cents": 500,
      "price_currency": "EUR",
      "product": {"id": 302179007, "name_en": "Earl of Squirrel"},
    };

    test('fromJson parses correctly', () {
      final item = CartItem.fromJson(json);

      expect(item.quantity, 2);
      expect(item.priceCents, 500);
      expect(item.priceCurrency, 'EUR');
      expect(item.product.id, 302179007);
      expect(item.product.nameEn, 'Earl of Squirrel');
    });

    test('toJson converts correctly', () {
      final item = CartItem.fromJson(json);
      final jsonOutput = item.toJson();

      expect(jsonOutput['quantity'], 2);
      expect(jsonOutput['price_cents'], 500);
      expect(jsonOutput['price_currency'], 'EUR');
      expect(jsonOutput['product'], isA<Map<String, dynamic>>());
    });
  });

  group('Subcart', () {
    final json = {
      "id": 123,
      "seller": {"id": 123, "username": "supervendor"},
      "via_cardtrader_zero": false,
      "cart_items": [
        {
          "quantity": 1,
          "price_cents": 800,
          "price_currency": "EUR",
          "product": {"id": 384880761, "name_en": "Hallowed Fountain"},
        },
      ],
    };

    test('fromJson parses correctly', () {
      final subcart = Subcart.fromJson(json);

      expect(subcart.id, 123);
      expect(subcart.seller, isNotNull);
      expect(subcart.seller!.username, 'supervendor');
      expect(subcart.viaCardtraderZero, false);
      expect(subcart.cartItems.length, 1);
      expect(subcart.cartItems.first.quantity, 1);
      expect(subcart.cartItems.first.priceCents, 800);
    });

    test('fromJson with via_cardtrader_zero true', () {
      final jsonCTZero = {
        "id": 456,
        "seller": {"id": 34089, "username": "Ct connect"},
        "via_cardtrader_zero": true,
        "cart_items": [],
      };

      final subcart = Subcart.fromJson(jsonCTZero);

      expect(subcart.id, 456);
      expect(subcart.viaCardtraderZero, true);
    });

    test('fromJson handles minimal data', () {
      final jsonMinimal = {"id": 2, "cart_items": []};

      final subcart = Subcart.fromJson(jsonMinimal);

      expect(subcart.id, 2);
      expect(subcart.seller, isNull);
      expect(subcart.viaCardtraderZero, isNull);
      expect(subcart.cartItems, isEmpty);
    });
  });

  group('Cart', () {
    final json = {
      "id": 12345678,
      "total": {"cents": 3452, "currency": "EUR"},
      "subtotal": {"cents": 3452, "currency": "EUR"},
      "safeguard_fee_amount": {"cents": 0, "currency": "USD"},
      "ct_zero_fee_amount": {"cents": 0, "currency": "USD"},
      "payment_method_fee_fixed_amount": {"cents": 35, "currency": "EUR"},
      "payment_method_fee_percentage_amount": {"cents": 173, "currency": "EUR"},
      "shipping_cost": {"cents": 0, "currency": "EUR"},
      "subcarts": [
        {
          "id": 123,
          "seller": {"id": 123, "username": "supervendor"},
          "via_cardtrader_zero": false,
          "cart_items": [
            {
              "quantity": 1,
              "price_cents": 800,
              "price_currency": "EUR",
              "product": {"id": 384880761, "name_en": "Hallowed Fountain"},
            },
          ],
        },
      ],
      "billing_address": null,
      "shipping_address": {
        "id": 39645,
        "user_id": 12345678,
        "name": "Some User",
        "street": "Via Roma 1",
        "zip": "00000",
        "city": "Roma",
        "state_or_province": "RM",
        "country_code": "IT",
        "phone": "+391234567890",
        "keep_original": true,
        "default_billing_address": false,
        "default_shipping_address": true,
        "latitude": null,
        "longitude": null,
        "note": null,
        "created_at": "2021-03-20T23:18:52.000Z",
        "updated_at": "2024-07-30T19:00:08.000Z",
      },
    };

    test('fromJson parses correctly', () {
      final cart = Cart.fromJson(json);

      expect(cart.id, 12345678);
      expect(cart.total.cents, 3452);
      expect(cart.subtotal.cents, 3452);
      expect(cart.subcarts.length, 1);
      expect(cart.subcarts.first.id, 123);
      expect(cart.subcarts.first.viaCardtraderZero, false);
      expect(cart.safeguardFeeAmount.cents, 0);
      expect(cart.ctZeroFeeAmount.cents, 0);
      expect(cart.paymentMethodFeePercentageAmount.cents, 173);
      expect(cart.paymentMethodFeeFixedAmount.cents, 35);
      expect(cart.shippingCost.cents, 0);
      expect(cart.billingAddress, isNull);
      expect(cart.shippingAddress, isNotNull);
      expect(cart.shippingAddress!.name, 'Some User');
      expect(cart.shippingAddress!.phone, '+391234567890');
    });

    test('toJson converts correctly', () {
      final cart = Cart.fromJson(json);
      final jsonOutput = cart.toJson();

      expect(jsonOutput['id'], 12345678);
      expect(jsonOutput['total'], isA<Map<String, dynamic>>());
      expect((jsonOutput['total'] as Map)['cents'], 3452);
      expect(jsonOutput['subcarts'], isA<List>());
      expect((jsonOutput['subcarts'] as List).length, 1);
      expect(jsonOutput['subtotal'], isA<Map<String, dynamic>>());
      expect((jsonOutput['subtotal'] as Map)['cents'], 3452);
    });

    group('constructor', () {
      test('creates instance with all required fields', () {
        final cart = Cart(
          id: 1,
          total: Money(cents: 0, currency: 'EUR'),
          subcarts: [],
          subtotal: Money(cents: 0, currency: 'EUR'),
          safeguardFeeAmount: Money(cents: 0, currency: 'EUR'),
          ctZeroFeeAmount: Money(cents: 0, currency: 'EUR'),
          paymentMethodFeePercentageAmount: Money(cents: 0, currency: 'EUR'),
          paymentMethodFeeFixedAmount: Money(cents: 0, currency: 'EUR'),
          shippingCost: Money(cents: 0, currency: 'EUR'),
        );

        expect(cart.id, 1);
        expect(cart.total.cents, 0);
        expect(cart.subcarts, isEmpty);
        expect(cart.subtotal.cents, 0);
      });

      test('creates instance with addresses', () {
        final address = Address(
          name: 'Test',
          street: 'Test St',
          zip: '00000',
          city: 'Test',
          stateOrProvince: 'TS',
          countryCode: 'TS',
        );

        final cart = Cart(
          id: 1,
          total: Money(cents: 0, currency: 'EUR'),
          subcarts: [],
          subtotal: Money(cents: 0, currency: 'EUR'),
          safeguardFeeAmount: Money(cents: 0, currency: 'EUR'),
          ctZeroFeeAmount: Money(cents: 0, currency: 'EUR'),
          paymentMethodFeePercentageAmount: Money(cents: 0, currency: 'EUR'),
          paymentMethodFeeFixedAmount: Money(cents: 0, currency: 'EUR'),
          shippingCost: Money(cents: 0, currency: 'EUR'),
          billingAddress: address,
          shippingAddress: address,
        );

        expect(cart.billingAddress, isNotNull);
        expect(cart.shippingAddress, isNotNull);
      });
    });
  });
}
