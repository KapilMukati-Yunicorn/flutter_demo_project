import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{

  @override
  List<Object?> get props => [];

}

class EmailChange extends LoginEvent{
  final String email;
   EmailChange(this.email);
  @override
  List<Object?> get props => [email];
}

class PasswordChange extends LoginEvent{
  final String password;
  PasswordChange(this.password);

  @override
  List<Object?> get props => [password];
}

class ClickOnLoginButton extends LoginEvent {

}


class ClickOnSignUpButton extends LoginEvent {

}