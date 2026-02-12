import 'package:cardtrader_api/src/models/expansion.dart';
import 'package:test/test.dart';

void main() {
  group('Expansion', () {
    final json = {"id": 123, "game_id": 1, "code": "dom", "name": "Dominaria"};

    group('fromJson', () {
      test('parses JSON correctly with all fields', () {
        final expansion = Expansion.fromJson(json);

        expect(
          expansion,
          isA<Expansion>()
              .having((e) => e.id, 'id', 123)
              .having((e) => e.gameId, 'gameId', 1)
              .having((e) => e.code, 'code', 'dom')
              .having((e) => e.name, 'name', 'Dominaria'),
        );
      });

      test('parses JSON with name_en (marketplace format)', () {
        final jsonMarketplace = {
          "id": 34,
          "code": "pust",
          "name_en": "Unstable Promos",
        };

        final expansion = Expansion.fromJson(jsonMarketplace);

        expect(expansion.id, 34);
        expect(expansion.code, 'pust');
        expect(expansion.nameEn, 'Unstable Promos');
        expect(expansion.gameId, isNull);
        expect(expansion.name, isNull);
      });

      test('displayName prefers name over nameEn', () {
        final expansion = Expansion(
          id: 1,
          code: 'test',
          name: 'Test Name',
          nameEn: 'Test Name En',
        );

        expect(expansion.displayName, 'Test Name');
      });

      test('displayName falls back to nameEn', () {
        final expansion = Expansion(
          id: 1,
          code: 'test',
          nameEn: 'Test Name En',
        );

        expect(expansion.displayName, 'Test Name En');
      });
    });

    group('toJson', () {
      test('converts to JSON correctly with all fields', () {
        final expansion = Expansion.fromJson(json);
        final jsonOutput = expansion.toJson();

        expect(jsonOutput['id'], 123);
        expect(jsonOutput['game_id'], 1);
        expect(jsonOutput['code'], 'dom');
        expect(jsonOutput['name'], 'Dominaria');
      });
    });

    group('constructor', () {
      test('creates instance with all fields', () {
        final expansion = Expansion(
          id: 123,
          gameId: 1,
          code: 'dom',
          name: 'Dominaria',
        );

        expect(expansion.id, 123);
        expect(expansion.gameId, 1);
        expect(expansion.code, 'dom');
        expect(expansion.name, 'Dominaria');
      });

      test('creates instance with optional fields null', () {
        final expansion = Expansion(id: 1, code: 'test');

        expect(expansion.gameId, isNull);
        expect(expansion.name, isNull);
        expect(expansion.nameEn, isNull);
      });
    });
  });
}
