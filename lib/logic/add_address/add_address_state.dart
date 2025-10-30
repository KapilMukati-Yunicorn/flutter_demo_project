import 'package:equatable/equatable.dart';

class AddAddressState extends Equatable {
  final String type;
  final String address;
  final String houseNumber;
  final String city;
  final String pinCode;
  final String state;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const AddAddressState({
    required this.type,
    required this.address,
    required this.houseNumber,
    required this.city,
    required this.pinCode,
    required this.state,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory AddAddressState.initial() {
    return const AddAddressState(
      type: '',
      address: '',
      houseNumber: '',
      city: '',
      pinCode: '',
      state: '',
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  AddAddressState copyWith({
    String? type,
    String? address,
    String? houseNumber,
    String? city,
    String? pinCode,
    String? state,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return AddAddressState(
      type: type ?? this.type,
      address: address ?? this.address,
      houseNumber: houseNumber ?? this.houseNumber,
      city: city ?? this.city,
      pinCode: pinCode ?? this.pinCode,
      state: state ?? this.state,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object?> get props =>
      [type, address, houseNumber, city, pinCode, state, isSubmitting, isSuccess, isFailure];
}
