
import 'package:bloc_project/data/models/get_address_model.dart';
import 'package:bloc_project/logic/delivery_address/delivery_address_event.dart';
import 'package:bloc_project/logic/delivery_address/delivery_address_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryAddressBloc extends Bloc<DeliveryAddressEvent,DeliveryAddressState>{
  DeliveryAddressBloc():super(DeliveryAddressState()){
    on<AddNewDeliveryAddress>(_addNewDeliveryAddress);
    on<RemoveDeliveryAddress>(_removeDeliveryAddress);
    on<UpdateDeliveryAddress>(_updateDeliveryAddress);
  }

  void _addNewDeliveryAddress(AddNewDeliveryAddress event, Emitter<DeliveryAddressState> emit){
    List<Address> updateAddressList = List.from(state.addressList);
    updateAddressList.add(event.address);
    emit(DeliveryAddressState(addressList: updateAddressList));
  }

  void _removeDeliveryAddress( RemoveDeliveryAddress event,Emitter<DeliveryAddressState> emit){
    final updatedAddress = state.addressList.where((item) => item.id!= event.addressId).toList();
    emit(DeliveryAddressState(addressList: updatedAddress));
  }

  void _updateDeliveryAddress(UpdateDeliveryAddress event,Emitter<DeliveryAddressState> emit){
    final existingIndex = state.addressList.indexWhere((item) => item.id == event.address.id);
    List<Address> currentAddressList = List.from(state.addressList);
    currentAddressList[existingIndex]=event.address;
    emit(DeliveryAddressState(addressList: currentAddressList));
  }
}
