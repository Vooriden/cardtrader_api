import 'package:cardtrader_api/src/models/cardtrader_exception.dart';
import 'package:test/test.dart';

void main() {
  group('CardTraderException', () {
    final statusCode = 401;
    final json = {
      "error_code": "unauthorized",
      "extra": {"message": "Invalid API key"},
      "request_id": "abc123",
    };

    group('fromJson', () {
      test('parses standard error JSON correctly', () {
        final exception = CardTraderException.fromJson(json, statusCode);

        expect(
          exception,
          isA<CardTraderException>()
              .having((e) => e.statusCode, 'status_code', statusCode)
              .having((e) => e.errorCode, 'error_code', 'unauthorized')
              .having(
                (e) => e.extra!.message,
                'extra.message',
                'Invalid API key',
              )
              .having((e) => e.requestId, 'request_id', 'abc123')
              .having((e) => e.errors, 'errors', isNull),
        );
      });

      test('parses errors array format correctly', () {
        final errorsJson = {
          "errors": ["Must have at least one item"],
        };

        final exception = CardTraderException.fromJson(errorsJson, 422);

        expect(exception.statusCode, 422);
        expect(exception.errorCode, isNull);
        expect(exception.extra, isNull);
        expect(exception.requestId, isNull);
        expect(exception.errors, ['Must have at least one item']);
      });

      test('parses errors array with multiple messages', () {
        final errorsJson = {
          "errors": ["Name is required", "Must have at least one item"],
        };

        final exception = CardTraderException.fromJson(errorsJson, 422);

        expect(exception.errors!.length, 2);
        expect(exception.errors![0], 'Name is required');
        expect(exception.errors![1], 'Must have at least one item');
      });
    });

    group('message', () {
      test('returns extra message for standard errors', () {
        final exception = CardTraderException.fromJson(json, statusCode);
        expect(exception.message, 'Invalid API key');
      });

      test('returns joined errors for array format', () {
        final errorsJson = {
          "errors": ["Name is required", "Must have at least one item"],
        };

        final exception = CardTraderException.fromJson(errorsJson, 422);
        expect(
          exception.message,
          'Name is required, Must have at least one item',
        );
      });

      test('returns Unknown error when no message available', () {
        final exception = CardTraderException(statusCode: 500);
        expect(exception.message, 'Unknown error');
      });
    });

    group('toJson', () {
      test('converts standard error to JSON correctly', () {
        final exception = CardTraderException.fromJson(json, statusCode);
        final jsonOutput = exception.toJson();

        expect(jsonOutput['status_code'], statusCode);
        expect(jsonOutput['error_code'], 'unauthorized');
        expect(jsonOutput['extra'], {'message': 'Invalid API key'});
        expect(jsonOutput['request_id'], 'abc123');
      });

      test('converts errors array to JSON correctly', () {
        final errorsJson = {
          "errors": ["Must have at least one item"],
        };

        final exception = CardTraderException.fromJson(errorsJson, 422);
        final jsonOutput = exception.toJson();

        expect(jsonOutput['status_code'], 422);
        expect(jsonOutput['errors'], ['Must have at least one item']);
      });
    });
  });
}
