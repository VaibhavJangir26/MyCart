import '../../models/product_model/products.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> allProducts;
  final Map<String, List<Product>> categoryProducts;

  ProductLoadedState(this.allProducts, this.categoryProducts);
}

class ProductErrorState extends ProductState {
  final String message;
  ProductErrorState(this.message);
}
