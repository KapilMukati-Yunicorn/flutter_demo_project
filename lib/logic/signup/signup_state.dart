import 'dart:io';

import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String userName;
  final String email;
  final String password;
  final String cnfPassword;
  final File? userProfile;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const SignUpState({
    required this.userName,
    required this.email,
    required this.password,
    required this.cnfPassword,
    required this.userProfile,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory SignUpState.initial() {
    return SignUpState(
      userName: '',
      email: '',
      password: '',
      cnfPassword: '',
      userProfile: null,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignUpState copyWith({
    String? userName,
    String? email,
    String? password,
    String? cnfPassword,
    File? userProfile,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return SignUpState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      cnfPassword: cnfPassword ?? this.cnfPassword,
      userProfile: userProfile ?? this.userProfile,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object?> get props => [userName,email, password,cnfPassword, userProfile,isSubmitting, isSuccess, isFailure];
}
