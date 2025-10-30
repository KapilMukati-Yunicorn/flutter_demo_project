import 'package:bloc_project/data/models/get_product_model.dart';
import 'package:equatable/equatable.dart';

abstract class BiCycleEvent extends Equatable {
  const BiCycleEvent();
  @override
  List<Object?> get props => [];
}

class LoadProducts extends BiCycleEvent {}

class ClickOnProductItem extends BiCycleEvent {
  final Product product;
  const ClickOnProductItem(this.product);

  @override
  List<Object?> get props => [product];
}
