import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cardtrader_api/cardtrader_api.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class MockStreamedResponse extends Mock implements http.StreamedResponse {}

class FakeUri extends Fake implements Uri {}

class FakeBaseRequest extends Fake implements http.BaseRequest {}

void main() {
  group('CardTraderClient', () {
    late http.Client httpClient;
    late CardTraderClient cardTraderClient;

    late String jsonError;

    setUpAll(() {
      registerFallbackValue(FakeUri());
      registerFallbackValue(FakeBaseRequest());
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

        final billing = Address(
          name: 'John Doe',
          street: '123 Main St',
          zip: '12345',
          city: 'Springfield',
          stateOrProvince: 'IL',
          countryCode: 'US',
        );
        final shipping = Address(
          name: 'Jane Doe',
          street: '456 Oak Ave',
          zip: '67890',
          city: 'Shelbyville',
          stateOrProvince: 'IL',
          countryCode: 'US',
        );

        await cardTraderClient.addToCart(
          productId: 123,
          quantity: 2,
          viaCardtraderZero: true,
          billingAddress: billing,
          shippingAddress: shipping,
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
        expect(body['billing_address']['name'], 'John Doe');
        expect(body['shipping_address']['name'], 'Jane Doe');
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

    group('getWishlists', () {
      test('should return paginated wishlists on success', () async {
        final file = File('test/fixtures/get_wishlists.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        final result = await cardTraderClient.getWishlists();

        expect(result, isA<PaginatedResponse<Wishlist>>());
        expect(result.page, 1);
        expect(result.limit, 20);
        expect(result.items.length, 2);
        expect(result.items[0].name, 'My MTG Wishlist');
        expect(result.items[1].name, 'Yu-Gi-Oh Cards');
      });

      test('should pass gameId, page and limit as query parameters', () async {
        final file = File('test/fixtures/get_wishlists.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        final result = await cardTraderClient.getWishlists(
          gameId: 1,
          page: 2,
          limit: 10,
        );

        final captured = verify(
          () => httpClient.get(captureAny(), headers: any(named: 'headers')),
        ).captured;

        final uri = captured.last as Uri;
        expect(uri.queryParameters['game_id'], '1');
        expect(uri.queryParameters['page'], '2');
        expect(uri.queryParameters['limit'], '10');
        expect(result.page, 2);
        expect(result.limit, 10);
      });

      test('should use default page and limit values', () async {
        final file = File('test/fixtures/get_wishlists.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.getWishlists();

        final captured = verify(
          () => httpClient.get(captureAny(), headers: any(named: 'headers')),
        ).captured;

        final uri = captured.last as Uri;
        expect(uri.queryParameters['page'], '1');
        expect(uri.queryParameters['limit'], '20');
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(400);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.getWishlists(),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('getWishlist', () {
      test('should return wishlist with items on success', () async {
        final file = File('test/fixtures/get_wishlist.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        final wishlist = await cardTraderClient.getWishlist(1);

        expect(wishlist, isA<Wishlist>());
        expect(wishlist.id, 1);
        expect(wishlist.name, 'My MTG Wishlist');
        expect(wishlist.items, isNotNull);
        expect(wishlist.items!.length, 2);
        expect(wishlist.items![0].metaName, 'Lightning Bolt');
        expect(wishlist.items![1].metaName, 'Black Lotus');
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(404);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.getWishlist(999),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('createWishlist', () {
      test('should create wishlist successfully', () async {
        final file = File('test/fixtures/get_wishlist.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(201);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final wishlist = await cardTraderClient.createWishlist(
          name: 'My MTG Wishlist',
          gameId: 1,
          isPublic: true,
          deckItemsFromText: '2 Lightning Bolt',
        );

        expect(wishlist, isA<Wishlist>());
        expect(wishlist.name, 'My MTG Wishlist');
      });

      test('should send correct body parameters', () async {
        final file = File('test/fixtures/get_wishlist.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(201);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.createWishlist(
          name: 'Test Wishlist',
          gameId: 1,
          isPublic: true,
          deckItemsFromText: '4 Lightning Bolt',
          deckItems: [DeckItem(quantity: 4, metaName: 'Lightning Bolt')],
        );

        final captured = verify(
          () => httpClient.post(
            captureAny(),
            headers: any(named: 'headers'),
            body: captureAny(named: 'body'),
          ),
        ).captured;

        final body = jsonDecode(captured[1] as String);
        expect(body['name'], 'Test Wishlist');
        expect(body['game_id'], 1);
        expect(body['public'], true);
        expect(body['deck_items_from_text_deck'], '4 Lightning Bolt');
        expect(body['deck_items_attributes'], isList);
        expect(body['deck_items_attributes'][0]['meta_name'], 'Lightning Bolt');
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
          cardTraderClient.createWishlist(
            name: 'Test',
            gameId: 1,
            deckItemsFromText: '1 Card',
          ),
          throwsA(isA<CardTraderException>()),
        );
      });

      test('should throw ArgumentError when no items provided', () async {
        expect(
          () => cardTraderClient.createWishlist(name: 'Test', gameId: 1),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should throw ArgumentError when deckItems is empty', () async {
        expect(
          () => cardTraderClient.createWishlist(
            name: 'Test',
            gameId: 1,
            deckItems: [],
          ),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('deleteWishlist', () {
      test('should delete wishlist successfully with 200', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn('');
        when(
          () => httpClient.delete(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.deleteWishlist(1);

        verify(
          () => httpClient.delete(any(), headers: any(named: 'headers')),
        ).called(1);
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(404);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.delete(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.deleteWishlist(999),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    // ========== INVENTORY MANAGEMENT ==========

    group('getMyProducts', () {
      test('should return list of products on success', () async {
        final file = File('test/fixtures/get_my_products.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        final products = await cardTraderClient.getMyProducts();

        expect(products, isA<List<Product>>());
        expect(products.length, 2);
        expect(products[0].id, 123456);
        expect(products[0].nameEn, 'Lightning Bolt');
        expect(products[0].quantity, 3);
        expect(products[0].priceCents, 500);
        expect(products[1].id, 123457);
        expect(products[1].nameEn, 'Counterspell');
      });

      test('should pass blueprint_id query parameter', () async {
        final file = File('test/fixtures/get_my_products.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.getMyProducts(blueprintId: 39063);

        final captured = verify(
          () => httpClient.get(captureAny(), headers: any(named: 'headers')),
        ).captured;

        final uri = captured[0] as Uri;
        expect(uri.queryParameters['blueprint_id'], '39063');
      });

      test('should pass expansion_id query parameter', () async {
        final file = File('test/fixtures/get_my_products.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.getMyProducts(expansionId: 404);

        final captured = verify(
          () => httpClient.get(captureAny(), headers: any(named: 'headers')),
        ).captured;

        final uri = captured[0] as Uri;
        expect(uri.queryParameters['expansion_id'], '404');
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(401);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.getMyProducts(),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('createProduct', () {
      test('should create a product and return it', () async {
        final file = File('test/fixtures/create_product.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(201);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final product = await cardTraderClient.createProduct(
          blueprintId: 39063,
          price: 4.50,
          quantity: 2,
        );

        expect(product, isA<Product>());
        expect(product.id, 789000);
        expect(product.nameEn, isNull);
        expect(product.quantity, 2);
        expect(product.priceCents, 450);
        expect(product.expansionId, 404);
      });

      test('should send correct body parameters', () async {
        final file = File('test/fixtures/create_product.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(201);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.createProduct(
          blueprintId: 39063,
          price: 4.50,
          quantity: 2,
          description: 'Test',
          graded: true,
          properties: {'condition': 'Near Mint'},
          userDataField: 'my-custom-data',
        );

        final captured = verify(
          () => httpClient.post(
            captureAny(),
            headers: any(named: 'headers'),
            body: captureAny(named: 'body'),
          ),
        ).captured;

        final body = jsonDecode(captured[1] as String);
        expect(body['blueprint_id'], 39063);
        expect(body['price'], 4.50);
        expect(body['quantity'], 2);
        expect(body['description'], 'Test');
        expect(body['graded'], true);
        expect(body['properties'], {'condition': 'Near Mint'});
        expect(body['user_data_field'], 'my-custom-data');
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(422);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.createProduct(
            blueprintId: 39063,
            price: 4.50,
            quantity: 2,
          ),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('updateProduct', () {
      test('should update a product and return it', () async {
        final file = File('test/fixtures/update_product.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final product = await cardTraderClient.updateProduct(
          id: 789000,
          price: 6.00,
          quantity: 5,
        );

        expect(product, isA<Product>());
        expect(product.id, 789000);
        expect(product.quantity, 5);
        expect(product.priceCents, 600);
      });

      test('should send correct body parameters', () async {
        final file = File('test/fixtures/update_product.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.updateProduct(
          id: 789000,
          price: 6.00,
          description: 'Updated',
          userDataField: 'custom-data',
          properties: {'condition': 'Played'},
          graded: true,
        );

        final captured = verify(
          () => httpClient.put(
            captureAny(),
            headers: any(named: 'headers'),
            body: captureAny(named: 'body'),
          ),
        ).captured;

        final uri = captured[0] as Uri;
        expect(uri.path, contains('/products/789000'));

        final body = jsonDecode(captured[1] as String);
        expect(body['price'], 6.00);
        expect(body['description'], 'Updated');
        expect(body['user_data_field'], 'custom-data');
        expect(body['properties'], {'condition': 'Played'});
        expect(body['graded'], true);
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(404);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.updateProduct(id: 999, price: 1.00),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('deleteProduct', () {
      test('should delete product successfully with 200', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn('');
        when(
          () => httpClient.delete(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.deleteProduct(123456);

        verify(
          () => httpClient.delete(any(), headers: any(named: 'headers')),
        ).called(1);
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(404);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.delete(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.deleteProduct(999),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('incrementProduct', () {
      test(
        'should increment product quantity and return updated product',
        () async {
          final file = File('test/fixtures/increment_product.json');
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

          final product = await cardTraderClient.incrementProduct(
            id: 789000,
            deltaQuantity: 5,
          );

          expect(product, isA<Product>());
          expect(product.id, 789000);
          expect(product.quantity, 7);
        },
      );

      test('should send correct body with delta_quantity', () async {
        final file = File('test/fixtures/increment_product.json');
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

        await cardTraderClient.incrementProduct(id: 789000, deltaQuantity: -2);

        final captured = verify(
          () => httpClient.post(
            captureAny(),
            headers: any(named: 'headers'),
            body: captureAny(named: 'body'),
          ),
        ).captured;

        final uri = captured[0] as Uri;
        expect(uri.path, contains('/products/789000/increment'));

        final body = jsonDecode(captured[1] as String);
        expect(body['delta_quantity'], -2);
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(422);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.incrementProduct(id: 999, deltaQuantity: 1),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    // ========== BATCH OPERATIONS ==========

    group('bulkCreateProducts', () {
      test('should return job UUID on success', () async {
        final file = File('test/fixtures/bulk_operation.json');
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

        final jobUuid = await cardTraderClient.bulkCreateProducts([
          ProductRequest(blueprintId: 39063, price: 4.50, quantity: 2),
          ProductRequest(blueprintId: 39064, price: 12.00, quantity: 1),
        ]);

        expect(jobUuid, '550e8400-e29b-41d4-a716-446655440000');
      });

      test('should send correct body', () async {
        final file = File('test/fixtures/bulk_operation.json');
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

        await cardTraderClient.bulkCreateProducts([
          ProductRequest(blueprintId: 39063, price: 4.50, quantity: 2),
        ]);

        final captured = verify(
          () => httpClient.post(
            captureAny(),
            headers: any(named: 'headers'),
            body: captureAny(named: 'body'),
          ),
        ).captured;

        final uri = captured[0] as Uri;
        expect(uri.path, contains('/products/bulk_create'));

        final body = jsonDecode(captured[1] as String);
        expect(body['products'], isA<List>());
        expect(body['products'].length, 1);
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(422);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.bulkCreateProducts(<ProductRequest>[]),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('bulkUpdateProducts', () {
      test('should return job UUID on success', () async {
        final file = File('test/fixtures/bulk_operation.json');
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

        final jobUuid = await cardTraderClient.bulkUpdateProducts([
          ProductUpdateRequest(id: 123456, price: 5.00),
        ]);

        expect(jobUuid, '550e8400-e29b-41d4-a716-446655440000');
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(422);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.bulkUpdateProducts(<ProductUpdateRequest>[]),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('bulkDeleteProducts', () {
      test('should return job UUID on success', () async {
        final file = File('test/fixtures/bulk_operation.json');
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

        final jobUuid = await cardTraderClient.bulkDeleteProducts([
          123456,
          123457,
        ]);

        expect(jobUuid, '550e8400-e29b-41d4-a716-446655440000');
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(422);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.bulkDeleteProducts(<int>[]),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('getJobStatus', () {
      test('should return job on success', () async {
        final file = File('test/fixtures/get_job_status.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        final job = await cardTraderClient.getJobStatus(
          '550e8400-e29b-41d4-a716-446655440000',
        );

        expect(job, isA<Job>());
        expect(job.uuid, '550e8400-e29b-41d4-a716-446655440000');
        expect(job.state, 'completed');
        expect(job.isCompleted, true);
        expect(job.spawnedChildren, 3);
        expect(job.stats.ok, 2);
        expect(job.stats.warning, 1);
        expect(job.stats.error, 0);
        expect(job.results.length, 3);
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(404);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.getJobStatus('invalid-uuid'),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    // ========== PRODUCT IMAGES ==========

    group('uploadProductImage', () {
      test('should upload image bytes and return image ID', () async {
        final imageBytes = Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0]);

        final streamedResponse = http.StreamedResponse(
          Stream.value(utf8.encode(jsonEncode({'id': 98765}))),
          200,
        );

        when(
          () => httpClient.send(any()),
        ).thenAnswer((_) async => streamedResponse);

        final imageId = await cardTraderClient.uploadProductImage(
          id: 789000,
          imageBytes: imageBytes,
          filename: 'card.jpg',
        );

        expect(imageId, 98765);

        final captured = verify(() => httpClient.send(captureAny())).captured;

        final request = captured[0] as http.MultipartRequest;
        expect(request.method, 'POST');
        expect(request.url.path, contains('/products/789000/upload_image'));
        expect(request.files.length, 1);
        expect(request.files.first.field, 'uploaded_image[image]');
        expect(request.files.first.filename, 'card.jpg');
      });

      test('should throw CardTraderException on error', () async {
        final imageBytes = Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0]);

        final streamedResponse = http.StreamedResponse(
          Stream.value(utf8.encode(jsonError)),
          422,
        );

        when(
          () => httpClient.send(any()),
        ).thenAnswer((_) async => streamedResponse);

        await expectLater(
          cardTraderClient.uploadProductImage(
            id: 789000,
            imageBytes: imageBytes,
            filename: 'card.jpg',
          ),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('uploadProductImageFromUrl', () {
      test('should upload image from URL and return image ID', () async {
        final file = File('test/fixtures/upload_image.json');
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

        final imageId = await cardTraderClient.uploadProductImageFromUrl(
          id: 789000,
          imageUrl: 'https://example.com/card.jpg',
        );

        expect(imageId, 98765);
      });

      test('should send correct body with remote_image_url', () async {
        final file = File('test/fixtures/upload_image.json');
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

        await cardTraderClient.uploadProductImageFromUrl(
          id: 789000,
          imageUrl: 'https://example.com/card.jpg',
        );

        final captured = verify(
          () => httpClient.post(
            captureAny(),
            headers: any(named: 'headers'),
            body: captureAny(named: 'body'),
          ),
        ).captured;

        final uri = captured[0] as Uri;
        expect(uri.path, contains('/products/789000/upload_image'));

        final body = jsonDecode(captured[1] as String);
        expect(
          body['uploaded_image']['remote_image_url'],
          'https://example.com/card.jpg',
        );
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(422);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.uploadProductImageFromUrl(
            id: 789000,
            imageUrl: 'https://example.com/card.jpg',
          ),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('removeProductImage', () {
      test('should remove product image successfully', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn('');
        when(
          () => httpClient.delete(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.removeProductImage(789000);

        final captured = verify(
          () => httpClient.delete(captureAny(), headers: any(named: 'headers')),
        ).captured;

        final uri = captured[0] as Uri;
        expect(uri.path, contains('/products/789000/upload_image'));
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(404);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.delete(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.removeProductImage(999),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    // ========== ORDER MANAGEMENT ==========

    group('getOrders', () {
      test('should return paginated list of orders on success', () async {
        final file = File('test/fixtures/get_orders.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        final result = await cardTraderClient.getOrders();

        expect(result, isA<PaginatedResponse<Order>>());
        expect(result.items.length, 2);
        expect(result.items.first.id, 733733);
        expect(result.items.first.code, '202109213e70f5');
        expect(result.items.first.state, 'hub_pending');
        expect(result.items.first.isHubPending, true);
        expect(result.items.first.viaCardtraderZero, true);
        expect(result.items.first.orderAs, 'seller');
        expect(result.items.first.buyer, isNotNull);
        expect(result.items.first.buyer!.username, 'buyer_user');
        expect(result.items.first.orderItems.length, 1);
        expect(result.items.first.orderItems.first.name, 'Celestial Cataclysm');
        expect(result.items.first.orderShippingMethod, isNotNull);
        expect(result.items.first.orderShippingMethod!.name, 'Priority Letter');
      });

      test('should pass all query parameters', () async {
        final file = File('test/fixtures/get_orders.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.getOrders(
          page: 2,
          limit: 50,
          from: '2021-01-01',
          to: '2021-12-31',
          fromId: 100,
          toId: 999,
          state: 'paid',
          orderAs: 'seller',
          sort: 'date.desc',
        );

        final captured = verify(
          () => httpClient.get(captureAny(), headers: any(named: 'headers')),
        ).captured;

        final uri = captured.first as Uri;
        expect(uri.path, contains('/orders'));
        expect(uri.queryParameters['page'], '2');
        expect(uri.queryParameters['limit'], '50');
        expect(uri.queryParameters['from'], '2021-01-01');
        expect(uri.queryParameters['to'], '2021-12-31');
        expect(uri.queryParameters['from_id'], '100');
        expect(uri.queryParameters['to_id'], '999');
        expect(uri.queryParameters['state'], 'paid');
        expect(uri.queryParameters['order_as'], 'seller');
        expect(uri.queryParameters['sort'], 'date.desc');
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(400);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.getOrders(),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('getOrder', () {
      test('should return order details on success', () async {
        final file = File('test/fixtures/get_order.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        final order = await cardTraderClient.getOrder(733733);

        expect(order, isA<Order>());
        expect(order.id, 733733);
        expect(order.code, '202109213e70f5');
        expect(order.viaCardtraderZero, true);
        expect(order.state, 'hub_pending');
        expect(order.size, 1);
        expect(order.orderShippingAddress, isNotNull);
        expect(order.orderShippingAddress!.city, 'Firenze');
        expect(order.orderBillingAddress, isNotNull);
        expect(order.sellerTotal, isNotNull);
        expect(order.sellerTotal!.cents, 1500);
        expect(order.feePercentage, '5.0');
        expect(order.packingNumber, 11);
        expect(order.orderItems.length, 1);
        expect(order.orderItems.first.sellerPrice, isNotNull);
        expect(order.orderItems.first.sellerPrice!.cents, 1500);
      });

      test('should call /orders/:id endpoint', () async {
        final file = File('test/fixtures/get_order.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.getOrder(733733);

        final captured = verify(
          () => httpClient.get(captureAny(), headers: any(named: 'headers')),
        ).captured;

        final uri = captured.first as Uri;
        expect(uri.path, contains('/orders/733733'));
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(404);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.getOrder(999999),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('setOrderTrackingCode', () {
      test('should return updated order on success', () async {
        final file = File('test/fixtures/ship_order.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final order = await cardTraderClient.setOrderTrackingCode(
          id: 733733,
          trackingCode: 'ABC123XYZ',
        );

        expect(order, isA<Order>());
        expect(order.id, 733733);
      });

      test('should send tracking_code in body', () async {
        final file = File('test/fixtures/ship_order.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.setOrderTrackingCode(
          id: 733733,
          trackingCode: 'ABC123XYZ',
        );

        final captured = verify(
          () => httpClient.put(
            captureAny(),
            headers: any(named: 'headers'),
            body: captureAny(named: 'body'),
          ),
        ).captured;

        final uri = captured[0] as Uri;
        expect(uri.path, contains('/orders/733733/tracking_code'));

        final body = jsonDecode(captured[1] as String);
        expect(body['tracking_code'], 'ABC123XYZ');
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(422);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.setOrderTrackingCode(
            id: 999999,
            trackingCode: 'ABC',
          ),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('shipOrder', () {
      test('should return updated order on success', () async {
        final file = File('test/fixtures/ship_order.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final order = await cardTraderClient.shipOrder(733733);

        expect(order, isA<Order>());
        expect(order.id, 733733);
        expect(order.state, 'sent');
        expect(order.isSent, true);
        expect(order.sentAt, isNotNull);
      });

      test('should call /orders/:id/ship endpoint', () async {
        final file = File('test/fixtures/ship_order.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.shipOrder(733733);

        final captured = verify(
          () => httpClient.put(
            captureAny(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).captured;

        final uri = captured[0] as Uri;
        expect(uri.path, contains('/orders/733733/ship'));
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(422);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.shipOrder(999999),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('requestOrderCancellation', () {
      test('should return updated order on success', () async {
        final file = File('test/fixtures/request_cancellation.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final order = await cardTraderClient.requestOrderCancellation(
          id: 733733,
          cancelExplanation:
              'The item is no longer available in my inventory, I apologize for the inconvenience.',
        );

        expect(order, isA<Order>());
        expect(order.id, 733733);
        expect(order.state, 'request_for_cancel');
        expect(order.isRequestForCancel, true);
        expect(order.cancelRequester, isNotNull);
      });

      test('should send body with cancel_explanation and relist flag', () async {
        final file = File('test/fixtures/request_cancellation.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.requestOrderCancellation(
          id: 733733,
          cancelExplanation:
              'The item is no longer available in my inventory, I apologize for the inconvenience.',
          relistIfCancelled: true,
        );

        final captured = verify(
          () => httpClient.put(
            captureAny(),
            headers: any(named: 'headers'),
            body: captureAny(named: 'body'),
          ),
        ).captured;

        final uri = captured[0] as Uri;
        expect(uri.path, contains('/orders/733733/request-cancellation'));

        final body = jsonDecode(captured[1] as String);
        expect(body['cancel_explanation'], contains('no longer available'));
        expect(body['relist_if_cancelled'], true);
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(422);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.requestOrderCancellation(
            id: 999999,
            cancelExplanation: 'Too short',
          ),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('confirmOrderCancellation', () {
      test('should return updated order on success', () async {
        final file = File('test/fixtures/confirm_cancellation.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final order = await cardTraderClient.confirmOrderCancellation(
          id: 733733,
        );

        expect(order, isA<Order>());
        expect(order.id, 733733);
        expect(order.state, 'canceled');
        expect(order.isCanceled, true);
        expect(order.cancelledAt, isNotNull);
      });

      test('should send relist_if_cancelled when provided', () async {
        final file = File('test/fixtures/confirm_cancellation.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.confirmOrderCancellation(
          id: 733733,
          relistIfCancelled: true,
        );

        final captured = verify(
          () => httpClient.put(
            captureAny(),
            headers: any(named: 'headers'),
            body: captureAny(named: 'body'),
          ),
        ).captured;

        final uri = captured[0] as Uri;
        expect(uri.path, contains('/orders/733733/confirm-cancellation'));

        final body = jsonDecode(captured[1] as String);
        expect(body['relist_if_cancelled'], true);
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(422);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.confirmOrderCancellation(id: 999999),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    // ========== CT0 BOX ITEMS ==========

    group('getCt0BoxItems', () {
      test('should return list of CT0 box items on success', () async {
        final file = File('test/fixtures/get_ct0_box_items.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        final items = await cardTraderClient.getCt0BoxItems();

        expect(items, isA<List<Ct0BoxItem>>());
        expect(items.length, 2);
        expect(items.first.id, 1917020);
        expect(items.first.name, 'Deathcap Cultivator');
        expect(items.first.pendingQuantity, 1);
        expect(items.first.okQuantity, 0);
        expect(items.first.seller.username, 'CardShop');
        expect(items.first.buyerPrice.cents, 8);
        expect(items[1].okQuantity, 2);
        expect(items[1].arrivedAt, isNotNull);
      });

      test('should call /ct0_box_items endpoint', () async {
        final file = File('test/fixtures/get_ct0_box_items.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.getCt0BoxItems();

        final captured = verify(
          () => httpClient.get(captureAny(), headers: any(named: 'headers')),
        ).captured;

        final uri = captured.first as Uri;
        expect(uri.path, contains('/ct0_box_items'));
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(400);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.getCt0BoxItems(),
          throwsA(isA<CardTraderException>()),
        );
      });
    });

    group('getCt0BoxItem', () {
      test('should return CT0 box item details on success', () async {
        final file = File('test/fixtures/get_ct0_box_item.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        final item = await cardTraderClient.getCt0BoxItem(1917020);

        expect(item, isA<Ct0BoxItem>());
        expect(item.id, 1917020);
        expect(item.name, 'Deathcap Cultivator');
        expect(item.expansion, 'Shadows over Innistrad');
        expect(item.pendingQuantity, 1);
        expect(item.buyerPrice.cents, 8);
        expect(item.formattedPrice, '€0.08');
        expect(item.scryfallId, 'fc4aee46-ac42-4ede-ad06-906e2955a9d3');
      });

      test('should call /ct0_box_items/:id endpoint', () async {
        final file = File('test/fixtures/get_ct0_box_item.json');
        final jsonContent = await file.readAsString();

        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(jsonContent);
        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await cardTraderClient.getCt0BoxItem(1917020);

        final captured = verify(
          () => httpClient.get(captureAny(), headers: any(named: 'headers')),
        ).captured;

        final uri = captured.first as Uri;
        expect(uri.path, contains('/ct0_box_items/1917020'));
      });

      test('should throw CardTraderException on error', () async {
        final mockResponse = MockResponse();
        when(() => mockResponse.statusCode).thenReturn(404);
        when(() => mockResponse.body).thenReturn(jsonError);

        when(
          () => httpClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => mockResponse);

        await expectLater(
          cardTraderClient.getCt0BoxItem(999999),
          throwsA(isA<CardTraderException>()),
        );
      });
    });
  });
}
