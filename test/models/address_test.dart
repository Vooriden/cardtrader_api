import 'package:cardtrader_api/src/models/address.dart';
import 'package:test/test.dart';

void main() {
  group('Address', () {
    final json = {
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
    };

    group('fromJson', () {
      test('parses JSON correctly with all fields', () {
        final address = Address.fromJson(json);

        expect(address.id, 39645);
        expect(address.userId, 12345678);
        expect(address.name, 'Some User');
        expect(address.street, 'Via Roma 1');
        expect(address.zip, '00000');
        expect(address.city, 'Roma');
        expect(address.stateOrProvince, 'RM');
        expect(address.countryCode, 'IT');
        expect(address.phone, '+391234567890');
        expect(address.keepOriginal, true);
        expect(address.defaultBillingAddress, false);
        expect(address.defaultShippingAddress, true);
        expect(address.latitude, isNull);
        expect(address.longitude, isNull);
        expect(address.note, isNull);
        expect(address.createdAt, isNotNull);
        expect(address.updatedAt, isNotNull);
      });

      test('parses JSON with only required fields', () {
        final jsonMinimal = {
          "name": "Jane Doe",
          "street": "Main St 42",
          "zip": "12345",
          "city": "New York",
          "state_or_province": "NY",
          "country_code": "US",
        };

        final address = Address.fromJson(jsonMinimal);

        expect(address.id, isNull);
        expect(address.userId, isNull);
        expect(address.name, 'Jane Doe');
        expect(address.street, 'Main St 42');
        expect(address.zip, '12345');
        expect(address.city, 'New York');
        expect(address.stateOrProvince, 'NY');
        expect(address.countryCode, 'US');
        expect(address.phone, isNull);
        expect(address.keepOriginal, isNull);
        expect(address.note, isNull);
      });
    });

    group('toJson', () {
      test('converts to JSON correctly', () {
        final address = Address.fromJson(json);
        final jsonOutput = address.toJson();

        expect(jsonOutput['id'], 39645);
        expect(jsonOutput['user_id'], 12345678);
        expect(jsonOutput['name'], 'Some User');
        expect(jsonOutput['street'], 'Via Roma 1');
        expect(jsonOutput['zip'], '00000');
        expect(jsonOutput['city'], 'Roma');
        expect(jsonOutput['state_or_province'], 'RM');
        expect(jsonOutput['country_code'], 'IT');
        expect(jsonOutput['phone'], '+391234567890');
        expect(jsonOutput['keep_original'], true);
        expect(jsonOutput['default_billing_address'], false);
        expect(jsonOutput['default_shipping_address'], true);
      });
    });

    group('constructor', () {
      test('creates instance with required fields only', () {
        final address = Address(
          name: 'Test User',
          street: '123 Test St',
          zip: '00000',
          city: 'Test City',
          stateOrProvince: 'TC',
          countryCode: 'TC',
        );

        expect(address.id, isNull);
        expect(address.userId, isNull);
        expect(address.name, 'Test User');
        expect(address.street, '123 Test St');
        expect(address.zip, '00000');
        expect(address.city, 'Test City');
        expect(address.stateOrProvince, 'TC');
        expect(address.countryCode, 'TC');
        expect(address.phone, isNull);
        expect(address.note, isNull);
      });

      test('creates instance with all fields', () {
        final address = Address(
          id: 1,
          userId: 100,
          name: 'Test User',
          street: '123 Test St',
          zip: '00000',
          city: 'Test City',
          stateOrProvince: 'TC',
          countryCode: 'TC',
          phone: '+1234567890',
          keepOriginal: false,
          defaultBillingAddress: true,
          defaultShippingAddress: false,
          latitude: 41.9028,
          longitude: 12.4964,
          note: 'Test note',
        );

        expect(address.id, 1);
        expect(address.userId, 100);
        expect(address.name, 'Test User');
        expect(address.phone, '+1234567890');
        expect(address.keepOriginal, false);
        expect(address.defaultBillingAddress, true);
        expect(address.defaultShippingAddress, false);
        expect(address.latitude, 41.9028);
        expect(address.longitude, 12.4964);
        expect(address.note, 'Test note');
      });
    });
  });
}
