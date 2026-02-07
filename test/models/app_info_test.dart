import 'package:cardtrader_api/src/models/app_info.dart';
import 'package:test/test.dart';

void main() {
  group('AppInfo', () {
    final json = {
      "id": 3,
      "name": "Test App",
      "shared_secret": "some-secret-key",
      "user_id": 12345,
    };

    group('fromJson', () {
      test('parses JSON correctly with all fields', () {
        final appInfo = AppInfo.fromJson(json);

        expect(
          appInfo,
          isA<AppInfo>()
              .having((a) => a.id, 'id', 3)
              .having((a) => a.name, 'name', 'Test App')
              .having((a) => a.sharedSecret, 'sharedSecret', 'some-secret-key')
              .having((a) => a.userId, 'userId', 12345),
        );
      });
    });

    group('toJson', () {
      test('converts to JSON correctly with all fields', () {
        final appInfo = AppInfo.fromJson(json);
        final jsonOutput = appInfo.toJson();

        expect(jsonOutput, {
          'id': 3,
          'name': 'Test App',
          'shared_secret': 'some-secret-key',
          'user_id': 12345,
        });
      });
    });

    group('constructor', () {
      test('creates instance with all fields', () {
        final appInfo = AppInfo(
          id: 3,
          name: 'Test App',
          sharedSecret: 'some-secret-key',
          userId: 12345,
        );

        expect(appInfo.id, 3);
        expect(appInfo.name, 'Test App');
        expect(appInfo.sharedSecret, 'some-secret-key');
        expect(appInfo.userId, 12345);
      });
    });
  });
}
