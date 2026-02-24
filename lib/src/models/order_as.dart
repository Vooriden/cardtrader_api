/// Represents the role of the authenticated user in an order.
enum OrderAs {
  /// The authenticated user is the seller.
  seller('seller'),

  /// The authenticated user is the buyer.
  buyer('buyer');

  /// Creates an [OrderAs] enum from a string value.
  const OrderAs(this.value);

  /// The string value sent to the API.
  final String value;
}
