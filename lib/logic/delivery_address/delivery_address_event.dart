import 'package:bloc_project/data/models/get_address_model.dart';
import 'package:equatable/equatable.dart';

abstract class DeliveryAddressEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class AddNewDeliveryAddress extends DeliveryAddressEvent {
  final Address address;

  AddNewDeliveryAddress(this.address);

  @override
  List<Object?> get props => [address];
}
class UpdateDeliveryAddress extends DeliveryAddressEvent {
  final Address address;

  UpdateDeliveryAddress(this.address);

  @override
  List<Object?> get props => [address];
}

class RemoveDeliveryAddress extends DeliveryAddressEvent {
  final int addressId;

  RemoveDeliveryAddress(this.addressId);

  @override
  List<Object?> get props => [addressId];
}


class ClearAddress extends DeliveryAddressEvent {}
