import 'package:cardtrader_api/src/models/game.dart';
import 'package:test/test.dart';

void main() {
  group('Game', () {
    final json = {
      "id": 1,
      "display_name": "Magic: the Gathering",
      "name": "Magic",
    };

    group('fromJson', () {
      test('parses JSON correctly with all fields', () {
        final game = Game.fromJson(json);

        expect(
          game,
          isA<Game>()
              .having((g) => g.id, 'id', 1)
              .having((g) => g.name, 'name', 'Magic')
              .having(
                (g) => g.displayName,
                'displayName',
                'Magic: the Gathering',
              ),
        );
      });
    });

    group('toJson', () {
      test('converts to JSON correctly with all fields', () {
        final game = Game.fromJson(json);
        final jsonOutput = game.toJson();

        expect(jsonOutput, {
          'id': 1,
          'name': 'Magic',
          'display_name': 'Magic: the Gathering',
        });
      });
    });

    group('constructor', () {
      test('creates instance with all fields', () {
        final game = Game(
          id: 1,
          name: 'Magic',
          displayName: 'Magic: the Gathering',
        );

        expect(game.id, 1);
        expect(game.name, 'Magic');
        expect(game.displayName, 'Magic: the Gathering');
      });
    });
  });

  group('GameList', () {
    final json = {
      "array": [
        {"id": 1, "display_name": "Magic: the Gathering", "name": "Magic"},
        {"id": 2, "display_name": "Yu-Gi-Oh!", "name": "Yu-Gi-Oh!"},
      ],
    };

    group('fromJson', () {
      test('parses JSON correctly with all fields', () {
        final gameList = GameList.fromJson(json);

        expect(
          gameList,
          isA<GameList>().having((gl) => gl.array.length, 'array length', 2),
        );

        final firstGame = gameList.array[0];
        expect(
          firstGame,
          isA<Game>()
              .having((g) => g.id, 'id', 1)
              .having((g) => g.name, 'name', 'Magic')
              .having(
                (g) => g.displayName,
                'displayName',
                'Magic: the Gathering',
              ),
        );

        final secondGame = gameList.array[1];
        expect(
          secondGame,
          isA<Game>()
              .having((g) => g.id, 'id', 2)
              .having((g) => g.name, 'name', 'Yu-Gi-Oh!')
              .having((g) => g.displayName, 'displayName', 'Yu-Gi-Oh!'),
        );
      });
    });

    group('toJson', () {
      test('converts to JSON correctly with all fields', () {
        final gameList = GameList.fromJson(json);
        final jsonOutput = gameList.toJson();

        expect(jsonOutput, {
          'array': [
            {'id': 1, 'name': 'Magic', 'display_name': 'Magic: the Gathering'},
            {'id': 2, 'name': 'Yu-Gi-Oh!', 'display_name': 'Yu-Gi-Oh!'},
          ],
        });
      });
    });

    group('constructor', () {
      test('creates instance with all fields', () {
        final gameList = GameList(
          array: [
            Game(id: 1, name: 'Magic', displayName: 'Magic: the Gathering'),
            Game(id: 2, name: 'Yu-Gi-Oh!', displayName: 'Yu-Gi-Oh!'),
          ],
        );

        expect(gameList, isA<GameList>());
        expect(gameList.array.length, 2);

        final firstGame = gameList.array[0];
        expect(
          firstGame,
          isA<Game>()
              .having((g) => g.id, 'id', 1)
              .having((g) => g.name, 'name', 'Magic')
              .having(
                (g) => g.displayName,
                'displayName',
                'Magic: the Gathering',
              ),
        );

        final secondGame = gameList.array[1];
        expect(
          secondGame,
          isA<Game>()
              .having((g) => g.id, 'id', 2)
              .having((g) => g.name, 'name', 'Yu-Gi-Oh!')
              .having((g) => g.displayName, 'displayName', 'Yu-Gi-Oh!'),
        );
      });
    });
  });
}
