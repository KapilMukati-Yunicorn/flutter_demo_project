import 'package:bloc_project/data/models/get_product_model.dart';
import 'package:equatable/equatable.dart';

class OrderHistoryState extends Equatable{
  final List<Product> orderHistoryList;
  const OrderHistoryState({this.orderHistoryList=const []});

  @override
  List<Object?> get props => [orderHistoryList];
}