import 'package:cardtrader_api/src/models/order.dart';
import 'package:test/test.dart';

void main() {
  group('OrderItem', () {
    final json = {
      'id': 4094425,
      'product_id': 105115992,
      'blueprint_id': 156809,
      'category_id': 80,
      'game_id': 6,
      'name': 'Celestial Cataclysm',
      'expansion': 'Monarch',
      'properties': {
        'condition': 'Near Mint',
        'fab_language': 'en',
        'fab_foil': true,
      },
      'quantity': 1,
      'bundle_size': 1,
      'description': 'Test item',
      'seller_price': {'cents': 1500, 'currency': 'EUR'},
      'buyer_price': {'cents': 1500, 'currency': 'EUR'},
      'cancelled_price': [
        {'cents': -1500, 'currency': 'EUR'},
      ],
      'repurchase_price': [
        {'cents': -23, 'currency': 'EUR'},
      ],
      'tag': 'sale',
      'graded': false,
      'formatted_price': '€15.00',
      'mkm_id': '12345',
      'user_data_field': 'shelf-A1',
      'tcg_player_id': '67890',
      'scryfall_id': 'd573ef03-4730-45aa-93dd-e45ac1dbaf4a',
      'deleted_at': null,
      'created_at': '2021-09-20T15:16:00.000Z',
      'hub_pending_order_id': 733733,
    };

    group('fromJson', () {
      test('parses all fields correctly', () {
        final item = OrderItem.fromJson(json);

        expect(item.id, 4094425);
        expect(item.productId, 105115992);
        expect(item.blueprintId, 156809);
        expect(item.categoryId, 80);
        expect(item.gameId, 6);
        expect(item.name, 'Celestial Cataclysm');
        expect(item.expansion, 'Monarch');
        expect(item.properties['condition'], 'Near Mint');
        expect(item.quantity, 1);
        expect(item.bundleSize, 1);
        expect(item.description, 'Test item');
        expect(item.sellerPrice, isNotNull);
        expect(item.sellerPrice!.cents, 1500);
        expect(item.buyerPrice, isNotNull);
        expect(item.buyerPrice!.cents, 1500);
        expect(item.cancelledPrice, isNotNull);
        expect(item.cancelledPrice!.length, 1);
        expect(item.cancelledPrice!.first.cents, -1500);
        expect(item.repurchasePrice, isNotNull);
        expect(item.repurchasePrice!.length, 1);
        expect(item.tag, 'sale');
        expect(item.graded, false);
        expect(item.formattedPrice, '€15.00');
        expect(item.mkmId, '12345');
        expect(item.userDataField, 'shelf-A1');
        expect(item.tcgPlayerId, '67890');
        expect(item.scryfallId, 'd573ef03-4730-45aa-93dd-e45ac1dbaf4a');
        expect(item.deletedAt, isNull);
        expect(item.createdAt, DateTime.parse('2021-09-20T15:16:00.000Z'));
        expect(item.hubPendingOrderId, 733733);
      });

      test('handles minimal JSON with defaults', () {
        final minimalJson = {
          'id': 1,
          'product_id': 2,
          'blueprint_id': 3,
          'category_id': 4,
          'game_id': 5,
          'name': 'Test',
          'expansion': 'Set',
          'properties': <String, dynamic>{},
          'quantity': 1,
          'bundle_size': 1,
          'created_at': '2021-01-01T00:00:00.000Z',
        };

        final item = OrderItem.fromJson(minimalJson);

        expect(item.description, '');
        expect(item.tag, '');
        expect(item.graded, false);
        expect(item.sellerPrice, isNull);
        expect(item.buyerPrice, isNull);
        expect(item.cancelledPrice, isNull);
        expect(item.repurchasePrice, isNull);
        expect(item.formattedPrice, isNull);
        expect(item.hubPendingOrderId, isNull);
      });
    });

    group('toJson', () {
      test('serializes and deserializes correctly', () {
        final item = OrderItem.fromJson(json);
        final serialized = item.toJson();

        expect(serialized['id'], 4094425);
        expect(serialized['product_id'], 105115992);
        expect(serialized['blueprint_id'], 156809);
        expect(serialized['name'], 'Celestial Cataclysm');
        expect(serialized['tag'], 'sale');

        // Roundtrip
        final item2 = OrderItem.fromJson(serialized);
        expect(item2.id, item.id);
        expect(item2.name, item.name);
        expect(item2.productId, item.productId);
      });
    });
  });

  group('Order', () {
    final orderJson = {
      'id': 733733,
      'code': '202109213e70f5',
      'transaction_code': 'TXN-2021-001',
      'via_cardtrader_zero': true,
      'order_as': 'seller',
      'buyer': {'id': 12345, 'username': 'buyer_user', 'country_code': 'AT'},
      'cancel_requester': null,
      'state': 'hub_pending',
      'size': 1,
      'paid_at': null,
      'credit_added_to_seller_at': '2021-09-21T16:16:00.000Z',
      'sent_at': null,
      'cancelled_at': null,
      'presale_ended_at': null,
      'fee_percentage': '5.0',
      'packing_number': 11,
      'order_shipping_address': {
        'id': 1503007,
        'name': 'John Doe',
        'street': 'Via Roma 1',
        'zip': '50143',
        'city': 'Firenze',
        'state_or_province': 'FI',
        'country_code': 'IT',
        'country': 'Italy',
      },
      'order_billing_address': null,
      'seller_total': {'cents': 1500, 'currency': 'EUR'},
      'fee_amount': {'cents': 75, 'currency': 'EUR'},
      'seller_fee_amount': {'cents': 75, 'currency': 'EUR'},
      'seller_subtotal': {'cents': 1425, 'currency': 'EUR'},
      'formatted_subtotal': '€14.25',
      'formatted_total': '€15.00',
      'presale': null,
      'order_shipping_method': {
        'id': 463937,
        'name': 'Priority Letter',
        'tracked': false,
        'tracking_code': null,
        'max_estimate_shipping_days': 14,
        'seller_price': {'cents': 150, 'currency': 'EUR'},
        'buyer_price': {'cents': 178, 'currency': 'EUR'},
        'formatted_price': '€1.50',
      },
      'order_items': [
        {
          'id': 4094425,
          'product_id': 105115992,
          'blueprint_id': 156809,
          'category_id': 80,
          'game_id': 6,
          'name': 'Celestial Cataclysm',
          'expansion': 'Monarch',
          'properties': {'condition': 'Near Mint'},
          'quantity': 1,
          'bundle_size': 1,
          'description': '',
          'seller_price': {'cents': 1500, 'currency': 'EUR'},
          'tag': '',
          'graded': false,
          'created_at': '2021-09-20T15:16:00.000Z',
        },
      ],
    };

    group('fromJson', () {
      test('parses order correctly with all fields', () {
        final order = Order.fromJson(orderJson);

        expect(order.id, 733733);
        expect(order.code, '202109213e70f5');
        expect(order.transactionCode, 'TXN-2021-001');
        expect(order.viaCardtraderZero, true);
        expect(order.orderAs, 'seller');
        expect(order.buyer, isNotNull);
        expect(order.buyer!.username, 'buyer_user');
        expect(order.seller, isNull);
        expect(order.cancelRequester, isNull);
        expect(order.state, 'hub_pending');
        expect(order.size, 1);
        expect(order.paidAt, isNull);
        expect(
          order.creditAddedToSellerAt,
          DateTime.parse('2021-09-21T16:16:00.000Z'),
        );
        expect(order.sentAt, isNull);
        expect(order.cancelledAt, isNull);
        expect(order.feePercentage, '5.0');
        expect(order.packingNumber, 11);
        expect(order.orderShippingAddress, isNotNull);
        expect(order.orderShippingAddress!.city, 'Firenze');
        expect(order.orderBillingAddress, isNull);
        expect(order.sellerTotal, isNotNull);
        expect(order.sellerTotal!.cents, 1500);
        expect(order.feeAmount!.cents, 75);
        expect(order.sellerFeeAmount!.cents, 75);
        expect(order.sellerSubtotal!.cents, 1425);
        expect(order.formattedSubtotal, '€14.25');
        expect(order.formattedTotal, '€15.00');
        expect(order.presale, isNull);
        expect(order.orderShippingMethod, isNotNull);
        expect(order.orderShippingMethod!.name, 'Priority Letter');
        expect(order.orderShippingMethod!.tracked, false);
        expect(order.orderItems.length, 1);
        expect(order.orderItems.first.name, 'Celestial Cataclysm');
      });

      test('handles order with buyer role', () {
        final buyerOrderJson = {
          'id': 733734,
          'code': '202109223e70f6',
          'via_cardtrader_zero': false,
          'order_as': 'buyer',
          'seller': {'id': 67890, 'username': 'seller_shop'},
          'state': 'paid',
          'size': 2,
          'paid_at': '2021-09-22T10:00:00.000Z',
          'buyer_total': {'cents': 2000, 'currency': 'EUR'},
          'buyer_subtotal': {'cents': 1800, 'currency': 'EUR'},
          'formatted_subtotal': '€18.00',
          'formatted_total': '€20.00',
          'presale': false,
          'order_items': [
            {
              'id': 1,
              'product_id': 2,
              'blueprint_id': 3,
              'category_id': 4,
              'game_id': 5,
              'name': 'Test Card',
              'expansion': 'Set',
              'properties': <String, dynamic>{},
              'quantity': 2,
              'bundle_size': 1,
              'buyer_price': {'cents': 900, 'currency': 'EUR'},
              'created_at': '2021-09-22T10:00:00.000Z',
            },
          ],
        };

        final order = Order.fromJson(buyerOrderJson);

        expect(order.orderAs, 'buyer');
        expect(order.seller, isNotNull);
        expect(order.seller!.username, 'seller_shop');
        expect(order.buyer, isNull);
        expect(order.buyerTotal, isNotNull);
        expect(order.buyerTotal!.cents, 2000);
        expect(order.buyerSubtotal, isNotNull);
        expect(order.presale, false);
      });
    });

    group('state helpers', () {
      test('isPaid returns true for paid state', () {
        final order = Order.fromJson({...orderJson, 'state': 'paid'});
        expect(order.isPaid, true);
        expect(order.isSent, false);
        expect(order.isHubPending, false);
      });

      test('isSent returns true for sent state', () {
        final order = Order.fromJson({...orderJson, 'state': 'sent'});
        expect(order.isSent, true);
        expect(order.isPaid, false);
      });

      test('isHubPending returns true for hub_pending state', () {
        final order = Order.fromJson({...orderJson, 'state': 'hub_pending'});
        expect(order.isHubPending, true);
      });

      test('isArrived returns true for arrived state', () {
        final order = Order.fromJson({...orderJson, 'state': 'arrived'});
        expect(order.isArrived, true);
      });

      test('isDone returns true for done state', () {
        final order = Order.fromJson({...orderJson, 'state': 'done'});
        expect(order.isDone, true);
      });

      test('isCanceled returns true for canceled state', () {
        final order = Order.fromJson({...orderJson, 'state': 'canceled'});
        expect(order.isCanceled, true);
      });

      test('isRequestForCancel returns true for request_for_cancel state', () {
        final order = Order.fromJson({
          ...orderJson,
          'state': 'request_for_cancel',
        });
        expect(order.isRequestForCancel, true);
      });

      test('isLost returns true for lost state', () {
        final order = Order.fromJson({...orderJson, 'state': 'lost'});
        expect(order.isLost, true);
      });
    });

    group('toJson', () {
      test('roundtrip serialization', () {
        final order = Order.fromJson(orderJson);
        final serialized = order.toJson();

        expect(serialized['id'], 733733);
        expect(serialized['code'], '202109213e70f5');
        expect(serialized['via_cardtrader_zero'], true);
        expect(serialized['order_as'], 'seller');
        expect(serialized['state'], 'hub_pending');

        // Roundtrip
        final order2 = Order.fromJson(serialized);
        expect(order2.id, order.id);
        expect(order2.code, order.code);
        expect(order2.state, order.state);
        expect(order2.orderItems.length, order.orderItems.length);
      });
    });
  });
}
