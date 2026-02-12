import 'package:cardtrader_api/src/models/user.dart';
import 'package:test/test.dart';

void main() {
  group('User', () {
    final json = {
      "id": 7343,
      "username": "Astaroth",
      "can_sell_via_hub": false,
      "country_code": "IT",
      "user_type": "normal",
      "max_sellable_in24h_quantity": null,
      "too_many_request_for_cancel_as_seller": false,
      "can_sell_sealed_with_ct_zero": false,
    };

    group('fromJson', () {
      test('parses JSON correctly with all fields', () {
        final user = User.fromJson(json);

        expect(
          user,
          isA<User>()
              .having((u) => u.id, 'id', 7343)
              .having((u) => u.username, 'username', 'Astaroth')
              .having((u) => u.canSellViaHub, 'canSellViaHub', false)
              .having((u) => u.countryCode, 'countryCode', 'IT')
              .having((u) => u.userType, 'userType', 'normal')
              .having(
                (u) => u.maxSellableIn24hQuantity,
                'maxSellableIn24hQuantity',
                isNull,
              )
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

      test('parses JSON with only required fields', () {
        final jsonMinimal = {"id": 123, "username": "user123"};

        final user = User.fromJson(jsonMinimal);

        expect(user.id, 123);
        expect(user.username, 'user123');
        expect(user.canSellViaHub, isNull);
        expect(user.countryCode, isNull);
        expect(user.userType, isNull);
        expect(user.maxSellableIn24hQuantity, isNull);
        expect(user.tooManyRequestForCancelAsSeller, isNull);
        expect(user.canSellSealedWithCtZero, isNull);
      });

      test('parses JSON with partial optional fields', () {
        final jsonPartial = {
          "id": 456,
          "username": "collector",
          "country_code": "DE",
        };

        final user = User.fromJson(jsonPartial);

        expect(user.id, 456);
        expect(user.username, 'collector');
        expect(user.countryCode, 'DE');
        expect(user.canSellViaHub, isNull);
      });
    });

    group('toJson', () {
      test('converts to JSON correctly with all fields', () {
        final user = User.fromJson(json);
        final jsonOutput = user.toJson();

        expect(jsonOutput['id'], 7343);
        expect(jsonOutput['username'], 'Astaroth');
        expect(jsonOutput['can_sell_via_hub'], false);
        expect(jsonOutput['country_code'], 'IT');
        expect(jsonOutput['user_type'], 'normal');
        expect(jsonOutput['too_many_request_for_cancel_as_seller'], false);
        expect(jsonOutput['can_sell_sealed_with_ct_zero'], false);
      });

      test('converts to JSON correctly with only required fields', () {
        final user = User(id: 123, username: 'test');
        final jsonOutput = user.toJson();

        expect(jsonOutput['id'], 123);
        expect(jsonOutput['username'], 'test');
      });
    });

    group('constructor', () {
      test('creates instance with required fields only', () {
        final user = User(id: 1, username: 'testuser');

        expect(user.id, 1);
        expect(user.username, 'testuser');
        expect(user.canSellViaHub, isNull);
        expect(user.countryCode, isNull);
        expect(user.userType, isNull);
        expect(user.maxSellableIn24hQuantity, isNull);
        expect(user.tooManyRequestForCancelAsSeller, isNull);
        expect(user.canSellSealedWithCtZero, isNull);
      });

      test('creates instance with all fields', () {
        final user = User(
          id: 100,
          username: 'shop',
          canSellViaHub: true,
          countryCode: 'US',
          userType: 'professional',
          maxSellableIn24hQuantity: 500,
          tooManyRequestForCancelAsSeller: false,
          canSellSealedWithCtZero: true,
        );

        expect(user.id, 100);
        expect(user.username, 'shop');
        expect(user.canSellViaHub, true);
        expect(user.countryCode, 'US');
        expect(user.userType, 'professional');
        expect(user.maxSellableIn24hQuantity, 500);
        expect(user.tooManyRequestForCancelAsSeller, false);
        expect(user.canSellSealedWithCtZero, true);
      });
    });
  });
}
