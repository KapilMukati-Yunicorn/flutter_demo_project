import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/data/local_data/local_data.dart';
import 'package:bloc_project/logic/bicycle/bicycle_event.dart';
import 'package:bloc_project/logic/bicycle/bicycle_state.dart';
import 'package:bloc_project/routes/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/get_product_model.dart';

class BiCycleBloc extends Bloc<BiCycleEvent, BiCycleState> {
  int _refreshCounter = 0;
  BiCycleBloc() : super(BiCycleLoading()) {
    on<LoadProducts>((event, emit) {
      _refreshCounter++;
      final updatedList = List<Product>.from(LocalData.productList);
      emit(BiCycleState(biCycleList: updatedList, refreshKey: _refreshCounter));
    });

    on<ClickOnProductItem>((event, emit) {
      NavigationService.pushNamed(
        AppRoutes.productDetail,
        arguments: event.product,
      );
    });

    on<SearchProduct>((event, emit) {
      final filteredList = LocalData.productList.where((product) {
        final searchTitle = product.title.toLowerCase().contains(event.query!);
        final searchId = product.id.toString().contains(event.query!);
        final searchPrice = product.price
            .toStringAsFixed(2)
            .contains(event.query!);

        return searchTitle || searchId || searchPrice;
      });

      emit(
        BiCycleState(
          biCycleList: List.from(filteredList),
          refreshKey: ++_refreshCounter,
        ),
      );
    });
  }
}
