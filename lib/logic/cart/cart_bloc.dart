import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:bloc_project/data/models/get_product_model.dart';
import 'package:bloc_project/logic/cart/cart_event.dart';
import 'package:bloc_project/logic/cart/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent,CartState>{

  CartBloc():super(CartState()){
    on<AddProductToCart>(_onAddProduct);
    on<RemoveProductFromCart>(_removeProductFromCart);
    on<IncreaseQuantity>(_increaseQuantity);
    on<DecreaseQuantity>(_decreaseQuantity);
  }


  void _onAddProduct(AddProductToCart event, Emitter<CartState> emit) {
    final existingIndex = state.cartItems.indexWhere((item) => item.id == event.product.id);
    List<Product> updatedItems = List.from(state.cartItems);

    if (existingIndex != -1) {
      // Product already in cart → Increase Quantity
      final existingProduct = updatedItems[existingIndex];
      updatedItems[existingIndex] = existingProduct.copyWith(quantity: existingProduct.quantity + 1);
    } else {
      // Product not in cart → Add to cart with quantity = 1
      updatedItems.add(event.product.copyWith(quantity: 1));
    }

    emit(CartState(cartItems: updatedItems));
    CommonWidgets.snackBarView(title: 'Product added to your cart...', success: true);
  }


  void _removeProductFromCart(RemoveProductFromCart event,Emitter<CartState> emit){
    final updatedItems = state.cartItems.where((item) => item.id!= event.productId).toList();
    emit(CartState(cartItems: updatedItems));

  }
  void _increaseQuantity(IncreaseQuantity event, Emitter<CartState> emit) {
    List<Product> updatedItems = state.cartItems.map((item) {
      if (item.id == event.productId) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();

    emit(CartState(cartItems: updatedItems));
  }

  void _decreaseQuantity(DecreaseQuantity event, Emitter<CartState> emit) {
    List<Product> updatedItems = state.cartItems.map((item) {
      if (item.id == event.productId && item.quantity > 1) {
        return item.copyWith(quantity: item.quantity - 1);
      }
      return item;
    }).toList();

    emit(CartState(cartItems: updatedItems));
  }
}