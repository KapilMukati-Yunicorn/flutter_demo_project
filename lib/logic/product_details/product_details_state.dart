import 'package:equatable/equatable.dart';

import '../../data/models/get_product_model.dart';

class ProductDetailState extends Equatable{
  
  @override
  List<Object?> get props => [];
}
class ProductDetailInitial extends ProductDetailState{

}
class ProductDetailLoading extends ProductDetailState{

}
class ProductDetailLoaded extends ProductDetailState{
  final Product product;
  ProductDetailLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductDetailError extends ProductDetailState{
  final String productDetailError;
  ProductDetailError(this.productDetailError);

  @override
  List<Object?> get props => [productDetailError];
}