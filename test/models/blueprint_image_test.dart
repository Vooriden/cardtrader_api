import 'package:cardtrader_api/src/models/blueprint_image.dart';
import 'package:test/test.dart';

void main() {
  group('BlueprintImageVariant', () {
    final json = {"url": "/uploads/blueprints/image/123/show_card.jpg"};

    group('fromJson', () {
      test('parses JSON correctly', () {
        final variant = BlueprintImageVariant.fromJson(json);

        expect(variant.url, '/uploads/blueprints/image/123/show_card.jpg');
      });
    });

    group('toJson', () {
      test('converts to JSON correctly', () {
        final variant = BlueprintImageVariant.fromJson(json);
        final jsonOutput = variant.toJson();

        expect(
          jsonOutput['url'],
          '/uploads/blueprints/image/123/show_card.jpg',
        );
      });
    });
  });

  group('BlueprintImage', () {
    final json = {
      "url": "/uploads/blueprints/image/293286/flareon-gx.jpg",
      "show": {"url": "/uploads/blueprints/image/293286/show_flareon-gx.jpg"},
      "preview": {
        "url": "/uploads/blueprints/image/293286/preview_flareon-gx.jpg",
      },
      "social": {
        "url": "/uploads/blueprints/image/293286/social_flareon-gx.jpg",
      },
    };

    group('fromJson', () {
      test('parses JSON correctly with all variants', () {
        final image = BlueprintImage.fromJson(json);

        expect(image.url, '/uploads/blueprints/image/293286/flareon-gx.jpg');
        expect(image.show, isNotNull);
        expect(
          image.show!.url,
          '/uploads/blueprints/image/293286/show_flareon-gx.jpg',
        );
        expect(image.preview, isNotNull);
        expect(
          image.preview!.url,
          '/uploads/blueprints/image/293286/preview_flareon-gx.jpg',
        );
        expect(image.social, isNotNull);
        expect(
          image.social!.url,
          '/uploads/blueprints/image/293286/social_flareon-gx.jpg',
        );
      });

      test('parses JSON with null variants', () {
        final jsonMinimal = {"url": "/uploads/image.jpg"};

        final image = BlueprintImage.fromJson(jsonMinimal);

        expect(image.url, '/uploads/image.jpg');
        expect(image.show, isNull);
        expect(image.preview, isNull);
        expect(image.social, isNull);
      });
    });

    group('toJson', () {
      test('converts to JSON correctly', () {
        final image = BlueprintImage.fromJson(json);
        final jsonOutput = image.toJson();

        expect(
          jsonOutput['url'],
          '/uploads/blueprints/image/293286/flareon-gx.jpg',
        );
        expect(jsonOutput['show'], isMap);
        expect(jsonOutput['preview'], isMap);
        expect(jsonOutput['social'], isMap);
      });
    });

    group('constructor', () {
      test('creates instance with all fields', () {
        final image = BlueprintImage(
          url: '/image.jpg',
          show: BlueprintImageVariant(url: '/show.jpg'),
          preview: BlueprintImageVariant(url: '/preview.jpg'),
          social: BlueprintImageVariant(url: '/social.jpg'),
        );

        expect(image.url, '/image.jpg');
        expect(image.show!.url, '/show.jpg');
        expect(image.preview!.url, '/preview.jpg');
        expect(image.social!.url, '/social.jpg');
      });

      test('creates instance with only required url', () {
        final image = BlueprintImage(url: '/image.jpg');

        expect(image.url, '/image.jpg');
        expect(image.show, isNull);
        expect(image.preview, isNull);
        expect(image.social, isNull);
      });
    });
  });
}
