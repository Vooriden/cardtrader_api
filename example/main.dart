import 'dart:io';

import 'package:cardtrader_api/cardtrader_api.dart';
import 'package:dotenv/dotenv.dart';

/// Example usage of the CardTrader API client.
///
/// You can set the API key either via:
/// 1. A `.env` file in the project root with `CARDTRADER_API_KEY=your_key`
/// 2. An environment variable: `export CARDTRADER_API_KEY=your_key`
///
/// Run with:
/// ```bash
/// dart run example/main.dart
/// ```
void main() async {
  // Load .env file if it exists
  final env = DotEnv(includePlatformEnvironment: true)..load();

  final apiKey = env['CARDTRADER_API_KEY'];

  if (apiKey == null || apiKey.isEmpty) {
    print('Error: CARDTRADER_API_KEY is not set.');
    print('Set it via .env file or environment variable.');
    print(
      'Usage: export CARDTRADER_API_KEY=your_api_key && dart run example/main.dart',
    );
    exit(1);
  }

  final client = CardTraderClient(apiKey: apiKey);

  try {
    // ========== GET INFO ==========
    print('=== App Info ===');
    final info = await client.getInfo();
    print('App ID: ${info.id}');
    print('App Name: ${info.name}');
    print('User ID: ${info.userId}');
    print('');

    // ========== GET GAMES ==========
    print('=== Games ===');
    final games = await client.getGames();
    for (final game in games.array) {
      print('- ${game.displayName} (ID: ${game.id})');
    }
    print('');

    // ========== GET CATEGORIES ==========
    print('=== Categories (first game) ===');
    if (games.array.isNotEmpty) {
      final firstGameId = games.array.first.id;
      final categories = await client.getCategories(gameId: firstGameId);
      for (final category in categories.take(5)) {
        print('- ${category.name} (ID: ${category.id})');
        if (category.properties.isNotEmpty) {
          print(
            '  Properties: ${category.properties.map((p) => p.name).join(', ')}',
          );
        }
      }
      if (categories.length > 5) {
        print('  ... and ${categories.length - 5} more categories');
      }
    }
    print('');

    // ========== GET EXPANSIONS ==========
    print('=== Expansions ===');
    final expansions = await client.getExpansions();
    for (final expansion in expansions.take(5)) {
      print('- ${expansion.name} [${expansion.code}] (ID: ${expansion.id})');
    }
    if (expansions.length > 5) {
      print('  ... and ${expansions.length - 5} more expansions');
    }
    print('');

    // ========== GET MY EXPANSIONS ==========
    print('=== My Expansions (from inventory) ===');
    final myExpansions = await client.getMyExpansions();
    if (myExpansions.isEmpty) {
      print('No expansions in your inventory.');
    } else {
      for (final expansion in myExpansions.take(5)) {
        print('- ${expansion.name} [${expansion.code}]');
      }
      if (myExpansions.length > 5) {
        print('  ... and ${myExpansions.length - 5} more expansions');
      }
    }

    print('');
    print('Done!');
  } on CardTraderException catch (e) {
    print('CardTrader API Error: ${e.errorCode}');
    print('Request ID: ${e.requestId}');
    print('Status Code: ${e.statusCode}');
    print('Extra: ${e.extra}');
    exit(1);
  } catch (e) {
    print('Unexpected error: $e');
    exit(1);
  } finally {
    client.close();
  }
}
