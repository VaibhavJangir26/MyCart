abstract class ProductEvent {}

class FetchAllProducts extends ProductEvent {}

class FetchCategoryProducts extends ProductEvent {
  final String categorySlug;
  FetchCategoryProducts(this.categorySlug);
}

class FetchSearchProducts extends ProductEvent{
  String searchQuery;
  FetchSearchProducts(this.searchQuery);
}

