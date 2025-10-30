import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AddAddressEvent extends Equatable {
  const AddAddressEvent();

  @override
  List<Object?> get props => [];
}

/// Generic update event for any field
class AddressUpdated extends AddAddressEvent {
  final String? type;
  final String? address;
  final String? houseNumber;
  final String? city;
  final String? pinCode;
  final String? state;

  const AddressUpdated({
    this.type,
    this.address,
    this.houseNumber,
    this.city,
    this.pinCode,
    this.state,
  });

  @override
  List<Object?> get props =>
      [type, address, houseNumber, city, pinCode, state];
}

class ClickOnAddNewAddressButton extends AddAddressEvent{
   final int currentLength;
   const ClickOnAddNewAddressButton(this.currentLength);
   @override
  List<Object?> get props => [currentLength];
}