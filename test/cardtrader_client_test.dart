import 'dart:convert';
import 'dart:io';

import 'package:cardtrader_api/src/cardtrader_client.dart';
import 'package:cardtrader_api/src/models/cardtrader_exception.dart';
import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('CardTraderClient', () {
    late http.Client httpClient;
    late CardTraderClient mockedCardTraderClient;
    late CardTraderClient cardTraderClient;

    late String jsonError;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      mockedCardTraderClient = CardTraderClient(
        httpClient: httpClient,
        apiKey: 'test_api_key',
      );

      // Try to get API key from system environment first
      var apiKey = Platform.environment['CARDTRADER_API_KEY'];

      // If not found, fall back to .env file
      if (apiKey == null) {
        final env = DotEnv()..load();
        apiKey = env['CARDTRADER_API_KEY'];
      }

      if (apiKey == null) {
        throw Exception(
          'CARDTRADER_API_KEY not found in environment variables or .env file',
        );
      }

      cardTraderClient = CardTraderClient(apiKey: apiKey);

      jsonError = jsonEncode({
        'error_code': 'error_code_example',
        'extra': {'message': 'An error occurred'},
        'request_id': '12345',
      });
    });

    tearDown(() {
      cardTraderClient.close();
      mockedCardTraderClient.close();
    });

    group('constructor', () {
      test(
        'should create an instance with the provided API key. HttpClient is not needed',
        () {
          final apiKey = 'test_api_key';
          final client = CardTraderClient(apiKey: apiKey);
          expect(client, isA<CardTraderClient>());
        },
      );
    });

    group('close', () {
      test('should close the HTTP client', () async {
        cardTraderClient.close();

        expect(
          cardTraderClient.getInfo(),
          throwsA(isA<http.ClientException>()),
        );
      });
    });

    group('getInfo', () {
      test('should return API info on success', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(
          jsonEncode({
            "id": 3,
            "name": "Test App",
            "shared_secret": "some-secret",
            "user_id": 12345,
          }),
        );

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        final info = await mockedCardTraderClient.getInfo();

        expect(info.id, 3);
        expect(info.name, 'Test App');
        expect(info.sharedSecret, 'some-secret');
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(400);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        expect(
          () async => await mockedCardTraderClient.getInfo(),
          throwsA(isA<CardTraderException>()),
        );
      });

      test('should return API info on success with real client', () async {
        final info = await cardTraderClient.getInfo();

        expect(info.id, isA<int>());
        expect(info.name, isA<String>());
        expect(info.sharedSecret, isA<String>());
      });
    });
  });
}
