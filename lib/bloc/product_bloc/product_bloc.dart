import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_model/product_model.dart';
import '../../repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductInitialState()) {
    on<FetchAllProducts>(_onFetchAllProducts);
    on<FetchCategoryProducts>(_onFetchCategoryProducts);
  }

  // Fetch all products
  Future<void> _onFetchAllProducts(FetchAllProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      final ProductModel productModel =
      await productRepository.fetchAllProducts(); // Ensure it returns a single ProductModel
      emit(ProductLoadedState(productModel.products ?? [])); // Extract the products list
    } catch (e) {
      emit(ProductErrorState("Failed to load products: ${e.toString()}"));
    }
  }

  // Fetch products by category
  Future<void> _onFetchCategoryProducts(FetchCategoryProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      final ProductModel productModel = await productRepository
          .fetchCategoryProducts(event.categorySlug); // Ensure it returns a single ProductModel
      emit(ProductLoadedState(productModel.products ?? [])); // Extract the products list
    } catch (e) {
      emit(ProductErrorState("Failed to load category products: ${e.toString()}"));
    }
  }
}


// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../models/product_model/products.dart';
// import '../../repositories/product_repository.dart';
// import 'product_event.dart';
// import 'product_state.dart';
//
// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   final ProductRepository productRepository;
//
//   ProductBloc({required this.productRepository}) : super(ProductInitialState()) {
//     on<FetchAllProducts>(_onFetchAllProducts);
//     on<FetchCategoryProducts>(_onFetchCategoryProducts);
//   }
//
//   // Fetch all products
//   Future<void> _onFetchAllProducts(FetchAllProducts event, Emitter<ProductState> emit) async {
//     emit(ProductLoadingState());
//     try {
//       final List<Product> products = await productRepository.fetchAllProducts();
//       emit(ProductLoadedState(products));
//     } catch (e) {
//       emit(ProductErrorState("Failed to load products: ${e.toString()}"));
//     }
//   }
//
//   // Fetch products by category
//   Future<void> _onFetchCategoryProducts(FetchCategoryProducts event, Emitter<ProductState> emit) async {
//     emit(ProductLoadingState());
//     try {
//       final List<Product> products = await productRepository.fetchCategoryProducts(event.categorySlug);
//       emit(ProductLoadedState(products));
//     } catch (e) {
//       emit(ProductErrorState("Failed to load category products: ${e.toString()}"));
//     }
//   }
// }


// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
// import '../../models/product_model/products.dart';
// import '../../repositories/product_repository.dart';
// import 'product_event.dart';
// import 'product_state.dart';
//
// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   final ProductRepository productRepository;
//   final Box<List<Product>> productCache = Hive.box<List<Product>>('productCache');
//
//   ProductBloc({required this.productRepository}) : super(ProductInitialState()) {
//     on<FetchAllProducts>(_onFetchAllProducts);
//     on<FetchCategoryProducts>(_onFetchCategoryProducts);
//   }
//
//   // Fetch all products
//   Future<void> _onFetchAllProducts(FetchAllProducts event, Emitter<ProductState> emit) async {
//     emit(ProductLoadingState());
//
//     try {
//       final cachedProducts = productCache.get('all_products');
//       if (cachedProducts != null && cachedProducts.isNotEmpty) {
//         emit(ProductLoadedState(cachedProducts));
//         return;
//       }
//
//       final List<Product> products = await productRepository.fetchAllProducts();
//
//       productCache.put('all_products', products);
//
//       emit(ProductLoadedState(products));
//     } catch (e) {
//       emit(ProductErrorState("Failed to load products: ${e.toString()}"));
//     }
//   }
//
//   // Fetch products by category
//   Future<void> _onFetchCategoryProducts(FetchCategoryProducts event, Emitter<ProductState> emit) async {
//     emit(ProductLoadingState());
//
//     try {
//       final cachedProducts = productCache.get(event.categorySlug);
//       if (cachedProducts != null && cachedProducts.isNotEmpty) {
//         emit(ProductLoadedState(cachedProducts));
//         return;
//       }
//
//       final List<Product> products = await productRepository.fetchCategoryProducts(event.categorySlug);
//
//       productCache.put(event.categorySlug, products);
//
//       emit(ProductLoadedState(products));
//     } catch (e) {
//       emit(ProductErrorState("Failed to load category products: ${e.toString()}"));
//     }
//   }
// }
