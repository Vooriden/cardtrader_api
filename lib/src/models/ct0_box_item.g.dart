// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ct0_box_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ct0BoxItem _$Ct0BoxItemFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Ct0BoxItem',
      json,
      ($checkedConvert) {
        final val = Ct0BoxItem(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          quantity: $checkedConvert(
              'quantity', (v) => Map<String, int>.from(v as Map)),
          seller: $checkedConvert(
              'seller', (v) => User.fromJson(v as Map<String, dynamic>)),
          productId: $checkedConvert('product_id', (v) => (v as num).toInt()),
          blueprintId:
              $checkedConvert('blueprint_id', (v) => (v as num).toInt()),
          categoryId: $checkedConvert('category_id', (v) => (v as num).toInt()),
          gameId: $checkedConvert('game_id', (v) => (v as num).toInt()),
          name: $checkedConvert('name', (v) => v as String),
          expansion: $checkedConvert('expansion', (v) => v as String),
          bundleSize:
              $checkedConvert('bundle_size', (v) => (v as num?)?.toInt()),
          description: $checkedConvert('description', (v) => v as String?),
          graded: $checkedConvert('graded', (v) => v as bool),
          properties:
              $checkedConvert('properties', (v) => v as Map<String, dynamic>),
          buyerPrice: $checkedConvert(
              'buyer_price', (v) => Money.fromJson(v as Map<String, dynamic>)),
          formattedPrice:
              $checkedConvert('formatted_price', (v) => v as String),
          mkmId: $checkedConvert('mkm_id', (v) => v),
          tcgPlayerId: $checkedConvert('tcg_player_id', (v) => v),
          scryfallId: $checkedConvert('scryfall_id', (v) => v as String?),
          presale: $checkedConvert('presale', (v) => v as bool?),
          presaleEndedAt: $checkedConvert('presale_ended_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
          paidAt:
              $checkedConvert('paid_at', (v) => DateTime.parse(v as String)),
          estimatedArrivedAt: $checkedConvert('estimated_arrived_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
          arrivedAt: $checkedConvert('arrived_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
          cancelledAt: $checkedConvert('cancelled_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
          returnToSeller:
              $checkedConvert('return_to_seller', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {
        'productId': 'product_id',
        'blueprintId': 'blueprint_id',
        'categoryId': 'category_id',
        'gameId': 'game_id',
        'bundleSize': 'bundle_size',
        'buyerPrice': 'buyer_price',
        'formattedPrice': 'formatted_price',
        'mkmId': 'mkm_id',
        'tcgPlayerId': 'tcg_player_id',
        'scryfallId': 'scryfall_id',
        'presaleEndedAt': 'presale_ended_at',
        'paidAt': 'paid_at',
        'estimatedArrivedAt': 'estimated_arrived_at',
        'arrivedAt': 'arrived_at',
        'cancelledAt': 'cancelled_at',
        'returnToSeller': 'return_to_seller'
      },
    );

Map<String, dynamic> _$Ct0BoxItemToJson(Ct0BoxItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'seller': instance.seller.toJson(),
      'product_id': instance.productId,
      'blueprint_id': instance.blueprintId,
      'category_id': instance.categoryId,
      'game_id': instance.gameId,
      'name': instance.name,
      'expansion': instance.expansion,
      if (instance.bundleSize case final value?) 'bundle_size': value,
      if (instance.description case final value?) 'description': value,
      'graded': instance.graded,
      'properties': instance.properties,
      'buyer_price': instance.buyerPrice.toJson(),
      'formatted_price': instance.formattedPrice,
      if (instance.mkmId case final value?) 'mkm_id': value,
      if (instance.tcgPlayerId case final value?) 'tcg_player_id': value,
      if (instance.scryfallId case final value?) 'scryfall_id': value,
      if (instance.presale case final value?) 'presale': value,
      if (instance.presaleEndedAt?.toIso8601String() case final value?)
        'presale_ended_at': value,
      'paid_at': instance.paidAt.toIso8601String(),
      if (instance.estimatedArrivedAt?.toIso8601String() case final value?)
        'estimated_arrived_at': value,
      if (instance.arrivedAt?.toIso8601String() case final value?)
        'arrived_at': value,
      if (instance.cancelledAt?.toIso8601String() case final value?)
        'cancelled_at': value,
      if (instance.returnToSeller case final value?) 'return_to_seller': value,
    };
