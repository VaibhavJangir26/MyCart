import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_model/index.dart';
import '../../repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  List<Product> allProducts = [];

  Map<String, List<Product>> categoryProducts = {};


  final Map<String, List<Product>> searchCache = {};

  ProductBloc({required this.productRepository})
      : super(ProductInitialState()) {
    on<FetchAllProducts>(onFetchAllProducts);
    on<FetchCategoryProducts>(onFetchCategoryProducts);
    on<FetchSearchProducts>(onSearching);
  }

  // fetch all products
  Future<void> onFetchAllProducts(FetchAllProducts event,
      Emitter<ProductState> emit) async {
    if (allProducts.isNotEmpty) {
      emit(ProductLoadedState(allProducts, categoryProducts));
    }
    emit(ProductLoadingState());
    try {
      final ProductModel productModel =
      await productRepository.fetchAllProducts();
      allProducts = productModel.products ?? [];
      emit(ProductLoadedState(allProducts, categoryProducts));
    } catch (e) {
      emit(ProductErrorState("error in all products ${e.toString()}"));
    }
  }

  // fetch products by category
  Future<void> onFetchCategoryProducts(FetchCategoryProducts event,
      Emitter<ProductState> emit) async {
    if (categoryProducts.containsKey(event.categorySlug)) {
      emit(ProductLoadedState(allProducts, categoryProducts));
    }

    emit(ProductLoadingState());
    try {
      final ProductModel productModel =
      await productRepository.fetchCategoryProducts(event.categorySlug);
      categoryProducts[event.categorySlug] = productModel.products ?? [];
      emit(ProductLoadedState(allProducts, categoryProducts));
    } catch (e) {
      emit(ProductErrorState("error in category ${e.toString()}"));
    }
  }

// for searching the product based on tag in the api data
  Future<void> onSearching(FetchSearchProducts event,
      Emitter<ProductState> emit) async {
    final query = event.searchQuery.trim().toLowerCase();

    emit(ProductLoadingState());

    try {
      final ProductModel productModel = await productRepository
          .searchTheProducts(query);
      final List<Product> searchedProducts = productModel.products ?? [];

      searchCache[query] = searchedProducts;

      emit(ProductSearchState(searchedProducts));
    } catch (e) {
      emit(ProductErrorState("error in search${e.toString()}"));
    }
  }
}