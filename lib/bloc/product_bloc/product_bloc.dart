import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_model/product_model.dart';
import '../../models/product_model/products.dart';
import '../../repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  List<Product> allProducts = [];
  Map<String, List<Product>> categoryProducts = {};

  ProductBloc({required this.productRepository})
      : super(ProductInitialState()) {
    on<FetchAllProducts>(_onFetchAllProducts);
    on<FetchCategoryProducts>(_onFetchCategoryProducts);
  }

  // fetch all products
  Future<void> _onFetchAllProducts(
      FetchAllProducts event, Emitter<ProductState> emit) async {
    if (allProducts.isNotEmpty) {
      emit(ProductLoadedState(allProducts, categoryProducts));
      return;
    }

    emit(ProductLoadingState());
    try {
      final ProductModel productModel =
          await productRepository.fetchAllProducts();
      allProducts = productModel.products ?? [];
      emit(ProductLoadedState(allProducts, categoryProducts));
    } catch (e) {
      emit(ProductErrorState("failed to load products ${e.toString()}"));
    }
  }

  // fetch products by category
  Future<void> _onFetchCategoryProducts(
      FetchCategoryProducts event, Emitter<ProductState> emit) async {
    if (categoryProducts.containsKey(event.categorySlug)) {
      emit(ProductLoadedState(allProducts, categoryProducts));
      return;
    }

    emit(ProductLoadingState());
    try {
      final ProductModel productModel =
          await productRepository.fetchCategoryProducts(event.categorySlug);
      categoryProducts[event.categorySlug] = productModel.products ?? [];
      emit(ProductLoadedState(allProducts, categoryProducts));
    } catch (e) {
      emit(
          ProductErrorState("failed to load category products${e.toString()}"));
    }
  }
}
