import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/data/models/get_address_model.dart';
import 'package:bloc_project/logic/add_address/add_address_event.dart';
import 'package:bloc_project/logic/add_address/add_address_state.dart';
import 'package:bloc_project/logic/delivery_address/delivery_address_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../delivery_address/delivery_address_event.dart';

class AddAddressBloc extends Bloc<AddAddressEvent,AddAddressState>{
  AddAddressBloc() : super(AddAddressState.initial()) {
    on<AddressUpdated>((event, emit) {
      emit(state.copyWith(
        type: event.type ?? state.type,
        address: event.address ?? state.address,
        houseNumber: event.houseNumber ?? state.houseNumber,
        city: event.city ?? state.city,
        pinCode: event.pinCode ?? state.pinCode,
        state: event.state ?? state.state,
      ));
    });
    on<ClickOnAddNewAddressButton>(_clickOnAddressButton);
  }

  void _clickOnAddressButton(ClickOnAddNewAddressButton event,Emitter<AddAddressState> emit) async{
    emit(state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false));
    try {
      await Future.delayed(const Duration(seconds: 2));
      Address address=Address(
          id: event.currentLength+1,
          type: state.type,
          address: state.address,
          houseNumber: state.houseNumber,
          city: state.city,
          pinCode: state.pinCode,
          state: state.state);
      NavigationService.navigatorKey.currentContext!.read<DeliveryAddressBloc>().add(AddNewDeliveryAddress(address));
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
      ));
    } catch (_) {
      emit(state.copyWith(
        isSubmitting: false,
        isFailure: true,
      ));
    }
  }

}