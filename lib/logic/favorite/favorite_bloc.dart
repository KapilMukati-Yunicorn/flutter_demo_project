import 'package:bloc_project/data/local_data/local_data.dart';
import 'package:bloc_project/logic/favorite/favorite_event.dart';
import 'package:bloc_project/logic/favorite/favorite_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/navigation/navigation_service.dart';
import '../../core/widgets/common_widgets.dart';
import '../../data/models/get_product_model.dart';
import '../../routes/app_router.dart';
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  int _refreshCounter = 0;
  FavoriteBloc() : super(FavoriteState()) {
    on<AddRemoveProductToFavorite>(_onAddRemoveProductToFavorite);

    on<ClickOnFavoriteItem>(_onClickOnProductItem);
  }
  void _onAddRemoveProductToFavorite(
      AddRemoveProductToFavorite event,
      Emitter<FavoriteState> emit
      ) {
    final product = event.product;
    final updatedProduct = product.copyWith(isFavorite: !product.isFavorite);
    List<Product> updatedFavoriteItems = List.from(state.favoriteProducts);

    if (updatedProduct.isFavorite) {
      updatedFavoriteItems.add(updatedProduct);
      CommonWidgets.snackBarView(title: 'Product added to your favorite...', success: true);
    } else {
      updatedFavoriteItems.removeWhere((item) => item.id == product.id);
      CommonWidgets.snackBarView(title: 'Product removed from your favorite...', success: true);
    }

    // Optional: update local data if needed
    final localIndex = LocalData.productList.indexWhere((e) => e.id == product.id);
    if (localIndex != -1) {
      LocalData.productList[localIndex] = updatedProduct;
    }

    _refreshCounter++;
    emit(FavoriteListUpdated());
    emit(FavoriteState(favoriteProducts: updatedFavoriteItems, refreshKey: _refreshCounter));

  }


  void _onClickOnProductItem(ClickOnFavoriteItem event, Emitter<FavoriteState> emit){
    NavigationService.pushNamed(AppRoutes.productDetail,arguments:event.product);
  }
}
