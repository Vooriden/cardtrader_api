import 'dart:convert';
import 'dart:io';

import 'package:cardtrader_api/cardtrader_api.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('CardTraderClient', () {
    late http.Client httpClient;
    late CardTraderClient cardTraderClient;

    late String jsonError;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      cardTraderClient = CardTraderClient(
        httpClient: httpClient,
        apiKey: 'test_api_key',
      );

      jsonError = jsonEncode({
        'error_code': 'error_code_example',
        'extra': {'message': 'An error occurred'},
        'request_id': '12345',
      });
    });

    tearDown(() {
      cardTraderClient.close();
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
        final client = CardTraderClient(apiKey: 'test_api_key');
        client.close();

        expect(client.getInfo(), throwsA(isA<http.ClientException>()));
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

        final info = await cardTraderClient.getInfo();

        expect(info, isA<AppInfo>());
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

        await expectLater(
          cardTraderClient.getInfo(),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('getGames', () {
      test('should return list of games on success', () async {
        final file = File('test/fixtures/get_games.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        final games = await cardTraderClient.getGames();

        expect(games, isA<GameList>());
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(400);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.getGames(),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('getCategories', () {
      test('should return list of categories on success', () async {
        final file = File('test/fixtures/get_categories.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        final categories = await cardTraderClient.getCategories();

        expect(categories, isA<List<Category>>());
        expect(categories.length, 2);
        expect(categories.first.name, 'Single Cards');
        expect(categories.first.properties.length, 2);
      });

      test('should pass gameId as query parameter', () async {
        final file = File('test/fixtures/get_categories.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.getCategories(gameId: 1);

        final captured = verify(
          () => httpClient.get(captureAny(), headers: any(named: 'headers')),
        ).captured;

        final uri = captured.first as Uri;
        expect(uri.queryParameters['game_id'], '1');
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(400);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.getCategories(),
          throwsA(isA<CardTraderException>()),
        );
      });
    });
  });
}
