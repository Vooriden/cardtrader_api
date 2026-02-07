import 'dart:convert';

import 'package:cardtrader_api/src/models/cardtrader_exception.dart';
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

  // // ========== GAMES ==========

  // /// Get list of games
  // Future<List<Game>> getGames() async {
  //   final response = await get('/games', apiKey: _apiKey);
  //   return (response.data as List<dynamic>)
  //       .map((e) => Game.fromJson(e as Map<String, dynamic>))
  //       .toList();
  // }

  // // ========== CATEGORIES ==========

  // /// Get list of categories
  // /// [gameId] - Optional filter by game ID
  // Future<List<Category>> getCategories({int? gameId}) async {
  //   final response = await get(
  //     '/categories',
  //     queryParameters: gameId != null ? {'game_id': gameId} : null,
  //     apiKey: _apiKey,
  //   );
  //   return (response.data as List<dynamic>)
  //       .map((e) => Category.fromJson(e as Map<String, dynamic>))
  //       .toList();
  // }

  // // ========== EXPANSIONS ==========

  // /// Get list of expansions
  // Future<List<Expansion>> getExpansions() async {
  //   final response = await get('/expansions', apiKey: _apiKey);
  //   return (response.data as List<dynamic>)
  //       .map((e) => Expansion.fromJson(e as Map<String, dynamic>))
  //       .toList();
  // }

  // /// Get list of expansions you have in your inventory
  // Future<List<Expansion>> getMyExpansions() async {
  //   final response = await get('/expansions/export', apiKey: _apiKey);
  //   return (response.data as List<dynamic>)
  //       .map((e) => Expansion.fromJson(e as Map<String, dynamic>))
  //       .toList();
  // }

  // // ========== BLUEPRINTS ==========

  // /// Get blueprints by expansion ID
  // /// [expansionId] - Required expansion ID
  // Future<List<Blueprint>> getBlueprintsByExpansion(int expansionId) async {
  //   final response = await get(
  //     '/blueprints/export',
  //     queryParameters: {'expansion_id': expansionId},
  //     apiKey: _apiKey,
  //   );
  //   return (response.data as List<dynamic>)
  //       .map((e) => Blueprint.fromJson(e as Map<String, dynamic>))
  //       .toList();
  // }

  // // ========== MARKETPLACE ==========

  // /// Get marketplace products by expansion or blueprint
  // /// Either [expansionId] or [blueprintId] is required
  // /// [foil] - Optional filter by foil
  // /// [language] - Optional filter by language (2-letter code like 'en', 'it')
  // /// Returns a map with blueprint IDs as keys and lists of products as values
  // Future<Map<String, List<MarketplaceProduct>>> getMarketplaceProducts({
  //   int? expansionId,
  //   int? blueprintId,
  //   bool? foil,
  //   String? language,
  // }) async {
  //   final queryParams = <String, dynamic>{};
  //   if (expansionId != null) queryParams['expansion_id'] = expansionId;
  //   if (blueprintId != null) queryParams['blueprint_id'] = blueprintId;
  //   if (foil != null) queryParams['foil'] = foil;
  //   if (language != null) queryParams['language'] = language;

  //   final response = await get(
  //     '/marketplace/products',
  //     queryParameters: queryParams,
  //     apiKey: _apiKey,
  //   );

  //   final data = response.data as Map<String, dynamic>;
  //   final result = <String, List<MarketplaceProduct>>{};

  //   data.forEach((key, value) {
  //     result[key] = (value as List<dynamic>)
  //         .map((e) => MarketplaceProduct.fromJson(e as Map<String, dynamic>))
  //         .toList();
  //   });

  //   return result;
  // }

  // // ========== CART ==========

  // /// Get current cart status
  // Future<Cart> getCart() async {
  //   final response = await get('/cart');
  //   return Cart.fromJson(response.data as Map<String, dynamic>);
  // }

  // /// Add product to cart
  // /// [productId] - The product ID to add
  // /// [quantity] - Quantity to add
  // /// [viaCardtraderZero] - Purchase via CardTrader Zero
  // /// [billingAddress] - Optional billing address
  // /// [shippingAddress] - Optional shipping address
  // Future<Cart> addToCart({
  //   required int productId,
  //   required int quantity,
  //   required bool viaCardtraderZero,
  //   Address? billingAddress,
  //   Address? shippingAddress,
  // }) async {
  //   final data = <String, dynamic>{
  //     'product_id': productId,
  //     'quantity': quantity,
  //     'via_cardtrader_zero': viaCardtraderZero,
  //   };

  //   if (billingAddress != null) {
  //     data['billing_address'] = billingAddress.toJson();
  //   }
  //   if (shippingAddress != null) {
  //     data['shipping_address'] = shippingAddress.toJson();
  //   }

  //   final response = await post('/cart/add', data: data);
  //   return Cart.fromJson(response.data as Map<String, dynamic>);
  // }

  // /// Remove product from cart
  // /// [productId] - The product ID to remove
  // /// [quantity] - Quantity to remove
  // Future<Cart> removeFromCart({
  //   required int productId,
  //   required int quantity,
  // }) async {
  //   final response = await post(
  //     '/cart/remove',
  //     data: {'product_id': productId, 'quantity': quantity},
  //   );
  //   return Cart.fromJson(response.data as Map<String, dynamic>);
  // }

  // /// Purchase the cart
  // Future<Cart> purchaseCart() async {
  //   final response = await post('/cart/purchase');
  //   return Cart.fromJson(response.data as Map<String, dynamic>);
  // }

  // // ========== SHIPPING METHODS ==========

  // /// Get shipping methods for a specific seller
  // /// [username] - Seller username (URL encoded)
  // Future<List<ShippingMethod>> getShippingMethods(String username) async {
  //   final response = await get(
  //     '/shipping_methods',
  //     queryParameters: {'username': username},
  //   );
  //   return (response.data as List<dynamic>)
  //       .map((e) => ShippingMethod.fromJson(e as Map<String, dynamic>))
  //       .toList();
  // }

  // // ========== WISHLISTS ==========

  // /// Get list of wishlists
  // /// [gameId] - Optional filter by game ID
  // /// [page] - Page number (default 1)
  // /// [limit] - Items per page (default 20)
  // Future<List<Wishlist>> getWishlists({
  //   int? gameId,
  //   int? page,
  //   int? limit,
  // }) async {
  //   final queryParams = <String, dynamic>{};
  //   if (gameId != null) queryParams['game_id'] = gameId;
  //   if (page != null) queryParams['page'] = page;
  //   if (limit != null) queryParams['limit'] = limit;

  //   final response = await get('/wishlists', queryParameters: queryParams);
  //   return (response.data as List<dynamic>)
  //       .map((e) => Wishlist.fromJson(e as Map<String, dynamic>))
  //       .toList();
  // }

  // /// Get wishlist details
  // /// [id] - Wishlist ID
  // Future<Wishlist> getWishlist(int id) async {
  //   final response = await get('/wishlists/$id');
  //   return Wishlist.fromJson(response.data as Map<String, dynamic>);
  // }

  // /// Create a wishlist
  // Future<Wishlist> createWishlist({
  //   required String name,
  //   required int gameId,
  //   bool? isPublic,
  //   String? deckItemsFromText,
  //   List<DeckItem>? deckItems,
  // }) async {
  //   final data = <String, dynamic>{'name': name, 'game_id': gameId};

  //   if (isPublic != null) data['public'] = isPublic;
  //   if (deckItemsFromText != null) {
  //     data['deck_items_from_text_deck'] = deckItemsFromText;
  //   }
  //   if (deckItems != null) {
  //     data['deck_items_attributes'] = deckItems.map((e) => e.toJson()).toList();
  //   }

  //   final response = await post('/wishlists', data: data);
  //   return Wishlist.fromJson(response.data as Map<String, dynamic>);
  // }

  // /// Delete a wishlist
  // /// [id] - Wishlist ID
  // Future<void> deleteWishlist(int id) async {
  //   await delete('/wishlists/$id');
  // }

  // // ========== INVENTORY MANAGEMENT ==========

  // /// Get list of your products
  // /// [blueprintId] - Optional filter by blueprint ID
  // /// [expansionId] - Optional filter by expansion ID
  // Future<List<Product>> getMyProducts({
  //   int? blueprintId,
  //   int? expansionId,
  // }) async {
  //   final queryParams = <String, dynamic>{};
  //   if (blueprintId != null) queryParams['blueprint_id'] = blueprintId;
  //   if (expansionId != null) queryParams['expansion_id'] = expansionId;

  //   final response = await get(
  //     '/products/export',
  //     queryParameters: queryParams,
  //   );
  //   return (response.data as List<dynamic>)
  //       .map((e) => Product.fromJson(e as Map<String, dynamic>))
  //       .toList();
  // }

  // /// Create a product
  // Future<Product> createProduct({
  //   required int blueprintId,
  //   required double price,
  //   required int quantity,
  //   String? description,
  //   String? errorMode,
  //   String? userDataField,
  //   Map<String, dynamic>? properties,
  //   bool? graded,
  // }) async {
  //   final data = <String, dynamic>{
  //     'blueprint_id': blueprintId,
  //     'price': price,
  //     'quantity': quantity,
  //   };

  //   if (description != null) data['description'] = description;
  //   if (errorMode != null) data['error_mode'] = errorMode;
  //   if (userDataField != null) data['user_data_field'] = userDataField;
  //   if (properties != null) data['properties'] = properties;
  //   if (graded != null) data['graded'] = graded;

  //   final response = await post('/products', data: data);
  //   final result = response.data as Map<String, dynamic>;
  //   return Product.fromJson(result['resource'] as Map<String, dynamic>);
  // }

  // /// Update a product
  // Future<Product> updateProduct({
  //   required int id,
  //   double? price,
  //   int? quantity,
  //   String? description,
  //   String? errorMode,
  //   String? userDataField,
  //   Map<String, dynamic>? properties,
  //   bool? graded,
  // }) async {
  //   final data = <String, dynamic>{};

  //   if (price != null) data['price'] = price;
  //   if (quantity != null) data['quantity'] = quantity;
  //   if (description != null) data['description'] = description;
  //   if (errorMode != null) data['error_mode'] = errorMode;
  //   if (userDataField != null) data['user_data_field'] = userDataField;
  //   if (properties != null) data['properties'] = properties;
  //   if (graded != null) data['graded'] = graded;

  //   final response = await put('/products/$id', data: data);
  //   final result = response.data as Map<String, dynamic>;
  //   return Product.fromJson(result['resource'] as Map<String, dynamic>);
  // }

  // /// Delete a product
  // Future<void> deleteProduct(int id) async {
  //   await delete('/products/$id');
  // }

  // /// Increment or decrement product quantity
  // Future<Product> incrementProduct({
  //   required int id,
  //   required int deltaQuantity,
  // }) async {
  //   final response = await post(
  //     '/products/$id/increment',
  //     data: {'delta_quantity': deltaQuantity},
  //   );
  //   final result = response.data as Map<String, dynamic>;
  //   return Product.fromJson(result['resource'] as Map<String, dynamic>);
  // }

  // // ========== BATCH OPERATIONS ==========

  // /// Bulk create products (async operation)
  // /// Returns a job UUID to check status
  // Future<String> bulkCreateProducts(List<Map<String, dynamic>> products) async {
  //   final response = await post(
  //     '/products/bulk_create',
  //     data: {'products': products},
  //   );
  //   final result = response.data as Map<String, dynamic>;
  //   return result['job'] as String;
  // }

  // /// Bulk update products (async operation)
  // /// Returns a job UUID to check status
  // Future<String> bulkUpdateProducts(List<Map<String, dynamic>> products) async {
  //   final response = await post(
  //     '/products/bulk_update',
  //     data: {'products': products},
  //   );
  //   final result = response.data as Map<String, dynamic>;
  //   return result['job'] as String;
  // }

  // /// Bulk delete products (async operation)
  // /// Returns a job UUID to check status
  // Future<String> bulkDeleteProducts(List<Map<String, dynamic>> products) async {
  //   final response = await post(
  //     '/products/bulk_destroy',
  //     data: {'products': products},
  //   );
  //   final result = response.data as Map<String, dynamic>;
  //   return result['job'] as String;
  // }

  // /// Get job status
  // /// [uuid] - Job UUID from bulk operations
  // Future<Job> getJobStatus(String uuid) async {
  //   final response = await get('/jobs/$uuid');
  //   return Job.fromJson(response.data as Map<String, dynamic>);
  // }

  // // ========== ORDERS ==========

  // /// Get list of orders
  // /// [page] - Page number (default 1)
  // /// [limit] - Items per page (default 20, max 100)
  // /// [from] - Start date (YYYY-MM-DD)
  // /// [to] - End date (YYYY-MM-DD)
  // /// [fromId] - Minimum order ID
  // /// [toId] - Maximum order ID
  // /// [state] - Filter by order state
  // /// [orderAs] - Your role: 'seller' or 'buyer'
  // /// [sort] - Sort format: 'id.asc', 'id.desc', 'date.asc', 'date.desc'
  // Future<List<Order>> getOrders({
  //   int? page,
  //   int? limit,
  //   String? from,
  //   String? to,
  //   int? fromId,
  //   int? toId,
  //   String? state,
  //   String? orderAs,
  //   String? sort,
  // }) async {
  //   final queryParams = <String, dynamic>{};
  //   if (page != null) queryParams['page'] = page;
  //   if (limit != null) queryParams['limit'] = limit;
  //   if (from != null) queryParams['from'] = from;
  //   if (to != null) queryParams['to'] = to;
  //   if (fromId != null) queryParams['from_id'] = fromId;
  //   if (toId != null) queryParams['to_id'] = toId;
  //   if (state != null) queryParams['state'] = state;
  //   if (orderAs != null) queryParams['order_as'] = orderAs;
  //   if (sort != null) queryParams['sort'] = sort;

  //   final response = await get('/orders', queryParameters: queryParams);
  //   return (response.data as List<dynamic>)
  //       .map((e) => Order.fromJson(e as Map<String, dynamic>))
  //       .toList();
  // }

  // /// Get order details
  // /// [id] - Order ID
  // Future<Order> getOrder(int id) async {
  //   final response = await get('/orders/$id');
  //   return Order.fromJson(response.data as Map<String, dynamic>);
  // }

  // /// Set tracking code for an order
  // /// [id] - Order ID
  // /// [trackingCode] - Tracking code string
  // Future<Order> setOrderTrackingCode({
  //   required int id,
  //   required String trackingCode,
  // }) async {
  //   final response = await put(
  //     '/orders/$id/tracking_code',
  //     data: {'tracking_code': trackingCode},
  //   );
  //   return Order.fromJson(response.data as Map<String, dynamic>);
  // }

  // /// Mark order as shipped
  // /// [id] - Order ID
  // Future<Order> shipOrder(int id) async {
  //   final response = await put('/orders/$id/ship');
  //   return Order.fromJson(response.data as Map<String, dynamic>);
  // }

  // /// Request order cancellation
  // /// [id] - Order ID
  // /// [cancelExplanation] - Reason for cancellation (min 50 chars)
  // /// [relistIfCancelled] - Whether to relist if cancelled
  // Future<Order> requestOrderCancellation({
  //   required int id,
  //   required String cancelExplanation,
  //   bool? relistIfCancelled,
  // }) async {
  //   final data = <String, dynamic>{'cancel_explanation': cancelExplanation};
  //   if (relistIfCancelled != null) {
  //     data['relist_if_cancelled'] = relistIfCancelled;
  //   }

  //   final response = await put('/orders/$id/request-cancellation', data: data);
  //   return Order.fromJson(response.data as Map<String, dynamic>);
  // }

  // /// Confirm order cancellation
  // /// [id] - Order ID
  // /// [relistIfCancelled] - Whether to relist if cancelled (seller only)
  // Future<Order> confirmOrderCancellation({
  //   required int id,
  //   bool? relistIfCancelled,
  // }) async {
  //   final data = <String, dynamic>{};
  //   if (relistIfCancelled != null) {
  //     data['relist_if_cancelled'] = relistIfCancelled;
  //   }

  //   final response = await put('/orders/$id/confirm-cancellation', data: data);
  //   return Order.fromJson(response.data as Map<String, dynamic>);
  // }

  // // ========== CT0 BOX ITEMS ==========

  // /// Get CT0 box items
  // Future<List<Ct0BoxItem>> getCt0BoxItems() async {
  //   final response = await _get('/ct0_box_items', apiKey: _apiKey);
  //   return (response.data as List<dynamic>)
  //       .map((e) => Ct0BoxItem.fromJson(e as Map<String, dynamic>))
  //       .toList();
  // }

  // /// Get CT0 box item details
  // /// [id] - CT0 box item ID
  // Future<Ct0BoxItem> getCt0BoxItem(int id) async {
  //   final response = await get('/ct0_box_items/$id', apiKey: _apiKey);
  //   return Ct0BoxItem.fromJson(response.data as Map<String, dynamic>);
  // }

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
    Map<String, dynamic>? data,
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint');

    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apiKey',
    };

    final body = data != null ? jsonEncode(data) : null;

    final response = await _httpClient.post(uri, headers: headers, body: body);
    return response;
  }
}
