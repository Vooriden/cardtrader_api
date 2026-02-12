import 'package:cardtrader_api/src/models/money.dart';
import 'package:test/test.dart';

void main() {
  group('Money', () {
    final json = {
      "cents": 20,
      "currency": "EUR",
      "currency_symbol": "€",
      "formatted": "€0.20",
    };

    group('fromJson', () {
      test('parses JSON correctly with all fields', () {
        final money = Money.fromJson(json);

        expect(
          money,
          isA<Money>()
              .having((m) => m.cents, 'cents', 20)
              .having((m) => m.currency, 'currency', 'EUR')
              .having((m) => m.currencySymbol, 'currencySymbol', '€')
              .having((m) => m.formatted, 'formatted', '€0.20'),
        );
      });

      test('parses JSON with only required fields', () {
        final jsonMinimal = {"cents": 1500, "currency": "USD"};

        final money = Money.fromJson(jsonMinimal);

        expect(money.cents, 1500);
        expect(money.currency, 'USD');
        expect(money.currencySymbol, isNull);
        expect(money.formatted, isNull);
      });

      test('parses JSON with zero cents', () {
        final jsonZero = {"cents": 0, "currency": "USD"};

        final money = Money.fromJson(jsonZero);

        expect(money.cents, 0);
        expect(money.currency, 'USD');
      });

      test('parses JSON with negative cents', () {
        final jsonNegative = {"cents": -500, "currency": "EUR"};

        final money = Money.fromJson(jsonNegative);

        expect(money.cents, -500);
      });
    });

    group('toJson', () {
      test('converts to JSON correctly', () {
        final money = Money.fromJson(json);
        final jsonOutput = money.toJson();

        expect(jsonOutput['cents'], 20);
        expect(jsonOutput['currency'], 'EUR');
        expect(jsonOutput['currency_symbol'], '€');
        expect(jsonOutput['formatted'], '€0.20');
      });
    });

    group('amount', () {
      test('calculates amount correctly', () {
        final money = Money(cents: 1500, currency: 'EUR');

        expect(money.amount, 15.0);
      });

      test('calculates amount correctly for zero', () {
        final money = Money(cents: 0, currency: 'USD');

        expect(money.amount, 0.0);
      });

      test('calculates amount correctly for single digit cents', () {
        final money = Money(cents: 99, currency: 'EUR');

        expect(money.amount, 0.99);
      });
    });

    group('toString', () {
      test('uses formatted when available', () {
        final money = Money(
          cents: 20,
          currency: 'EUR',
          currencySymbol: '€',
          formatted: '€0.20',
        );

        expect(money.toString(), '€0.20');
      });

      test('falls back to default format when formatted is null', () {
        final money = Money(cents: 1500, currency: 'EUR');

        expect(money.toString(), '15.00 EUR');
      });

      test('formats correctly for small amounts without formatted', () {
        final money = Money(cents: 5, currency: 'USD');

        expect(money.toString(), '0.05 USD');
      });

      test('formats correctly for large amounts without formatted', () {
        final money = Money(cents: 123456, currency: 'EUR');

        expect(money.toString(), '1234.56 EUR');
      });
    });

    group('constructor', () {
      test('creates instance with required fields', () {
        final money = Money(cents: 1000, currency: 'GBP');

        expect(money.cents, 1000);
        expect(money.currency, 'GBP');
        expect(money.currencySymbol, isNull);
        expect(money.formatted, isNull);
      });

      test('creates instance with all fields', () {
        final money = Money(
          cents: 100,
          currency: 'USD',
          currencySymbol: '\$',
          formatted: '\$1.00',
        );

        expect(money.cents, 100);
        expect(money.currency, 'USD');
        expect(money.currencySymbol, '\$');
        expect(money.formatted, '\$1.00');
      });
    });
  });
}
