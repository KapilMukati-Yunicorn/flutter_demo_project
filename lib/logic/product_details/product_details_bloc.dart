import 'package:bloc_project/logic/cart/cart_bloc.dart';
import 'package:bloc_project/logic/product_details/product_details_event.dart';
import 'package:bloc_project/logic/product_details/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent,ProductDetailState>{

  ProductDetailBloc():super(ProductDetailInitial()){
    on<ProductLoaded>(_onProductLoaded);

  }

  void _onProductLoaded(ProductLoaded event, Emitter<ProductDetailState> emit) {
    emit(ProductDetailLoading());
    emit(ProductDetailLoaded(event.product));
  }


}