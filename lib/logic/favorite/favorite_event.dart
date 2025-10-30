import 'package:equatable/equatable.dart';

import '../../data/models/get_product_model.dart';

abstract class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddRemoveProductToFavorite extends FavoriteEvent {
  final Product product;
   AddRemoveProductToFavorite(this.product);

  @override
  List<Object?> get props => [product];
}


class ClickOnFavoriteItem extends FavoriteEvent{
  final Product product;
  ClickOnFavoriteItem(this.product);
  @override
  List<Object?> get props => [product];

}


