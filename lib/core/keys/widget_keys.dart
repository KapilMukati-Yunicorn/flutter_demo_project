import 'package:flutter/widgets.dart';

class WidgetKeys {
  // Login
  static const loginEmailField = Key("login_emailField");
  static const loginPasswordField = Key("login_passwordField");
  static const loginLoading = Key("login_loading");
  static const loginButton = Key("login_loginButton");
  static const loginSignupButton = Key("login_SignUpButton");

  // Signup
  static const signupNameField = Key("signup_nameField");
  static const signupEmailField = Key("signup_emailField");
  static const signupPasswordField = Key("signup_passwordField");
  static const signupCnfPasswordField = Key("signup_cnfPasswordField");
  static const signupLoadingButton = Key("signup_loadingButton");
  static const signupButton = Key("signup_signupButton");

  //NavBar
  static const bottomNavBar = Key("bottom_nav_bar");
}
