import 'package:cv_analyzer/models/Auth/login_model.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates{
  LoginModel loginModel;
  LoginErrorState(this.loginModel);
}

class ChangePasswordVisibilityState extends LoginStates{}