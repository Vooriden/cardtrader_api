# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0]

### Added

- **Games**: `getGames()` endpoint to retrieve the list of games
- **Categories**: `getCategories()` endpoint with optional game ID filter
- **Expansions**: `getExpansions()` and `getMyExpansions()` endpoints
- **Blueprints**: `getBlueprintsByExpansion()` endpoint
- **Marketplace**: `getMarketplaceProducts()` with expansion, blueprint, foil, and language filters
- **Cart**: `getCart()`, `addToCart()`, `removeFromCart()`, and `purchaseCart()` endpoints
- **Wishlists**: `getWishlists()`, `getWishlist()`, `createWishlist()`, and `deleteWishlist()` endpoints
- **Inventory Management**: `getMyProducts()`, `createProduct()`, `updateProduct()`, `deleteProduct()`, and `incrementProduct()` endpoints
- **Product Images**: `uploadProductImage()`, `uploadProductImageFromUrl()`, and `removeProductImage()` endpoints
- **Batch Operations**: `bulkCreateProducts()`, `bulkUpdateProducts()`, `bulkDeleteProducts()`, and `getJobStatus()` endpoints
- **Order Management**: `getOrders()`, `getOrder()`, `setOrderTrackingCode()`, `shipOrder()`, `requestOrderCancellation()`, and `confirmOrderCancellation()` endpoints
- **CT0 Box Items**: `getCt0BoxItems()` and `getCt0BoxItem()` endpoints
- `OrderAs` enum for type-safe order role filtering (`seller` / `buyer`)
- `DateTime` support for `from` and `to` parameters in `getOrders()`
- Models: `Game`, `Category`, `Expansion`, `Blueprint`, `MarketplaceProduct`, `Cart`, `Wishlist`, `Product`, `ProductRequest`, `ProductUpdateRequest`, `Job`, `Order`, `Ct0BoxItem`, `Money`, `Address`, `User`, `ShippingMethod`, `Property`, `PaginatedResponse`
- Full unit test coverage for all endpoints and models
- Example usage in `example/main.dart`

## [0.1.0]

### Added

- Initial release with `/info` endpoint support
- `CardTraderClient` for API communication
- `AppInfo` model to represent application information from the API
- `CardTraderException` model for API error handling
- Unit tests for `CardTraderClient` and `AppInfo` model
