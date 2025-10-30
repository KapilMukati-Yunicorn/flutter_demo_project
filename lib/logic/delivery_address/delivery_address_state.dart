import 'package:bloc_project/data/models/get_address_model.dart';
import 'package:equatable/equatable.dart';

class DeliveryAddressState extends Equatable{
  final List<Address> addressList;
  const DeliveryAddressState({this.addressList=const []});

  @override
  List<Object?> get props => [addressList];
}