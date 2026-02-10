import 'dart:convert';

import 'package:cardtrader_api/src/models/models.dart';
import 'package:http/http.dart' as http;

/// {@template card_trader_client}
/// Dart client for CardTrader API
///
/// For more information, see: https://www.cardtrader.com/en/docs/api
/// {@endtemplate}
class CardTraderClient {
  static const _baseUrl = "https://api.cardtrader.com/api/v2";
  final http.Client _httpClient;
  final String _apiKey;

  /// {@macro card_trader_client}
  ///
  /// Creates a [CardTraderClient] with the given [apiKey] and optional [httpClient].
  CardTraderClient({http.Client? httpClient, required String apiKey})
    : _httpClient = httpClient ?? http.Client(),
      _apiKey = apiKey;

  /// Closes the underlying [http.Client].
  ///
  /// Should be called when the client is no longer needed
  /// to free up resources.
  ///
  /// If any requests are made after calling this method,
  /// an [http.ClientException] will be thrown.
  void close() {
    _httpClient.close();
  }

  // ========== APP INFO ==========

  /// **GET**  /info
  ///
  /// Test authentication and get [AppInfo] object.
  ///
  /// Example response:
  /// ```json
  /// {
  ///   "id": 123,
  ///   "name": "My App",
  ///   "shared_secret": "abc123",
  ///   "user_id": 456
  /// }
  /// ```
  Future<AppInfo> getInfo() async {
    final response = await _get('/info');

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(json, response.statusCode);
    }

    return AppInfo.fromJson(json);
  }

  // ========== GAMES ==========

  /// **GET**  /games
  ///
  /// Retrieves the list of games.
  ///
  /// Example response:
  /// ```json
  /// {
  ///   "array": [
  ///     {
  ///       "id": 1,
  ///       "display_name": "Magic: the Gathering",
  ///       "name": "Magic"
  ///     }
  ///   ]
  /// }
  /// ```
  Future<GameList> getGames() async {
    final response = await _get('/games');
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(json, response.statusCode);
    }

    return GameList.fromJson(json);
  }

  // ========== CATEGORIES ==========

  /// **GET**  /categories
  ///
  /// Retrieves the list of categories for products.
  ///
  /// Categories are used to organize products by type within a game,
  /// such as "Single Cards", "Sealed Products", "Accessories", etc.
  ///
  /// [gameId] - Optional filter by game ID to get categories for a specific game.
  ///
  /// Example response:
  /// ```json
  /// [
  ///   {
  ///     "id": 1,
  ///     "name": "Single Cards",
  ///     "game_id": 1,
  ///     "properties": [
  ///       {
  ///         "name": "condition",
  ///         "type": "string",
  ///         "possible_values": ["Near Mint", "Excellent", "Good", "Poor"]
  ///       }
  ///     ]
  ///   }
  /// ]
  /// ```
  Future<List<Category>> getCategories({int? gameId}) async {
    final queryParameters = gameId != null
        ? {'game_id': gameId.toString()}
        : null;

    final response = await _get(
      '/categories',
      queryParameters: queryParameters,
    );
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return (json as List<dynamic>)
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ========== PRIVATE METHODS ==========

  Future<http.Response> _get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint').replace(
      queryParameters: {if (queryParameters != null) ...queryParameters},
    );

    final headers = <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $_apiKey',
    };

    final response = await _httpClient.get(uri, headers: headers);
    return response;
  }
}
