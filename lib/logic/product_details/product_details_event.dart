import 'package:equatable/equatable.dart';

import '../../data/models/get_product_model.dart';

abstract class ProductDetailEvent extends Equatable{
  const ProductDetailEvent();

  @override
  List<Object?> get props => [];
}

class ProductLoaded extends ProductDetailEvent{
  final Product product;
  const ProductLoaded(this.product);

  @override
  List<Object?> get props => [product];

}
