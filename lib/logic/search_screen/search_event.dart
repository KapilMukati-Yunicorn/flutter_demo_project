import 'package:bloc_project/data/models/get_product_model.dart';
import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object?> get props => [];
}

class LoadProducts extends SearchEvent {}

class SearchProduct extends SearchEvent {
  final String? query;
  const SearchProduct(this.query);
  @override
  List<Object?> get props => [query];
}

class OnClickProduct extends SearchEvent {
  final Product product;
  const OnClickProduct(this.product);
  @override
  List<Object?> get props => [product];
}
