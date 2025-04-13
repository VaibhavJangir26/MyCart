import '../../models/product_model/index.dart';

abstract class SearchProductState {}

class SearchProductInitialState extends SearchProductState {}

class SearchProductLoadingState extends SearchProductState {}

class SearchProductLoadedState extends SearchProductState {
  final List<Product> results;

  SearchProductLoadedState(this.results);
}

class SearchProductErrorState extends SearchProductState {
  final String errorMsg;
  SearchProductErrorState(this.errorMsg);
}
