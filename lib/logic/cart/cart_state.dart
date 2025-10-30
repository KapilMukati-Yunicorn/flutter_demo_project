import 'package:bloc_project/data/models/get_product_model.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final List<Product> cartItems;

  const CartState({this.cartItems = const []});

  @override
  List<Object?> get props => [cartItems];

  double get totalPrice {
    return cartItems.fold(0.0, (total, item) {
      return total + (item.price * item.quantity);
    });
  }
}
