import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable{

  @override
  List<Object?> get props => [];
}
 class PickUserProfile extends SignUpEvent{


 }
class UserNameChange extends SignUpEvent{
  final String userName;
  UserNameChange(this.userName);
  @override
  List<Object?> get props => [userName];
}
class EmailChange extends SignUpEvent{
  final String email;
  EmailChange(this.email);
  @override
  List<Object?> get props => [email];
}

class PasswordChange extends SignUpEvent{
  final String password;
  PasswordChange(this.password);

  @override
  List<Object?> get props => [password];
}

class CnfPasswordChange extends SignUpEvent{
  final String cnfPassword;
  CnfPasswordChange(this.cnfPassword);

  @override
  List<Object?> get props => [cnfPassword];
}

class ClickOnSignUpButton extends SignUpEvent {

}


class ClickOnLoginButton extends SignUpEvent {

}