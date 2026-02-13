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
      print(
        '- ${expansion.displayName} [${expansion.code}] (ID: ${expansion.id})',
      );
    }
    if (expansions.length > 5) {
      print('  ... and ${expansions.length - 5} more expansions');
    }
    print('');

    // ========== GET BLUEPRINTS ==========
    print('=== Blueprints (first expansion, first 5) ===');
    if (expansions.isNotEmpty) {
      final firstExpansionId = expansions.first.id;
      final blueprints = await client.getBlueprintsByExpansion(
        firstExpansionId,
      );
      for (final blueprint in blueprints.take(5)) {
        print('- ${blueprint.name} (ID: ${blueprint.id})');
        if (blueprint.imageUrl != null) {
          print('  Image: ${blueprint.imageUrl}');
        }
        if (blueprint.editableProperties.isNotEmpty) {
          print(
            '  Properties: ${blueprint.editableProperties.map((p) => p.name).join(', ')}',
          );
        }
      }
      if (blueprints.length > 5) {
        print('  ... and ${blueprints.length - 5} more blueprints');
      }
    }
    print('');

    // ========== GET MARKETPLACE PRODUCTS ==========
    print('=== Marketplace Products (first expansion, first 3) ===');
    int? sampleProductId;
    if (expansions.isNotEmpty) {
      final firstExpansionId = expansions.first.id;
      final products = await client.getMarketplaceProducts(
        expansionId: firstExpansionId,
      );
      if (products.isEmpty) {
        print('No products found in marketplace for this expansion.');
      } else {
        var count = 0;
        for (final entry in products.entries) {
          if (count >= 3) break;
          final blueprintProducts = entry.value;
          if (blueprintProducts.isNotEmpty) {
            final product = blueprintProducts.first;
            // Store first product ID for cart operations example
            sampleProductId ??= product.id;
            print('- ${product.nameEn}');
            print('  Price: ${product.price}');
            print(
              '  Seller: ${product.user.username} (${product.user.countryCode ?? 'N/A'})',
            );
            print('  Quantity: ${product.quantity}');
            count++;
          }
        }
        final totalProducts = products.values.fold<int>(
          0,
          (sum, list) => sum + list.length,
        );
        if (totalProducts > 3) {
          print('  ... and ${totalProducts - 3} more products');
        }
      }
    }
    print('');

    // ========== CART OPERATIONS ==========
    print('=== Cart Operations ===');

    // Get current cart
    print('Fetching current cart...');
    final cart = await client.getCart();
    print('Cart ID: ${cart.id}');
    print('Subtotal: ${cart.subtotal.formatted}');
    print('Total: ${cart.total.formatted}');
    print('Number of subcarts: ${cart.subcarts.length}');

    if (cart.subcarts.isNotEmpty) {
      print('');
      print('Cart contents:');
      for (var i = 0; i < cart.subcarts.length; i++) {
        final subcart = cart.subcarts[i];
        print('  Subcart ${i + 1}:');
        if (subcart.seller != null) {
          print('    Seller: ${subcart.seller!.username}');
        }
        print('    Via CardTrader Zero: ${subcart.viaCardtraderZero ?? false}');
        print('    Items: ${subcart.cartItems.length}');
        for (final item in subcart.cartItems) {
          print('      - ${item.product.nameEn} x${item.quantity}');
          print('        Price: ${item.priceCents} ${item.priceCurrency}');
        }
      }
    } else {
      print('Cart is empty.');
    }

    if (cart.shippingAddress != null) {
      print('Shipping Address:');
      print('  ${cart.shippingAddress!.name}');
      print('  ${cart.shippingAddress!.street}');
      print('  ${cart.shippingAddress!.zip} ${cart.shippingAddress!.city}');
      print('  ${cart.shippingAddress!.countryCode}');
    }

    print('Fees:');
    print('  Shipping: ${cart.shippingCost.formatted}');
    print(
      '  Payment method (fixed): ${cart.paymentMethodFeeFixedAmount.formatted}',
    );
    print(
      '  Payment method (percentage): ${cart.paymentMethodFeePercentageAmount.formatted}',
    );
    print('  CT Zero fee: ${cart.ctZeroFeeAmount.formatted}');
    print('  Safeguard fee: ${cart.safeguardFeeAmount.formatted}');
    print('');

    // Add item to cart using product from marketplace
    if (sampleProductId != null) {
      print('Adding item to cart (Product ID: $sampleProductId)...');
      final updatedCart = await client.addToCart(
        productId: sampleProductId,
        quantity: 1,
        viaCardtraderZero: false,
      );
      print('Item added. New cart total: ${updatedCart.total.toString()}');
      print('');

      // Remove item from cart
      print('Removing item from cart (Product ID: $sampleProductId)...');
      final cartAfterRemoval = await client.removeFromCart(
        productId: sampleProductId,
        quantity: 1,
      );
      print(
        'Item removed. New cart total: ${cartAfterRemoval.total.toString()}',
      );
    } else {
      print('No product ID available for cart operations example.');
    }

    print('');

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
