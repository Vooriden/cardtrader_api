import 'package:cardtrader_api/src/models/product_request.dart';
import 'package:test/test.dart';

void main() {
  group('ProductRequest', () {
    group('constructor', () {
      test('creates instance with required fields only', () {
        final request = ProductRequest(
          blueprintId: 39063,
          price: 5.00,
          quantity: 4,
        );

        expect(request.blueprintId, 39063);
        expect(request.price, 5.00);
        expect(request.quantity, 4);
        expect(request.description, isNull);
        expect(request.userDataField, isNull);
        expect(request.properties, isNull);
        expect(request.graded, isNull);
      });

      test('creates instance with all fields', () {
        final request = ProductRequest(
          blueprintId: 39063,
          price: 5.00,
          quantity: 4,
          description: 'Near Mint condition',
          userDataField: 'SKU-001',
          properties: {'condition': 'Near Mint', 'mtg_language': 'en'},
          graded: true,
        );

        expect(request.blueprintId, 39063);
        expect(request.price, 5.00);
        expect(request.quantity, 4);
        expect(request.description, 'Near Mint condition');
        expect(request.userDataField, 'SKU-001');
        expect(request.properties, {
          'condition': 'Near Mint',
          'mtg_language': 'en',
        });
        expect(request.graded, true);
      });
    });

    group('toJson', () {
      test('serializes required fields only', () {
        final request = ProductRequest(
          blueprintId: 39063,
          price: 5.00,
          quantity: 4,
        );

        final json = request.toJson();

        expect(json, {'blueprint_id': 39063, 'price': 5.00, 'quantity': 4});
        expect(json.containsKey('description'), isFalse);
        expect(json.containsKey('user_data_field'), isFalse);
        expect(json.containsKey('properties'), isFalse);
        expect(json.containsKey('graded'), isFalse);
      });

      test('serializes all fields when provided', () {
        final request = ProductRequest(
          blueprintId: 39063,
          price: 5.00,
          quantity: 4,
          description: 'Near Mint condition',
          userDataField: 'SKU-001',
          properties: {'condition': 'Near Mint', 'mtg_language': 'en'},
          graded: true,
        );

        final json = request.toJson();

        expect(json, {
          'blueprint_id': 39063,
          'price': 5.00,
          'quantity': 4,
          'description': 'Near Mint condition',
          'user_data_field': 'SKU-001',
          'properties': {'condition': 'Near Mint', 'mtg_language': 'en'},
          'graded': true,
        });
      });

      test('handles decimal prices correctly', () {
        final request = ProductRequest(
          blueprintId: 39063,
          price: 2.50,
          quantity: 1,
        );

        final json = request.toJson();

        expect(json['price'], 2.50);
      });
    });

    group('fromJson', () {
      test('deserializes with required fields only', () {
        final json = {'blueprint_id': 39063, 'price': 5.00, 'quantity': 4};

        final request = ProductRequest.fromJson(json);

        expect(request.blueprintId, 39063);
        expect(request.price, 5.00);
        expect(request.quantity, 4);
        expect(request.description, isNull);
        expect(request.userDataField, isNull);
        expect(request.properties, isNull);
        expect(request.graded, isNull);
      });

      test('deserializes all fields', () {
        final json = {
          'blueprint_id': 39063,
          'price': 5.00,
          'quantity': 4,
          'description': 'Near Mint condition',
          'user_data_field': 'SKU-001',
          'properties': {'condition': 'Near Mint', 'mtg_language': 'en'},
          'graded': true,
        };

        final request = ProductRequest.fromJson(json);

        expect(request.blueprintId, 39063);
        expect(request.price, 5.00);
        expect(request.quantity, 4);
        expect(request.description, 'Near Mint condition');
        expect(request.userDataField, 'SKU-001');
        expect(request.properties, {
          'condition': 'Near Mint',
          'mtg_language': 'en',
        });
        expect(request.graded, true);
      });
    });

    group('toString', () {
      test('returns readable representation', () {
        final request = ProductRequest(
          blueprintId: 39063,
          price: 5.00,
          quantity: 4,
        );

        expect(
          request.toString(),
          'ProductRequest(blueprintId: 39063, price: 5.0, quantity: 4)',
        );
      });
    });

    group('round-trip serialization', () {
      test('toJson and fromJson produce equivalent objects', () {
        final original = ProductRequest(
          blueprintId: 39063,
          price: 5.00,
          quantity: 4,
          description: 'Near Mint condition',
          userDataField: 'SKU-001',
          properties: {'condition': 'Near Mint', 'mtg_language': 'en'},
          graded: true,
        );

        final json = original.toJson();
        final restored = ProductRequest.fromJson(json);

        expect(restored.blueprintId, original.blueprintId);
        expect(restored.price, original.price);
        expect(restored.quantity, original.quantity);
        expect(restored.description, original.description);
        expect(restored.userDataField, original.userDataField);
        expect(restored.properties, original.properties);
        expect(restored.graded, original.graded);
      });
    });
  });
}
