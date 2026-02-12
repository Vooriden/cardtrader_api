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

  // ========== EXPANSIONS ==========

  /// **GET**  /expansions
  ///
  /// Retrieves the list of all expansions.
  ///
  /// Expansions are collections of products released together,
  /// such as "Dominaria" or "Core Set 2021" in Magic: the Gathering.
  ///
  /// Example response:
  /// ```json
  /// [
  ///   {
  ///     "id": 20,
  ///     "game_id": 1,
  ///     "code": "dom",
  ///     "name": "Dominaria"
  ///   }
  /// ]
  /// ```
  Future<List<Expansion>> getExpansions() async {
    final response = await _get('/expansions');
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return (json as List<dynamic>)
        .map((e) => Expansion.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// **GET**  /expansions/export
  ///
  /// Retrieves the list of expansions that you have in your inventory.
  ///
  /// This returns only expansions where you have products listed.
  ///
  /// Example response:
  /// ```json
  /// [
  ///   {
  ///     "id": 123,
  ///     "game_id": 1,
  ///     "code": "dom",
  ///     "name": "Dominaria"
  ///   }
  /// ]
  /// ```
  Future<List<Expansion>> getMyExpansions() async {
    final response = await _get('/expansions/export');
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return (json as List<dynamic>)
        .map((e) => Expansion.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ========== BLUEPRINTS ==========

  /// **GET**  /blueprints/export
  ///
  /// Retrieves blueprints for a specific expansion.
  ///
  /// Blueprints define the basic information about a card or product,
  /// including its name, associated expansion, category, and editable properties.
  ///
  /// [expansionId] - Required expansion ID to get blueprints for.
  ///
  /// Example response:
  /// ```json
  /// [
  ///   {
  ///     "id": 39063,
  ///     "name": "Lightning Bolt",
  ///     "version": null,
  ///     "game_id": 1,
  ///     "category_id": 1,
  ///     "expansion_id": 404,
  ///     "fixed_properties": {
  ///       "mtg_rarity": "Common",
  ///       "collector_number": "161"
  ///     },
  ///     "editable_properties": [
  ///       {
  ///         "name": "condition",
  ///         "type": "string",
  ///         "default_value": "Near Mint",
  ///         "possible_values": [
  ///           "Near Mint",
  ///           "Slightly Played",
  ///           "Moderately Played",
  ///           "Played",
  ///           "Poor"
  ///         ]
  ///       },
  ///       {
  ///         "name": "signed",
  ///         "type": "boolean",
  ///         "default_value": "false",
  ///         "possible_values": [true, false]
  ///       },
  ///       {
  ///         "name": "altered",
  ///         "type": "boolean",
  ///         "default_value": "false",
  ///         "possible_values": [true, false]
  ///       }
  ///     ],
  ///     "card_market_ids": [5395],
  ///     "tcg_player_id": 1174,
  ///     "scryfall_id": "d573ef03-4730-45aa-93dd-e45ac1dbaf4a",
  ///     "image_url": "https://cardtrader.com/uploads/blueprints/image/39063/preview_lightning-bolt-limited-edition-alpha.jpg",
  ///     "image": {
  ///       "url": "/uploads/blueprints/image/39063/lightning-bolt-limited-edition-alpha.jpg",
  ///       "show": {
  ///         "url": "/uploads/blueprints/image/39063/show_lightning-bolt-limited-edition-alpha.jpg"
  ///       },
  ///       "preview": {
  ///         "url": "/uploads/blueprints/image/39063/preview_lightning-bolt-limited-edition-alpha.jpg"
  ///       },
  ///       "social": {
  ///         "url": "/uploads/blueprints/image/39063/social_lightning-bolt-limited-edition-alpha.jpg"
  ///       }
  ///     },
  ///     "back_image": null
  ///   }
  /// ]
  /// ```
  Future<List<Blueprint>> getBlueprintsByExpansion(int expansionId) async {
    final response = await _get(
      '/blueprints/export',
      queryParameters: {'expansion_id': expansionId.toString()},
    );
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return (json as List<dynamic>)
        .map((e) => Blueprint.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ========== MARKETPLACE ==========

  /// **GET**  /marketplace/products
  ///
  /// Retrieves marketplace products by expansion or blueprint.
  ///
  /// At least one of [expansionId] or [blueprintId] is required.
  /// Returns a map where keys are blueprint IDs (as strings)
  /// and values are lists of products for that blueprint.
  ///
  /// [expansionId] - Filter products by expansion ID.
  /// [blueprintId] - Filter products by blueprint ID.
  /// [foil] - Optional filter for foil products.
  /// [language] - Optional filter by language (2-letter code like 'en', 'it').
  ///
  /// Example response:
  /// ```json
  /// {
  ///   "3138": [
  ///     {
  ///       "id": 302179007,
  ///       "blueprint_id": 3138,
  ///       "name_en": "Earl of Squirrel",
  ///       "expansion": {
  ///         "code": "pust",
  ///         "id": 34,
  ///         "name_en": "Unstable Promos"
  ///       },
  ///       "price_cents": 20,
  ///       "price_currency": "EUR",
  ///       "quantity": 1,
  ///       "description": "",
  ///       "properties_hash": {
  ///         "condition": "Near Mint",
  ///         "mtg_foil": true,
  ///         "mtg_language": "it"
  ///       },
  ///       "graded": false,
  ///       "on_vacation": false,
  ///       "user": {
  ///         "id": 7343,
  ///         "username": "Astaroth",
  ///         "country_code": "IT",
  ///         "can_sell_via_hub": false
  ///       },
  ///       "price": {
  ///         "cents": 20,
  ///         "currency": "EUR",
  ///         "currency_symbol": "€",
  ///         "formatted": "€0.20"
  ///       }
  ///     }
  ///   ]
  /// }
  /// ```
  Future<Map<String, List<MarketplaceProduct>>> getMarketplaceProducts({
    int? expansionId,
    int? blueprintId,
    bool? foil,
    String? language,
  }) async {
    final queryParameters = <String, String>{};
    if (expansionId != null) {
      queryParameters['expansion_id'] = expansionId.toString();
    }
    if (blueprintId != null) {
      queryParameters['blueprint_id'] = blueprintId.toString();
    }
    if (foil != null) {
      queryParameters['foil'] = foil.toString();
    }
    if (language != null) {
      queryParameters['language'] = language;
    }

    final response = await _get(
      '/marketplace/products',
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
    );
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    final data = json as Map<String, dynamic>;
    final result = <String, List<MarketplaceProduct>>{};

    data.forEach((key, value) {
      result[key] = (value as List<dynamic>)
          .map((e) => MarketplaceProduct.fromJson(e as Map<String, dynamic>))
          .toList();
    });

    return result;
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
