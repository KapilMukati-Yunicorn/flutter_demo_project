import 'package:bloc_project/data/local_data/local_data.dart';
import 'package:bloc_project/data/models/get_product_model.dart';
import 'package:bloc_project/logic/search_screen/search_event.dart';
import 'package:bloc_project/logic/search_screen/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  int _refreshCounter = 0;
  SearchBloc() : super(SearchLoadingState()) {
    on<LoadProducts>((event, emit) {
      final updatedList = List<Product>.from(LocalData.productList);
      emit(
        state.copyWith(productList: updatedList, refreshKey: ++_refreshCounter),
      );
    });

    on<SearchProduct>((event, emit){
      final filteredList = LocalData.productList.where((product){
        final searchTitle = product.title.toLowerCase().contains(event.query!);
        final searchId = product.id.toString().contains(event.query!);
        final searchPrice = product.price.toStringAsFixed(2).contains(event.query!);

        return searchTitle || searchId || searchPrice;
      });
      
      emit(state.copyWith(productList: List.from(filteredList), refreshKey: ++_refreshCounter));
      
    });
  }
}
