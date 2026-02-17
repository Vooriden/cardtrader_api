/// A paginated response wrapper.
///
/// Contains the items for the current page along with
/// pagination metadata ([page] and [limit]).
class PaginatedResponse<T> {
  /// The current page number (1-based).
  final int page;

  /// The maximum number of items per page.
  final int limit;

  /// The items in this page.
  final List<T> items;

  /// Constructs a [PaginatedResponse] with the given details.
  PaginatedResponse({
    required this.page,
    required this.limit,
    required this.items,
  });
}
