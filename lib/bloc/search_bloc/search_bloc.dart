import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_model/index.dart';
import '../../repositories/product_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  final ProductRepository productRepository;
  final Map<String, List<Product>> searchCache = {};

  SearchProductBloc({required this.productRepository})
      : super(SearchProductInitialState()) {
    on<FetchSearchProducts>(_fetchSearchData);
  }

  Future<void> _fetchSearchData(
    FetchSearchProducts event,
    Emitter<SearchProductState> emit,
  ) async {
    final query = event.searchQuery.trim().toLowerCase();

    if (searchCache.containsKey(query)) {
      emit(SearchProductLoadedState(searchCache[query]!));
      return;
    }

    emit(SearchProductLoadingState());

    try {
      final model = await productRepository.searchTheProducts(query);
      final results = model.products ?? [];
      searchCache[query] = results;
      emit(SearchProductLoadedState(results));
    } catch (e) {
      emit(SearchProductErrorState("error${e.toString()}"));
    }
  }
}
