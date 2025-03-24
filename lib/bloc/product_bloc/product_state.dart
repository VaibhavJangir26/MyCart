import '../../models/product_model/products.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> products;
  ProductLoadedState(this.products);
}

class ProductErrorState extends ProductState {
  final String message;
  ProductErrorState(this.message);
}
