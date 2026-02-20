import 'package:cardtrader_api/src/models/product_update_request.dart';
import 'package:test/test.dart';

void main() {
  group('ProductUpdateRequest', () {
    group('constructor', () {
      test('creates instance with required id only', () {
        final request = ProductUpdateRequest(id: 123456);

        expect(request.id, 123456);
        expect(request.price, isNull);
        expect(request.quantity, isNull);
        expect(request.description, isNull);
        expect(request.userDataField, isNull);
        expect(request.properties, isNull);
        expect(request.graded, isNull);
      });

      test('creates instance with all fields', () {
        final request = ProductUpdateRequest(
          id: 123456,
          price: 5.00,
          quantity: 10,
          description: 'Updated description',
          userDataField: 'SKU-002',
          properties: {'condition': 'Slightly Played'},
          graded: false,
        );

        expect(request.id, 123456);
        expect(request.price, 5.00);
        expect(request.quantity, 10);
        expect(request.description, 'Updated description');
        expect(request.userDataField, 'SKU-002');
        expect(request.properties, {'condition': 'Slightly Played'});
        expect(request.graded, false);
      });
    });

    group('toJson', () {
      test('serializes required id only', () {
        final request = ProductUpdateRequest(id: 123456);

        final json = request.toJson();

        expect(json, {'id': 123456});
        expect(json.containsKey('price'), isFalse);
        expect(json.containsKey('quantity'), isFalse);
        expect(json.containsKey('description'), isFalse);
        expect(json.containsKey('user_data_field'), isFalse);
        expect(json.containsKey('properties'), isFalse);
        expect(json.containsKey('graded'), isFalse);
      });

      test('serializes only provided fields', () {
        final request = ProductUpdateRequest(
          id: 123456,
          price: 5.00,
          quantity: 10,
        );

        final json = request.toJson();

        expect(json, {'id': 123456, 'price': 5.00, 'quantity': 10});
        expect(json.containsKey('description'), isFalse);
        expect(json.containsKey('user_data_field'), isFalse);
        expect(json.containsKey('properties'), isFalse);
        expect(json.containsKey('graded'), isFalse);
      });

      test('serializes all fields when provided', () {
        final request = ProductUpdateRequest(
          id: 123456,
          price: 5.00,
          quantity: 10,
          description: 'Updated description',
          userDataField: 'SKU-002',
          properties: {'condition': 'Slightly Played'},
          graded: false,
        );

        final json = request.toJson();

        expect(json, {
          'id': 123456,
          'price': 5.00,
          'quantity': 10,
          'description': 'Updated description',
          'user_data_field': 'SKU-002',
          'properties': {'condition': 'Slightly Played'},
          'graded': false,
        });
      });
    });

    group('fromJson', () {
      test('deserializes with required id only', () {
        final json = {'id': 123456};

        final request = ProductUpdateRequest.fromJson(json);

        expect(request.id, 123456);
        expect(request.price, isNull);
        expect(request.quantity, isNull);
        expect(request.description, isNull);
        expect(request.userDataField, isNull);
        expect(request.properties, isNull);
        expect(request.graded, isNull);
      });

      test('deserializes all fields', () {
        final json = {
          'id': 123456,
          'price': 5.00,
          'quantity': 10,
          'description': 'Updated description',
          'user_data_field': 'SKU-002',
          'properties': {'condition': 'Slightly Played'},
          'graded': false,
        };

        final request = ProductUpdateRequest.fromJson(json);

        expect(request.id, 123456);
        expect(request.price, 5.00);
        expect(request.quantity, 10);
        expect(request.description, 'Updated description');
        expect(request.userDataField, 'SKU-002');
        expect(request.properties, {'condition': 'Slightly Played'});
        expect(request.graded, false);
      });
    });

    group('toString', () {
      test('returns readable representation', () {
        final request = ProductUpdateRequest(id: 123456);

        expect(request.toString(), 'ProductUpdateRequest(id: 123456)');
      });
    });

    group('round-trip serialization', () {
      test('toJson and fromJson produce equivalent objects', () {
        final original = ProductUpdateRequest(
          id: 123456,
          price: 5.00,
          quantity: 10,
          description: 'Updated description',
          userDataField: 'SKU-002',
          properties: {'condition': 'Slightly Played'},
          graded: false,
        );

        final json = original.toJson();
        final restored = ProductUpdateRequest.fromJson(json);

        expect(restored.id, original.id);
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
