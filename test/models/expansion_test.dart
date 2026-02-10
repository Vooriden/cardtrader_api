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
    });

    group('toJson', () {
      test('converts to JSON correctly with all fields', () {
        final expansion = Expansion.fromJson(json);
        final jsonOutput = expansion.toJson();

        expect(jsonOutput, {
          'id': 123,
          'game_id': 1,
          'code': 'dom',
          'name': 'Dominaria',
        });
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
    });
  });
}
