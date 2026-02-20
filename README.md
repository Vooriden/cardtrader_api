# CardTrader API

A Dart client library for the [CardTrader API](https://www.cardtrader.com/en/docs/api).

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  cardtrader_api: ^0.1.0
```

Then run:

```bash
dart pub get
```

## Authentication

Obtain an API key from CardTrader. The key must be provided when creating a client instance.

## Usage

### Basic Setup

```dart
import 'package:cardtrader_api/cardtrader_api.dart';

void main() async {
  final client = CardTraderClient(apiKey: 'your_api_key_here');

  try {
    // Use the client
    final info = await client.getInfo();
    print('App: ${info.name}');
  } finally {
    // Always close the client when done
    client.close();
  }
}
```

### Testing Authentication

Use the `getInfo()` method to verify your API key and retrieve application details:

```dart
final info = await client.getInfo();
print('App ID: ${info.id}');
print('App Name: ${info.name}');
print('User ID: ${info.userId}');
```

### Error Handling

API errors are thrown as `CardTraderException` instances:

```dart
try {
  final info = await client.getInfo();
} on CardTraderException catch (e) {
  print('Error ${e.statusCode}: ${e.errorCode}');
  print('Message: ${e.extra.message}');
  print('Request ID: ${e.requestId}');
}
```

### Custom HTTP Client

Provide your own HTTP client for testing or custom configuration:

```dart
import 'package:http/http.dart' as http;

final httpClient = http.Client();
final client = CardTraderClient(
  apiKey: 'your_api_key_here',
  httpClient: httpClient,
);
```

## Resource Management

Always call `close()` when you're done with the client to free resources:

```dart
final client = CardTraderClient(apiKey: apiKey);
try {
  // Use the client
} finally {
  client.close();
}
```

After calling `close()`, any further requests will throw an exception.

## Available Endpoints

### App Info

- `getInfo()` — Test authentication and get application details.

### Games

- `getGames()` — List all supported games.

### Categories

- `getCategories({gameId})` — List categories, optionally filtered by game.

### Expansions

- `getExpansions()` — List all expansions.
- `getMyExpansions()` — List expansions you have products in.

### Blueprints

- `getBlueprintsByExpansion(expansionId)` — List blueprints for an expansion.

### Marketplace

- `getMarketplaceProducts({expansionId, blueprintId, foil, language})` — Browse marketplace listings.

### Cart

- `getCart()` — Get current cart.
- `addToCart({productId, quantity, viaCardtraderZero, ...})` — Add item to cart.
- `removeFromCart({productId, quantity})` — Remove item from cart.
- `purchaseCart()` — Purchase the cart.

### Wishlists

- `getWishlists({gameId, page, limit})` — List wishlists (paginated).
- `getWishlist(id)` — Get wishlist details with items.
- `createWishlist({name, gameId, ...})` — Create a new wishlist.
- `deleteWishlist(id)` — Delete a wishlist.

### Inventory Management

- `getMyProducts({blueprintId, expansionId})` — List your products.
- `createProduct({blueprintId, price, quantity, ...})` — Create a product listing.
- `updateProduct({id, price, quantity, ...})` — Update a product listing.
- `deleteProduct(id)` — Delete a product listing.
- `incrementProduct({id, deltaQuantity})` — Increment/decrement product quantity.

### Product Images

- `uploadProductImage({id, imageBytes, filename})` — Upload an image file to a product.
- `uploadProductImageFromUrl({id, imageUrl})` — Upload an image to a product from a remote URL.
- `removeProductImage(id)` — Remove the image from a product.

### Batch Operations

- `bulkCreateProducts(products)` — Bulk create products (async, returns job UUID).
- `bulkUpdateProducts(products)` — Bulk update products (async, returns job UUID).
- `bulkDeleteProducts(products)` — Bulk delete products (async, returns job UUID).
- `getJobStatus(uuid)` — Check batch job status and results.

## API Documentation

For complete API documentation, visit the [CardTrader API documentation](https://www.cardtrader.com/en/docs/api).

## Known Limitations

- **Shipping Methods** (`GET /shipping_methods`): This endpoint is currently not available — the CardTrader API returns `404 Not Found`. It will be implemented once the endpoint becomes functional.

## License

See the [LICENSE](LICENSE) file for details.

## Additional Information

This library is not official and is not affiliated with CardTrader.
