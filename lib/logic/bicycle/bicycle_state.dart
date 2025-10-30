import 'package:bloc_project/data/models/get_product_model.dart';
import 'package:equatable/equatable.dart';

class BiCycleState extends Equatable {
  final List<Product> biCycleList;
  final int refreshKey;
  const BiCycleState({this.biCycleList = const [], this.refreshKey = 0});
  @override
  List<Object?> get props => [biCycleList, refreshKey];
}

class BiCycleLoading extends BiCycleState {}

class BiCycleError extends BiCycleState {
  final String biCycleError;
  const BiCycleError(this.biCycleError);

  @override
  List<Object?> get props => [biCycleError];
}
