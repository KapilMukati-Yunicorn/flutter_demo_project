import 'package:equatable/equatable.dart';

import '../../data/models/get_product_model.dart';

class FavoriteState extends Equatable{
  final int refreshKey;
  final List<Product> favoriteProducts;
  const FavoriteState({this.favoriteProducts=const [],this.refreshKey=0});

  @override
  List<Object?> get props => [favoriteProducts,refreshKey];

}
class FavoriteListUpdated extends FavoriteState{

}