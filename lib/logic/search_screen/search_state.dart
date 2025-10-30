import 'package:bloc_project/data/models/get_product_model.dart';
import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  final List<Product> productList;
  final int refreshKey;
  const SearchState({this.productList = const [], this.refreshKey = 0});

  SearchState copyWith({List<Product>? productList, int? refreshKey}) {
    return SearchState(
      productList: productList ?? this.productList,
      refreshKey: refreshKey ?? this.refreshKey,
    );
  }

  @override
  List<Object?> get props => [productList, refreshKey];
}

class SearchLoadingState extends SearchState {}

class SearchErrorState extends SearchState {
  final String searchError;
  const SearchErrorState(this.searchError);

  @override
  List<Object?> get props => [searchError];
}
