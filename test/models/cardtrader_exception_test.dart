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
      test('parses JSON correctly', () {
        final exception = CardTraderException.fromJson(json, statusCode);

        expect(
          exception,
          isA<CardTraderException>()
              .having((e) => e.statusCode, 'status_code', statusCode)
              .having((e) => e.errorCode, 'error_code', 'unauthorized')
              .having(
                (e) => e.extra.message,
                'extra.message',
                'Invalid API key',
              )
              .having((e) => e.requestId, 'request_id', 'abc123'),
        );
      });
    });

    group('toJson', () {
      test('converts to JSON correctly', () {
        final exception = CardTraderException.fromJson(json, statusCode);
        final jsonOutput = exception.toJson();

        expect(jsonOutput, {
          'status_code': statusCode,
          'error_code': 'unauthorized',
          'extra': {'message': 'Invalid API key'},
          'request_id': 'abc123',
        });
      });
    });
  });
}
