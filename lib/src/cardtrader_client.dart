import 'dart:convert';
import 'dart:typed_data';

import 'package:cardtrader_api/src/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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
  Future<List<Category>> getCategories({int? gameId}) async {
    final queryParameters =
        gameId != null ? {'game_id': gameId.toString()} : null;

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

  // ========== CART ==========

  /// **GET**  /cart
  ///
  /// Retrieves the current cart status.
  ///
  /// Returns the cart with all subcarts (grouped by seller),
  /// items, totals, fees, and addresses.
  Future<Cart> getCart() async {
    final response = await _get('/cart');
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return Cart.fromJson(json as Map<String, dynamic>);
  }

  /// **POST**  /cart/add
  ///
  /// Adds a product to the cart.
  ///
  /// [productId] - The ID of the product to add.
  /// [quantity] - The quantity to add.
  /// [viaCardtraderZero] - Whether to purchase via CardTrader Zero.
  /// [billingAddress] - Optional billing address.
  /// [shippingAddress] - Optional shipping address.
  ///
  /// Returns the updated cart.
  Future<Cart> addToCart({
    required int productId,
    required int quantity,
    required bool viaCardtraderZero,
    Address? billingAddress,
    Address? shippingAddress,
  }) async {
    final data = <String, dynamic>{
      'product_id': productId,
      'quantity': quantity,
      'via_cardtrader_zero': viaCardtraderZero,
    };

    if (billingAddress != null) {
      data['billing_address'] = billingAddress.toJson();
    }
    if (shippingAddress != null) {
      data['shipping_address'] = shippingAddress.toJson();
    }

    final response = await _post('/cart/add', body: data);
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return Cart.fromJson(json as Map<String, dynamic>);
  }

  /// **POST**  /cart/remove
  ///
  /// Removes a product from the cart.
  ///
  /// [productId] - The ID of the product to remove.
  /// [quantity] - The quantity to remove.
  ///
  /// Returns the updated cart.
  Future<Cart> removeFromCart({
    required int productId,
    required int quantity,
  }) async {
    final response = await _post(
      '/cart/remove',
      body: {'product_id': productId, 'quantity': quantity},
    );
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return Cart.fromJson(json as Map<String, dynamic>);
  }

  /// **POST**  /cart/purchase
  ///
  /// Purchases the current cart.
  ///
  /// Returns the cart with purchase confirmation details.
  Future<Cart> purchaseCart() async {
    final response = await _post('/cart/purchase');
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return Cart.fromJson(json as Map<String, dynamic>);
  }

  // ========== WISHLISTS ==========

  /// **GET**  /wishlists
  ///
  /// Returns a paginated list of wishlists for the authenticated user.
  ///
  /// [gameId] - Optional filter by game ID.
  /// [page] - The page number to retrieve (defaults to 1).
  /// [limit] - The maximum number of wishlists per page (defaults to 20).
  ///
  /// Returns a [PaginatedResponse] containing [Wishlist] objects.
  Future<PaginatedResponse<Wishlist>> getWishlists({
    int? gameId,
    int page = 1,
    int limit = 20,
  }) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
    };
    if (gameId != null) queryParams['game_id'] = gameId.toString();

    final response = await _get('/wishlists', queryParameters: queryParams);
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    final wishlists = (json as List<dynamic>)
        .map((e) => Wishlist.fromJson(e as Map<String, dynamic>))
        .toList();

    return PaginatedResponse<Wishlist>(
      page: page,
      limit: limit,
      items: wishlists,
    );
  }

  /// **GET**  /wishlists/{id}
  ///
  /// Returns the details of a specific wishlist, including its items.
  ///
  /// [id] - The wishlist ID.
  ///
  /// Returns a [Wishlist] object with items populated.
  Future<Wishlist> getWishlist(int id) async {
    final response = await _get('/wishlists/$id');
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return Wishlist.fromJson(json as Map<String, dynamic>);
  }

  /// **POST**  /wishlists
  ///
  /// Creates a new wishlist.
  ///
  /// The API requires at least one item. Provide items via either
  /// [deckItemsFromText] (a text-based deck list) or [deckItems]
  /// (a list of [DeckItem] objects). At least one must be provided.
  ///
  /// [name] - The name of the wishlist.
  /// [gameId] - The game ID this wishlist belongs to.
  /// [isPublic] - Whether the wishlist is publicly visible.
  /// [deckItemsFromText] - A text-based deck list to parse into items.
  /// [deckItems] - A list of [DeckItem] to add to the wishlist.
  ///
  /// Throws [ArgumentError] if neither [deckItemsFromText] nor [deckItems]
  /// is provided.
  ///
  /// Returns the created [Wishlist].
  Future<Wishlist> createWishlist({
    required String name,
    required int gameId,
    bool? isPublic,
    String? deckItemsFromText,
    List<DeckItem>? deckItems,
  }) async {
    if (deckItemsFromText == null && (deckItems == null || deckItems.isEmpty)) {
      throw ArgumentError(
        'At least one of deckItemsFromText or deckItems must be provided. '
        'The API requires at least one item.',
      );
    }

    final data = <String, dynamic>{'name': name, 'game_id': gameId};

    if (isPublic != null) data['public'] = isPublic;
    if (deckItemsFromText != null) {
      data['deck_items_from_text_deck'] = deckItemsFromText;
    }
    if (deckItems != null) {
      data['deck_items_attributes'] = deckItems.map((e) => e.toJson()).toList();
    }

    final response = await _post('/wishlists', body: data);
    final json = jsonDecode(response.body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return Wishlist.fromJson(json as Map<String, dynamic>);
  }

  /// **DELETE**  /wishlists/{id}
  ///
  /// Deletes a wishlist.
  ///
  /// [id] - The wishlist ID.
  Future<void> deleteWishlist(int id) async {
    final response = await _delete('/wishlists/$id');

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body);
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }
  }

  // ========== INVENTORY MANAGEMENT ==========

  /// **GET**  /products/export
  ///
  /// Retrieves your listed products.
  ///
  /// [blueprintId] - Optional filter by blueprint ID.
  /// [expansionId] - Optional filter by expansion ID.
  Future<List<Product>> getMyProducts({
    int? blueprintId,
    int? expansionId,
  }) async {
    final queryParams = <String, String>{};
    if (blueprintId != null) {
      queryParams['blueprint_id'] = blueprintId.toString();
    }
    if (expansionId != null) {
      queryParams['expansion_id'] = expansionId.toString();
    }

    final response = await _get(
      '/products/export',
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return (json as List<dynamic>)
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// **POST**  /products
  ///
  /// Creates a new product listing.
  ///
  /// [blueprintId] - The blueprint ID to base the product on.
  /// [price] - The price as a double (e.g., 5.00 for €5.00).
  /// [quantity] - The quantity to list.
  /// [description] - Optional description.
  /// [strictMode] - If true, the API will fail and not create a Product if you pass a wrong Property. Otherwise, it will return a warning and accept the Product, automatically fixing the wrong Property with its default value.
  /// [userDataField] - Optional custom user data field. Visible only via API, not on CardTrader website.
  /// [properties] - Optional properties (condition, language, foil, etc.). The keys should match the editable properties defined in the blueprint.
  /// [graded] - Whether the product is graded.
  ///
  /// Returns the created [Product].
  Future<Product> createProduct({
    required int blueprintId,
    required double price,
    required int quantity,
    String? description,
    bool? strictMode,
    String? userDataField,
    Map<String, dynamic>? properties,
    bool? graded,
  }) async {
    final data = <String, dynamic>{
      'blueprint_id': blueprintId,
      'price': price,
      'quantity': quantity,
    };

    if (description != null) data['description'] = description;
    if (strictMode == true) data['error_mode'] = 'strict';
    if (userDataField != null) data['user_data_field'] = userDataField;
    if (properties != null) data['properties'] = properties;
    if (graded != null) data['graded'] = graded;

    final response = await _post('/products', body: data);
    final json = jsonDecode(response.body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    final result = json as Map<String, dynamic>;
    return Product.fromJson(result['resource'] as Map<String, dynamic>);
  }

  /// **PUT**  /products/{id}
  ///
  /// Updates an existing product listing.
  ///
  /// [id] - The product ID to update.
  /// [price] - The new price as a double.
  /// [quantity] - The new quantity.
  /// [description] - The new description.
  /// [strictMode] - If true, the update will fail if you pass a wrong value for a property. If false, invalid properties will be ignored and the update will succeed.
  /// [userDataField] - The new custom user data field. Visible only via API, not on CardTrader website.
  /// [properties] - The new properties. The keys should match the editable properties defined in the blueprint.
  /// [graded] - Whether the product is graded.
  ///
  /// Returns the updated [Product].
  Future<Product> updateProduct({
    required int id,
    double? price,
    int? quantity,
    String? description,
    bool? strictMode,
    String? userDataField,
    Map<String, dynamic>? properties,
    bool? graded,
  }) async {
    final data = <String, dynamic>{};

    if (price != null) data['price'] = price;
    if (quantity != null) data['quantity'] = quantity;
    if (description != null) data['description'] = description;
    if (strictMode == true) data['error_mode'] = 'strict';
    if (userDataField != null) data['user_data_field'] = userDataField;
    if (properties != null) data['properties'] = properties;
    if (graded != null) data['graded'] = graded;

    final response = await _put('/products/$id', body: data);
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    final result = json as Map<String, dynamic>;
    return Product.fromJson(result['resource'] as Map<String, dynamic>);
  }

  /// **DELETE**  /products/{id}
  ///
  /// Deletes a product listing.
  ///
  /// [id] - The product ID to delete.
  Future<void> deleteProduct(int id) async {
    final response = await _delete('/products/$id');

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body);
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }
  }

  /// **POST**  /products/{id}/increment
  ///
  /// Increments or decrements the product quantity by [deltaQuantity].
  ///
  /// Use positive values to increment, negative values to decrement.
  ///
  /// [id] - The product ID.
  /// [deltaQuantity] - The amount to change the quantity by.
  ///
  /// Returns the updated [Product].
  Future<Product> incrementProduct({
    required int id,
    required int deltaQuantity,
  }) async {
    final response = await _post(
      '/products/$id/increment',
      body: {'delta_quantity': deltaQuantity},
    );
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    final result = json as Map<String, dynamic>;
    return Product.fromJson(result['resource'] as Map<String, dynamic>);
  }

  // ========== PRODUCT IMAGES ==========

  /// **POST**  /products/{id}/upload_image
  ///
  /// Uploads an image for a product from a file (bytes).
  ///
  /// [id] - The product ID.
  /// [imageBytes] - The image file bytes.
  /// [filename] - The filename for the uploaded image (e.g., "card.jpg").
  ///
  /// Returns the image ID as an integer.
  Future<int> uploadProductImage({
    required int id,
    required Uint8List imageBytes,
    required String filename,
  }) async {
    final uri = Uri.parse('$_baseUrl/products/$id/upload_image');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $_apiKey'
      ..headers['Accept'] = 'application/json'
      ..files.add(
        http.MultipartFile.fromBytes(
          'uploaded_image[image]',
          imageBytes,
          filename: filename,
        ),
      );

    final streamedResponse = await _httpClient.send(request);
    final response = await http.Response.fromStream(streamedResponse);
    final json = jsonDecode(response.body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    final result = json as Map<String, dynamic>;
    return result['id'] as int;
  }

  /// **POST**  /products/{id}/upload_image (remote URL)
  ///
  /// Uploads an image for a product from a remote URL.
  ///
  /// [id] - The product ID.
  /// [imageUrl] - The URL of the remote image.
  ///
  /// Returns the image ID as an integer.
  Future<int> uploadProductImageFromUrl({
    required int id,
    required String imageUrl,
  }) async {
    final response = await _post(
      '/products/$id/upload_image',
      body: {
        'uploaded_image': {'remote_image_url': imageUrl},
      },
    );
    final json = jsonDecode(response.body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    final result = json as Map<String, dynamic>;
    return result['id'] as int;
  }

  /// **DELETE**  /products/{id}/upload_image
  ///
  /// Removes the image from a product.
  ///
  /// [id] - The product ID.
  Future<void> removeProductImage(int id) async {
    final response = await _delete('/products/$id/upload_image');

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body);
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }
  }

  // ========== BATCH OPERATIONS ==========

  /// **POST**  /products/bulk_create
  ///
  /// Bulk creates products asynchronously.
  ///
  /// [products] - A list of [ProductRequest] objects specifying the products
  /// to create. Each request must include blueprintId, price, and quantity.
  ///
  /// Returns a job UUID string to check status via [getJobStatus].
  Future<String> bulkCreateProducts(List<ProductRequest> products) async {
    final response = await _post(
      '/products/bulk_create',
      body: {'products': products.map((p) => p.toJson()).toList()},
    );
    final json = jsonDecode(response.body);

    if (response.statusCode != 200 && response.statusCode != 202) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    final result = json as Map<String, dynamic>;
    return result['job'] as String;
  }

  /// **POST**  /products/bulk_update
  ///
  /// Bulk updates products asynchronously.
  ///
  /// [products] - A list of [ProductUpdateRequest] objects specifying the
  /// products to update. Each request must include the product id and any
  /// fields to update.
  ///
  /// Returns a job UUID string to check status via [getJobStatus].
  Future<String> bulkUpdateProducts(List<ProductUpdateRequest> products) async {
    final response = await _post(
      '/products/bulk_update',
      body: {'products': products.map((p) => p.toJson()).toList()},
    );
    final json = jsonDecode(response.body);

    if (response.statusCode != 200 && response.statusCode != 202) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    final result = json as Map<String, dynamic>;
    return result['job'] as String;
  }

  /// **POST**  /products/bulk_destroy
  ///
  /// Bulk deletes products asynchronously.
  ///
  /// [productIds] - A list of product IDs to delete.
  ///
  /// Returns a job UUID string to check status via [getJobStatus].
  Future<String> bulkDeleteProducts(List<int> productIds) async {
    final response = await _post(
      '/products/bulk_destroy',
      body: {
        'products': productIds.map((id) => {'id': id}).toList(),
      },
    );
    final json = jsonDecode(response.body);

    if (response.statusCode != 200 && response.statusCode != 202) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    final result = json as Map<String, dynamic>;
    return result['job'] as String;
  }

  /// **GET**  /jobs/{uuid}
  ///
  /// Retrieves the status of a batch job.
  ///
  /// [uuid] - The job UUID returned from bulk operations.
  ///
  /// Returns a [Job] with current state and results.
  Future<Job> getJobStatus(String uuid) async {
    final response = await _get('/jobs/$uuid');
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return Job.fromJson(json as Map<String, dynamic>);
  }

  // ========== ORDER MANAGEMENT ==========

  /// **GET**  /orders
  ///
  /// Retrieves a paginated list of orders.
  ///
  /// Orders are purchase transactions — either items you sold or purchased.
  ///
  /// [page] - The page number to retrieve (defaults to 1).
  /// [limit] - Items per page, 1-100 (defaults to 20).
  /// [from] - Filter orders from this date.
  /// [to] - Filter orders up to this date.
  /// [fromId] - Exclude orders with ID equal or less than this value.
  /// [toId] - Exclude orders with ID greater than this value.
  /// [state] - Filter by order state (e.g., "paid", "sent", "hub_pending").
  /// [orderAs] - Filter by your role: [OrderAs.seller] or [OrderAs.buyer].
  /// [sort] - Sort format: `<id|date>.<asc|desc>` (defaults to "date.desc").
  Future<PaginatedResponse<Order>> getOrders({
    int page = 1,
    int limit = 20,
    DateTime? from,
    DateTime? to,
    int? fromId,
    int? toId,
    String? state,
    OrderAs? orderAs,
    String? sort,
  }) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
    };
    final dateFormat = DateFormat('yyyy-MM-dd');
    if (from != null) {
      queryParams['from'] = dateFormat.format(from);
    }
    if (to != null) {
      queryParams['to'] = dateFormat.format(to);
    }
    if (fromId != null) queryParams['from_id'] = fromId.toString();
    if (toId != null) queryParams['to_id'] = toId.toString();
    if (state != null) queryParams['state'] = state;
    if (orderAs != null) queryParams['order_as'] = orderAs.value;
    if (sort != null) queryParams['sort'] = sort;

    final response = await _get('/orders', queryParameters: queryParams);
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    final orders = (json as List<dynamic>)
        .map((e) => Order.fromJson(e as Map<String, dynamic>))
        .toList();

    return PaginatedResponse<Order>(page: page, limit: limit, items: orders);
  }

  /// **GET**  /orders/{id}
  ///
  /// Retrieves the details of a specific order.
  ///
  /// [id] - The order ID.
  ///
  /// Returns an [Order] object with full details including items,
  /// addresses, and shipping method.
  Future<Order> getOrder(int id) async {
    final response = await _get('/orders/$id');
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return Order.fromJson(json as Map<String, dynamic>);
  }

  /// **PUT**  /orders/{id}/tracking_code
  ///
  /// Sets a tracking code for an order.
  ///
  /// For CardTrader Zero orders, the tracking code must be set
  /// BEFORE shipping.
  ///
  /// You must be the seller in this order.
  ///
  /// [id] - The order ID.
  /// [trackingCode] - The tracking code string.
  ///
  /// Returns the updated [Order].
  Future<Order> setOrderTrackingCode({
    required int id,
    required String trackingCode,
  }) async {
    final response = await _put(
      '/orders/$id/tracking_code',
      body: {'tracking_code': trackingCode},
    );
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return Order.fromJson(json as Map<String, dynamic>);
  }

  /// **PUT**  /orders/{id}/ship
  ///
  /// Marks an order as shipped.
  ///
  /// If the order is in a state where this operation is not allowed,
  /// the API will return an error.
  ///
  /// [id] - The order ID.
  ///
  /// Returns the updated [Order].
  Future<Order> shipOrder(int id) async {
    final response = await _put('/orders/$id/ship');
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return Order.fromJson(json as Map<String, dynamic>);
  }

  /// **PUT**  /orders/{id}/request-cancellation
  ///
  /// Requests cancellation of an order.
  ///
  /// Depending on whether you are the seller or buyer, this sends a
  /// cancellation request to the other party. Can be done when the order
  /// is in `paid` or `sent` state.
  ///
  /// [id] - The order ID.
  /// [cancelExplanation] - Reason for cancellation (minimum 50 characters).
  /// [relistIfCancelled] - Whether to relist items if cancellation is confirmed.
  ///
  /// Returns the updated [Order].
  Future<Order> requestOrderCancellation({
    required int id,
    required String cancelExplanation,
    bool? relistIfCancelled,
  }) async {
    final data = <String, dynamic>{'cancel_explanation': cancelExplanation};
    if (relistIfCancelled != null) {
      data['relist_if_cancelled'] = relistIfCancelled;
    }

    final response = await _put('/orders/$id/request-cancellation', body: data);
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return Order.fromJson(json as Map<String, dynamic>);
  }

  /// **PUT**  /orders/{id}/confirm-cancellation
  ///
  /// Confirms a cancellation request for an order.
  ///
  /// If the current order state does not permit cancellation confirmation,
  /// the API will return an error.
  ///
  /// [id] - The order ID.
  /// [relistIfCancelled] - (Seller only) Whether to relist items after cancellation.
  ///
  /// Returns the updated [Order].
  Future<Order> confirmOrderCancellation({
    required int id,
    bool? relistIfCancelled,
  }) async {
    final data = <String, dynamic>{};
    if (relistIfCancelled != null) {
      data['relist_if_cancelled'] = relistIfCancelled;
    }

    final response = await _put(
      '/orders/$id/confirm-cancellation',
      body: data.isNotEmpty ? data : null,
    );
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return Order.fromJson(json as Map<String, dynamic>);
  }

  // ========== CT0 BOX ITEMS ==========

  /// **GET**  /ct0_box_items
  ///
  /// Retrieves the list of CT0 Box items you purchased.
  ///
  /// A CT0 Box Item is a product purchased via CardTrader Zero
  /// that has not yet been sent to you directly.
  Future<List<Ct0BoxItem>> getCt0BoxItems() async {
    final response = await _get('/ct0_box_items');
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return (json as List<dynamic>)
        .map((e) => Ct0BoxItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// **GET**  /ct0_box_items/{id}
  ///
  /// Retrieves the details of a specific CT0 Box item.
  ///
  /// [id] - The CT0 Box item ID.
  ///
  /// Returns a [Ct0BoxItem] with full details.
  Future<Ct0BoxItem> getCt0BoxItem(int id) async {
    final response = await _get('/ct0_box_items/$id');
    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw CardTraderException.fromJson(
        json as Map<String, dynamic>,
        response.statusCode,
      );
    }

    return Ct0BoxItem.fromJson(json as Map<String, dynamic>);
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

  Future<http.Response> _post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint');

    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apiKey',
    };

    final response = await _httpClient.post(
      uri,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return response;
  }

  Future<http.Response> _put(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint');

    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apiKey',
    };

    final response = await _httpClient.put(
      uri,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return response;
  }

  Future<http.Response> _delete(String endpoint) async {
    final uri = Uri.parse('$_baseUrl$endpoint');

    final headers = <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer $_apiKey',
    };

    final response = await _httpClient.delete(uri, headers: headers);
    return response;
  }
}
