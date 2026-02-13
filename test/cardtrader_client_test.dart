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

    group('getExpansions', () {
      test('should return list of expansions on success', () async {
        final file = File('test/fixtures/get_expansions.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        final expansions = await cardTraderClient.getExpansions();

        expect(expansions, isA<List<Expansion>>());
        expect(expansions.length, 2);
        expect(expansions.first.name, 'Dominaria');
        expect(expansions.first.code, 'dom');
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(400);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.getExpansions(),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('getMyExpansions', () {
      test(
        'should return list of expansions from inventory on success',
        () async {
          final file = File('test/fixtures/get_expansions.json');
          final jsonContent = await file.readAsString();

          final mockResponse = MockResponse();
          when(() => mockResponse.statusCode).thenReturn(200);
          when(() => mockResponse.body).thenReturn(jsonContent);
          when(
            () => httpClient.get(any(), headers: any(named: 'headers')),
          ).thenAnswer((_) async => mockResponse);

          final expansions = await cardTraderClient.getMyExpansions();

          expect(expansions, isA<List<Expansion>>());
          expect(expansions.length, 2);
        },
      );

      test('should call /expansions/export endpoint', () async {
        final file = File('test/fixtures/get_expansions.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.getMyExpansions();

        final captured = verify(
          () => httpClient.get(captureAny(), headers: any(named: 'headers')),
        ).captured;

        final uri = captured.first as Uri;
        expect(uri.path, contains('/expansions/export'));
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(400);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.getMyExpansions(),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('getBlueprintsByExpansion', () {
      test('should return list of blueprints on success', () async {
        final file = File('test/fixtures/get_blueprints.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        final blueprints = await cardTraderClient.getBlueprintsByExpansion(
          2921,
        );

        expect(blueprints, isA<List<Blueprint>>());
        expect(blueprints.length, 2);
        expect(
          blueprints.first.name,
          'Fable of the Mirror-Breaker // Reflection of Kiki-Jiki',
        );
        expect(blueprints.first.version, '');
        expect(blueprints.first.expansionId, 2921);
        expect(blueprints.first.editableProperties.length, 5);
        expect(blueprints.first.image, isNotNull);
        expect(blueprints.first.backImage, isNotNull);
        expect(blueprints.first.fixedProperties, isNotNull);
        expect(blueprints.first.fixedProperties['mtg_rarity'], 'Rare');
      });

      test('should pass expansionId as query parameter', () async {
        final file = File('test/fixtures/get_blueprints.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.getBlueprintsByExpansion(123);

        final captured = verify(
          () => httpClient.get(captureAny(), headers: any(named: 'headers')),
        ).captured;

        final uri = captured.first as Uri;
        expect(uri.path, contains('/blueprints/export'));
        expect(uri.queryParameters['expansion_id'], '123');
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(400);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.getBlueprintsByExpansion(123),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('getMarketplaceProducts', () {
      test('should return map of products on success', () async {
        final file = File('test/fixtures/get_marketplace_products.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        final products = await cardTraderClient.getMarketplaceProducts(
          expansionId: 34,
        );

        expect(products, isA<Map<String, List<MarketplaceProduct>>>());
        expect(products.keys.length, 1);
        expect(products['3138'], isNotNull);
        expect(products['3138']!.length, 1);
        expect(products['3138']!.first.nameEn, 'Earl of Squirrel');
        expect(products['3138']!.first.price.cents, 20);
        expect(products['3138']!.first.price.formatted, '€0.20');
        expect(products['3138']!.first.user.username, 'Astaroth');
        expect(products['3138']!.first.expansion.nameEn, 'Unstable Promos');
      });

      test('should pass expansionId as query parameter', () async {
        final file = File('test/fixtures/get_marketplace_products.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.getMarketplaceProducts(expansionId: 34);

        final captured = verify(
          () => httpClient.get(captureAny(), headers: any(named: 'headers')),
        ).captured;

        final uri = captured.first as Uri;
        expect(uri.path, contains('/marketplace/products'));
        expect(uri.queryParameters['expansion_id'], '34');
      });

      test('should pass blueprintId as query parameter', () async {
        final file = File('test/fixtures/get_marketplace_products.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.getMarketplaceProducts(blueprintId: 3138);

        final captured = verify(
          () => httpClient.get(captureAny(), headers: any(named: 'headers')),
        ).captured;

        final uri = captured.first as Uri;
        expect(uri.queryParameters['blueprint_id'], '3138');
      });

      test('should pass all optional parameters', () async {
        final file = File('test/fixtures/get_marketplace_products.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.getMarketplaceProducts(
          expansionId: 34,
          foil: true,
          language: 'en',
        );

        final captured = verify(
          () => httpClient.get(captureAny(), headers: any(named: 'headers')),
        ).captured;

        final uri = captured.first as Uri;
        expect(uri.queryParameters['expansion_id'], '34');
        expect(uri.queryParameters['foil'], 'true');
        expect(uri.queryParameters['language'], 'en');
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(400);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.getMarketplaceProducts(expansionId: 34),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('getCart', () {
      test('should return cart on success', () async {
        final file = File('test/fixtures/get_cart.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        final cart = await cardTraderClient.getCart();

        expect(cart, isA<Cart>());
        expect(cart.id, 12345678);
        expect(cart.subcarts.length, 3);
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(400);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.getCart(),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('addToCart', () {
      test('should add item to cart successfully', () async {
        final file = File('test/fixtures/get_cart.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final cart = await cardTraderClient.addToCart(
          productId: 123,
          quantity: 2,
          viaCardtraderZero: false,
        );

        expect(cart, isA<Cart>());
      });

      test('should send correct body parameters', () async {
        final file = File('test/fixtures/get_cart.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.addToCart(
          productId: 123,
          quantity: 2,
          viaCardtraderZero: true,
        );

        final captured = verify(
          () => httpClient.post(
            captureAny(),
            headers: any(named: 'headers'),
            body: captureAny(named: 'body'),
          ),
        ).captured;

        final body = jsonDecode(captured[1] as String);
        expect(body['product_id'], 123);
        expect(body['quantity'], 2);
        expect(body['via_cardtrader_zero'], true);
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(400);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.addToCart(
            productId: 123,
            quantity: 1,
            viaCardtraderZero: false,
          ),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('removeFromCart', () {
      test('should remove item from cart successfully', () async {
        final file = File('test/fixtures/get_cart.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final cart = await cardTraderClient.removeFromCart(
          productId: 123,
          quantity: 1,
        );

        expect(cart, isA<Cart>());
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(400);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.removeFromCart(productId: 123, quantity: 1),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('purchaseCart', () {
      test('should purchase cart successfully', () async {
        final file = File('test/fixtures/get_cart.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final cart = await cardTraderClient.purchaseCart();

        expect(cart, isA<Cart>());
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(400);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.purchaseCart(),
          throwsA(isA<CardTraderException>()),
        );
      });
    });
  });
}
