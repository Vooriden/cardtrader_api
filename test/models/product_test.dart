import 'package:cardtrader_api/src/models/product.dart';
import 'package:test/test.dart';

void main() {
  group('Product', () {
    // Export format (GET /products/export)
    final exportJson = {
      'id': 123456,
      'name_en': 'Lightning Bolt',
      'quantity': 3,
      'description': 'Near Mint condition',
      'price_cents': 500,
      'price_currency': 'EUR',
      'game_id': 1,
      'category_id': 1,
      'blueprint_id': 39063,
      'properties_hash': {'condition': 'Near Mint', 'mtg_language': 'en'},
      'user_id': 456,
      'graded': false,
      'tag': 'sale',
      'user_data_field': 'SKU-001',
      'bundle_size': 2,
      'bundled_quantity': 6,
      'uploaded_images': ['https://example.com/image1.jpg'],
    };

    // Resource format (create/update/increment/delete responses)
    final resourceJson = {
      'id': 789000,
      'quantity': 2,
      'bundle_size': 1,
      'description': 'Fresh pack',
      'graded': 0,
      'game_id': 1,
      'category_id': 1,
      'expansion_id': 404,
      'blueprint_id': 39063,
      'price': {'cents': 450, 'currency': 'EUR'},
      'properties': {'condition': 'Near Mint'},
    };

    group('fromJson (export format)', () {
      test('parses export JSON correctly with all fields', () {
        final product = Product.fromJson(exportJson);

        expect(
          product,
          isA<Product>()
              .having((p) => p.id, 'id', 123456)
              .having((p) => p.nameEn, 'nameEn', 'Lightning Bolt')
              .having((p) => p.quantity, 'quantity', 3)
              .having(
                (p) => p.description,
                'description',
                'Near Mint condition',
              )
              .having((p) => p.priceCents, 'priceCents', 500)
              .having((p) => p.priceCurrency, 'priceCurrency', 'EUR')
              .having((p) => p.gameId, 'gameId', 1)
              .having((p) => p.categoryId, 'categoryId', 1)
              .having((p) => p.blueprintId, 'blueprintId', 39063)
              .having((p) => p.expansionId, 'expansionId', isNull)
              .having((p) => p.propertiesHash, 'propertiesHash', {
                'condition': 'Near Mint',
                'mtg_language': 'en',
              })
              .having((p) => p.userId, 'userId', 456)
              .having((p) => p.graded, 'graded', false)
              .having((p) => p.tag, 'tag', 'sale')
              .having((p) => p.userDataField, 'userDataField', 'SKU-001')
              .having((p) => p.bundleSize, 'bundleSize', 2)
              .having((p) => p.bundledQuantity, 'bundledQuantity', 6)
              .having((p) => p.uploadedImages, 'uploadedImages', [
                'https://example.com/image1.jpg',
              ]),
        );
      });

      test('uses default values when optional fields are missing', () {
        final minimalJson = {
          'id': 1,
          'quantity': 1,
          'price_cents': 100,
          'price_currency': 'EUR',
          'game_id': 1,
          'category_id': 1,
          'blueprint_id': 1000,
        };

        final product = Product.fromJson(minimalJson);

        expect(product.nameEn, isNull);
        expect(product.description, '');
        expect(product.propertiesHash, {});
        expect(product.graded, false);
        expect(product.tag, '');
        expect(product.userDataField, '');
        expect(product.bundleSize, 1);
        expect(product.bundledQuantity, isNull);
        expect(product.userId, isNull);
        expect(product.expansionId, isNull);
        expect(product.uploadedImages, []);
      });
    });

    group('fromJson (resource format)', () {
      test('parses resource JSON correctly', () {
        final product = Product.fromJson(resourceJson);

        expect(
          product,
          isA<Product>()
              .having((p) => p.id, 'id', 789000)
              .having((p) => p.nameEn, 'nameEn', isNull)
              .having((p) => p.quantity, 'quantity', 2)
              .having((p) => p.description, 'description', 'Fresh pack')
              .having((p) => p.priceCents, 'priceCents', 450)
              .having((p) => p.priceCurrency, 'priceCurrency', 'EUR')
              .having((p) => p.gameId, 'gameId', 1)
              .having((p) => p.categoryId, 'categoryId', 1)
              .having((p) => p.blueprintId, 'blueprintId', 39063)
              .having((p) => p.expansionId, 'expansionId', 404)
              .having((p) => p.propertiesHash, 'propertiesHash', {
                'condition': 'Near Mint',
              })
              .having((p) => p.userId, 'userId', isNull)
              .having((p) => p.graded, 'graded', false)
              .having((p) => p.bundledQuantity, 'bundledQuantity', isNull),
        );
      });
    });

    group('graded normalization', () {
      test('normalizes boolean true', () {
        final json = {...resourceJson, 'graded': true};
        expect(Product.fromJson(json).graded, true);
      });

      test('normalizes boolean false', () {
        final json = {...resourceJson, 'graded': false};
        expect(Product.fromJson(json).graded, false);
      });

      test('normalizes integer 0 to false', () {
        final json = {...resourceJson, 'graded': 0};
        expect(Product.fromJson(json).graded, false);
      });

      test('normalizes integer 1 to true', () {
        final json = {...resourceJson, 'graded': 1};
        expect(Product.fromJson(json).graded, true);
      });

      test('normalizes string "true" to true', () {
        final json = {...resourceJson, 'graded': 'true'};
        expect(Product.fromJson(json).graded, true);
      });

      test('normalizes string "false" to false', () {
        final json = {...resourceJson, 'graded': 'false'};
        expect(Product.fromJson(json).graded, false);
      });

      test('normalizes string "0" to false', () {
        final json = {...resourceJson, 'graded': '0'};
        expect(Product.fromJson(json).graded, false);
      });

      test('normalizes empty string to false', () {
        final json = {...resourceJson, 'graded': ''};
        expect(Product.fromJson(json).graded, false);
      });
    });

    group('toJson', () {
      test('converts export format to JSON correctly', () {
        final product = Product.fromJson(exportJson);
        final jsonOutput = product.toJson();

        expect(jsonOutput['id'], 123456);
        expect(jsonOutput['name_en'], 'Lightning Bolt');
        expect(jsonOutput['quantity'], 3);
        expect(jsonOutput['price_cents'], 500);
        expect(jsonOutput['price_currency'], 'EUR');
        expect(jsonOutput['blueprint_id'], 39063);
        expect(jsonOutput['game_id'], 1);
        expect(jsonOutput['category_id'], 1);
        expect(jsonOutput['user_id'], 456);
        expect(jsonOutput['graded'], false);
        expect(jsonOutput['tag'], 'sale');
        expect(jsonOutput['user_data_field'], 'SKU-001');
        expect(jsonOutput['bundle_size'], 2);
        expect(jsonOutput['bundled_quantity'], 6);
        expect(jsonOutput['uploaded_images'], [
          'https://example.com/image1.jpg',
        ]);
      });

      test('omits null fields', () {
        final product = Product.fromJson(resourceJson);
        final jsonOutput = product.toJson();

        expect(jsonOutput.containsKey('name_en'), false);
        expect(jsonOutput.containsKey('user_id'), false);
        expect(jsonOutput.containsKey('bundled_quantity'), false);
        expect(jsonOutput['expansion_id'], 404);
      });
    });

    group('price getter', () {
      test('returns price as double from cents (export format)', () {
        final product = Product.fromJson(exportJson);

        expect(product.price, 5.0);
      });

      test('returns price as double from cents (resource format)', () {
        final product = Product.fromJson(resourceJson);

        expect(product.price, 4.5);
      });

      test('returns correct price for fractional cents', () {
        final priceJson = Map<String, dynamic>.from(exportJson);
        priceJson['price_cents'] = 1299;

        final product = Product.fromJson(priceJson);

        expect(product.price, 12.99);
      });
    });

    group('constructor', () {
      test('creates instance with all fields', () {
        final product = Product(
          id: 1,
          nameEn: 'Test',
          quantity: 1,
          description: 'desc',
          priceCents: 100,
          priceCurrency: 'USD',
          gameId: 1,
          categoryId: 1,
          blueprintId: 100,
          propertiesHash: {},
          userId: 1,
          graded: false,
          tag: '',
          userDataField: '',
          bundleSize: 1,
          bundledQuantity: 1,
          uploadedImages: [],
        );

        expect(product.id, 1);
        expect(product.nameEn, 'Test');
        expect(product.priceCurrency, 'USD');
      });

      test('creates instance without nullable fields', () {
        final product = Product(
          id: 1,
          quantity: 1,
          description: 'desc',
          priceCents: 100,
          priceCurrency: 'USD',
          gameId: 1,
          categoryId: 1,
          blueprintId: 100,
          propertiesHash: {},
          graded: false,
          tag: '',
          userDataField: '',
          bundleSize: 1,
          uploadedImages: [],
        );

        expect(product.id, 1);
        expect(product.nameEn, isNull);
        expect(product.userId, isNull);
        expect(product.expansionId, isNull);
        expect(product.bundledQuantity, isNull);
      });
    });
  });
}
