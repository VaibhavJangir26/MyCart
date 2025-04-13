abstract class SearchProductEvent {}

class FetchSearchProducts extends SearchProductEvent {
  final String searchQuery;
  FetchSearchProducts(this.searchQuery);
}
