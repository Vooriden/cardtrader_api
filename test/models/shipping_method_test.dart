import 'package:cardtrader_api/src/models/shipping_method.dart';
import 'package:test/test.dart';

void main() {
  group('ShippingMethodCost', () {
    final json = {
      'from_grams': 14,
      'to_grams': 80,
      'price': {'cents': 330, 'currency': 'EUR'},
      'formatted_price': '€3.30',
    };

    test('fromJson parses correctly', () {
      final cost = ShippingMethodCost.fromJson(json);

      expect(cost.fromGrams, 14);
      expect(cost.toGrams, 80);
      expect(cost.price.cents, 330);
      expect(cost.price.currency, 'EUR');
      expect(cost.formattedPrice, '€3.30');
    });

    test('toJson roundtrip', () {
      final cost = ShippingMethodCost.fromJson(json);
      final serialized = cost.toJson();

      expect(serialized['from_grams'], 14);
      expect(serialized['to_grams'], 80);

      final cost2 = ShippingMethodCost.fromJson(serialized);
      expect(cost2.fromGrams, cost.fromGrams);
      expect(cost2.toGrams, cost.toGrams);
    });
  });

  group('ShippingMethod', () {
    group('marketplace context (full fields)', () {
      final marketplaceJson = {
        'id': 19044,
        'name': 'Posta 1 con Codice Bidimensionale',
        'min_estimate_shipping_days': 1,
        'max_estimate_shipping_days': 2,
        'parcel': false,
        'tracked': true,
        'tracking_link':
            'https://www.poste.it/cerca/index.html#/risultati-spedizioni/{code}',
        'free_shipping_threshold_quantity': 10,
        'free_shipping_threshold_price': {'cents': 5000, 'currency': 'EUR'},
        'formatted_free_shipping_threshold_price': '€50.00',
        'max_cart_subtotal_price': {'cents': 15000, 'currency': 'EUR'},
        'formatted_max_cart_subtotal_price': '€150.00',
        'shipping_method_costs': [
          {
            'from_grams': 14,
            'to_grams': 80,
            'price': {'cents': 330, 'currency': 'EUR'},
            'formatted_price': '€3.30',
          },
        ],
      };

      test('fromJson parses all marketplace fields', () {
        final method = ShippingMethod.fromJson(marketplaceJson);

        expect(method.id, 19044);
        expect(method.name, 'Posta 1 con Codice Bidimensionale');
        expect(method.minEstimateShippingDays, 1);
        expect(method.maxEstimateShippingDays, 2);
        expect(method.parcel, false);
        expect(method.tracked, true);
        expect(method.trackingLink, contains('{code}'));
        expect(method.freeShippingThresholdQuantity, 10);
        expect(method.freeShippingThresholdPrice, isNotNull);
        expect(method.freeShippingThresholdPrice!.cents, 5000);
        expect(method.formattedFreeShippingThresholdPrice, '€50.00');
        expect(method.maxCartSubtotalPrice, isNotNull);
        expect(method.maxCartSubtotalPrice!.cents, 15000);
        expect(method.formattedMaxCartSubtotalPrice, '€150.00');
        expect(method.shippingMethodCosts, isNotNull);
        expect(method.shippingMethodCosts!.length, 1);
        expect(method.shippingMethodCosts!.first.fromGrams, 14);
      });
    });

    group('order context (simplified fields)', () {
      final orderJson = {
        'id': 463937,
        'name': 'Priority Letter (Lettre Prioritaire)',
        'tracked': false,
        'tracking_code': null,
        'max_estimate_shipping_days': 14,
        'seller_price': {'cents': 150, 'currency': 'EUR'},
        'buyer_price': {'cents': 178, 'currency': 'EUR'},
        'formatted_price': '€1.50',
      };

      test('fromJson parses order shipping method correctly', () {
        final method = ShippingMethod.fromJson(orderJson);

        expect(method.id, 463937);
        expect(method.name, 'Priority Letter (Lettre Prioritaire)');
        expect(method.tracked, false);
        expect(method.trackingCode, isNull);
        expect(method.maxEstimateShippingDays, 14);
        expect(method.sellerPrice, isNotNull);
        expect(method.sellerPrice!.cents, 150);
        expect(method.buyerPrice, isNotNull);
        expect(method.buyerPrice!.cents, 178);
        expect(method.formattedPrice, '€1.50');
        // These should be null in order context
        expect(method.parcel, isNull);
        expect(method.shippingMethodCosts, isNull);
        expect(method.freeShippingThresholdQuantity, isNull);
      });
    });

    group('toJson', () {
      test('roundtrip serialization', () {
        final json = {
          'id': 463937,
          'name': 'Priority Letter',
          'tracked': true,
          'tracking_code': 'ABC123',
          'seller_price': {'cents': 150, 'currency': 'EUR'},
          'formatted_price': '€1.50',
        };

        final method = ShippingMethod.fromJson(json);
        final serialized = method.toJson();

        expect(serialized['id'], 463937);
        expect(serialized['name'], 'Priority Letter');
        expect(serialized['tracked'], true);
        expect(serialized['tracking_code'], 'ABC123');

        final method2 = ShippingMethod.fromJson(serialized);
        expect(method2.id, method.id);
        expect(method2.name, method.name);
        expect(method2.tracked, method.tracked);
      });
    });
  });
}
