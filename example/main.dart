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

    sleep(Duration(seconds: 2));

    // ========== GET BLUEPRINTS ==========
    print('=== Blueprints (first expansion, first 5) ===');
    Blueprint? sampleBlueprint;
    if (expansions.isNotEmpty) {
      final firstExpansionId = expansions.first.id;
      final blueprints = await client.getBlueprintsByExpansion(
        firstExpansionId,
      );
      for (final blueprint in blueprints.take(5)) {
        // Store first blueprint for wishlist example
        sampleBlueprint ??= blueprint;
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

    sleep(Duration(seconds: 2));

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

    sleep(Duration(seconds: 2));

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

    sleep(Duration(seconds: 2));

    // ========== WISHLIST OPERATIONS ==========
    print('=== Wishlist Operations ===');

    // Get wishlists (paginated)
    print('Fetching wishlists...');
    final wishlistsResponse = await client.getWishlists();
    print('Page ${wishlistsResponse.page}, Limit ${wishlistsResponse.limit}');
    print('Wishlists found: ${wishlistsResponse.items.length}');
    for (final wishlist in wishlistsResponse.items) {
      print(
        '- ${wishlist.name} (ID: ${wishlist.id}, Game: ${wishlist.gameId})',
      );
      print('  Public: ${wishlist.isPublic}');
    }
    print('');

    // Create a wishlist (at least one item is required)
    print('Creating a new wishlist...');
    if (sampleBlueprint != null) {
      final newWishlist = await client.createWishlist(
        name: 'Example Wishlist',
        gameId: games.array.first.id,
        isPublic: false,
        deckItems: [
          DeckItem(
            quantity: 1,
            metaName: sampleBlueprint.name,
            blueprintId: sampleBlueprint.id,
          ),
        ],
      );
      print('Created wishlist: ${newWishlist.name} (ID: ${newWishlist.id})');
      print('');

      // Get wishlist details
      print('Fetching wishlist details...');
      final wishlistDetail = await client.getWishlist(newWishlist.id);
      print('Wishlist: ${wishlistDetail.name}');
      print('Items: ${wishlistDetail.items?.length ?? 0}');
      if (wishlistDetail.items != null) {
        for (final item in wishlistDetail.items!) {
          print(
            '  - ${item.metaName} x${item.quantity}'
            '${item.blueprintId != null ? ' (Blueprint: ${item.blueprintId})' : ''}',
          );
        }
      }
      print('');

      // Delete the wishlist
      print('Deleting wishlist...');
      await client.deleteWishlist(newWishlist.id);
      print('Wishlist deleted.');
    } else {
      print('No blueprint available to create a wishlist.');
    }

    print('');

    sleep(Duration(seconds: 2));

    // ========== INVENTORY MANAGEMENT ==========
    print('=== Inventory Management ===');

    // Get your products
    print('Fetching your products...');
    final myProducts = await client.getMyProducts();
    print('Your products: ${myProducts.length}');
    for (final product in myProducts.take(5)) {
      print('- ${product.nameEn} (ID: ${product.id})');
      print(
        '  Price: ${product.price} ${product.priceCurrency} | Qty: ${product.quantity}',
      );
      print('  Blueprint ID: ${product.blueprintId}');
    }
    if (myProducts.length > 5) {
      print('  ... and ${myProducts.length - 5} more products');
    }
    print('');

    // Filter products by expansion
    if (expansions.isNotEmpty) {
      print('Fetching products for first expansion...');
      final filteredProducts = await client.getMyProducts(
        expansionId: expansions.first.id,
      );
      print('Products in expansion: ${filteredProducts.length}');
      print('');
    }

    // Create a product (requires a valid blueprint)
    if (sampleBlueprint != null) {
      print('Creating a product...');
      final newProduct = await client.createProduct(
        blueprintId: sampleBlueprint.id,
        price: 5.00,
        quantity: 3,
        description: 'Example product listing',
        properties: {'condition': 'Near Mint'},
      );
      print('Created product: ${sampleBlueprint.name} (ID: ${newProduct.id})');
      print('Price: ${newProduct.price} ${newProduct.priceCurrency}');
      print('');

      // Update the product
      print('Updating product price and quantity...');
      final updatedProduct = await client.updateProduct(
        id: newProduct.id,
        price: 6.50,
        quantity: 5,
        description: 'Updated description',
      );
      print('Updated product: ${updatedProduct.nameEn}');
      print(
        'New price: ${updatedProduct.price} ${updatedProduct.priceCurrency}',
      );
      print('New quantity: ${updatedProduct.quantity}');
      print('');

      // Increment product quantity
      print('Incrementing product quantity by 2...');
      final incrementedProduct = await client.incrementProduct(
        id: newProduct.id,
        deltaQuantity: 2,
      );
      print('Product quantity after increment: ${incrementedProduct.quantity}');
      print('');

      // Delete the product
      print('Deleting product...');
      await client.deleteProduct(newProduct.id);
      print('Product deleted.');
      print('');
    }

    // ========== BATCH OPERATIONS ==========
    print('=== Batch Operations ===');

    if (sampleBlueprint != null) {
      // Bulk create products
      print('Bulk creating products...');
      final createJobUuid = await client.bulkCreateProducts([
        ProductRequest(
          blueprintId: sampleBlueprint.id,
          price: 3.00,
          quantity: 1,
        ),
        ProductRequest(
          blueprintId: sampleBlueprint.id,
          price: 4.00,
          quantity: 2,
        ),
      ]);
      print('Bulk create job UUID: $createJobUuid');
      print('');

      sleep(Duration(seconds: 1));

      // Check job status
      print('Checking job status...');
      var job = await client.getJobStatus(createJobUuid);
      print('Job state: ${job.state}');
      print(
        'Stats: OK=${job.stats.ok}, Warning=${job.stats.warning}, Error=${job.stats.error}',
      );
      for (final result in job.results) {
        print(
          '  Result ${result.jobIndex}: ${result.result}'
          '${result.productId != null ? ' (Product ID: ${result.productId})' : ''}',
        );
      }
      print('');

      while (!job.isCompleted) {
        final previousState = job.state;
        print(
          'Job not completed yet. Waiting 5 seconds before checking again...',
        );
        await Future.delayed(Duration(seconds: 5));
        job = await client.getJobStatus(createJobUuid);
        if (job.state != previousState) {
          print('Job state changed: ${job.state}');
        } else {
          print('Job still in state: ${job.state}');
        }
      }

      // Bulk update products
      if (job.results.isNotEmpty) {
        final productIds = job.results
            .where((r) => r.productId != null)
            .map((r) => r.productId!)
            .toList();

        if (productIds.isNotEmpty) {
          print('Bulk updating products...');
          final updateJobUuid = await client.bulkUpdateProducts(
            productIds
                .map((id) => ProductUpdateRequest(id: id, price: 5.00))
                .toList(),
          );
          print('Bulk update job UUID: $updateJobUuid');
          print('');

          // Bulk delete products
          print('Bulk deleting products...');
          final deleteJobUuid = await client.bulkDeleteProducts(productIds);
          print('Bulk delete job UUID: $deleteJobUuid');
          print('');
        }
      }
    } else {
      print('No blueprint available for batch operations example.');
    }

    sleep(Duration(seconds: 2));

    // ========== ORDER MANAGEMENT ==========
    print('=== Order Management ===');

    // Get orders (as seller)
    print('Fetching orders as seller...');
    final sellerOrders = await client.getOrders(orderAs: OrderAs.seller);
    print(
      'Seller orders (page ${sellerOrders.page}): ${sellerOrders.items.length}',
    );
    for (final order in sellerOrders.items.take(5)) {
      print('- Order #${order.code} (ID: ${order.id})');
      print('  State: ${order.state} | Items: ${order.size}');
      print('  Via CT Zero: ${order.viaCardtraderZero}');
      if (order.buyer != null) {
        print('  Buyer: ${order.buyer!.username}');
      }
      if (order.sellerTotal != null) {
        print('  Seller total: ${order.sellerTotal!.formatted}');
      }
    }
    if (sellerOrders.items.length > 5) {
      print('  ... and ${sellerOrders.items.length - 5} more seller orders');
    }
    print('');

    // Get orders (as buyer)
    print('Fetching orders as buyer...');
    final buyerOrders = await client.getOrders(orderAs: OrderAs.buyer);
    print(
      'Buyer orders (page ${buyerOrders.page}): ${buyerOrders.items.length}',
    );
    for (final order in buyerOrders.items.take(5)) {
      print('- Order #${order.code} (ID: ${order.id})');
      print('  State: ${order.state} | Items: ${order.size}');
      print('  Via CT Zero: ${order.viaCardtraderZero}');
      if (order.seller != null) {
        print('  Seller: ${order.seller!.username}');
      }
      if (order.buyerTotal != null) {
        print('  Buyer total: ${order.buyerTotal!.formatted}');
      }
    }
    if (buyerOrders.items.length > 5) {
      print('  ... and ${buyerOrders.items.length - 5} more buyer orders');
    }
    print('');

    // Get order details
    final allOrders = [...sellerOrders.items, ...buyerOrders.items];
    if (allOrders.isNotEmpty) {
      final sampleOrder = allOrders.first;
      print('Fetching order details for #${sampleOrder.code}...');
      final orderDetail = await client.getOrder(sampleOrder.id);
      print('Order #${orderDetail.code}');
      print('  State: ${orderDetail.state}');
      print('  Role: ${orderDetail.orderAs}');
      if (orderDetail.paidAt != null) {
        print('  Paid at: ${orderDetail.paidAt}');
      }
      if (orderDetail.sentAt != null) {
        print('  Sent at: ${orderDetail.sentAt}');
      }
      if (orderDetail.orderShippingAddress != null) {
        final addr = orderDetail.orderShippingAddress!;
        print('  Shipping to: ${addr.name}, ${addr.city}, ${addr.countryCode}');
      }
      if (orderDetail.orderShippingMethod != null) {
        print('  Shipping method: ${orderDetail.orderShippingMethod!.name}');
      }
      print('  Items (${orderDetail.orderItems.length}):');
      for (final item in orderDetail.orderItems.take(5)) {
        print('    - ${item.name} x${item.quantity}');
        if (item.buyerPrice != null) {
          print('      Price: ${item.buyerPrice!.formatted}');
        }
      }
      if (orderDetail.orderItems.length > 5) {
        print('    ... and ${orderDetail.orderItems.length - 5} more items');
      }
    } else {
      print('No orders found.');
    }

    print('');

    sleep(Duration(seconds: 2));

    // ========== CT0 BOX ITEMS ==========
    print('=== CT0 Box Items ===');

    print('Fetching CT0 box items...');
    final ct0Items = await client.getCt0BoxItems();
    print('CT0 box items: ${ct0Items.length}');
    for (final item in ct0Items.take(5)) {
      print('- ${item.name} (ID: ${item.id})');
      print('  Expansion: ${item.expansion}');
      print('  Seller: ${item.seller.username}');
      print('  Price: ${item.buyerPrice.formatted}');
      print(
        '  Quantity: pending=${item.pendingQuantity}, ok=${item.okQuantity}, missing=${item.missingQuantity}',
      );
    }
    if (ct0Items.length > 5) {
      print('  ... and ${ct0Items.length - 5} more CT0 box items');
    }

    // Get CT0 box item details
    if (ct0Items.isNotEmpty) {
      final sampleCt0 = ct0Items.first;
      print('');
      print('Fetching CT0 box item details for "${sampleCt0.name}"...');
      final ct0Detail = await client.getCt0BoxItem(sampleCt0.id);
      print('CT0 Item: ${ct0Detail.name}');
      print('  Blueprint ID: ${ct0Detail.blueprintId}');
      print('  Category ID: ${ct0Detail.categoryId}');
      print('  Game ID: ${ct0Detail.gameId}');
      print('  Bundle size: ${ct0Detail.bundleSize}');
      print('  Graded: ${ct0Detail.graded}');
      print('  Paid at: ${ct0Detail.paidAt}');
      if (ct0Detail.estimatedArrivedAt != null) {
        print('  Estimated arrival: ${ct0Detail.estimatedArrivedAt}');
      }
      if (ct0Detail.arrivedAt != null) {
        print('  Arrived at: ${ct0Detail.arrivedAt}');
      }
      if (ct0Detail.properties.isNotEmpty) {
        print('  Properties: ${ct0Detail.properties}');
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
