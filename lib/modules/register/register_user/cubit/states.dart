import 'package:cv_analyzer/models/Auth/register_model.dart';

abstract class RegisterUserStates{}

class RegisterUserInitialState extends RegisterUserStates{}

class RegisterUserLoadingState extends RegisterUserStates{}

class RegisterUserSuccessState extends RegisterUserStates{
  final RegisterModel registerModel;

  RegisterUserSuccessState(this.registerModel);
}

class RegisterUserErrorState extends RegisterUserStates{
  final String error;

  RegisterUserErrorState(this.error);
}

class RegisterUserChangePasswordVisibilityState extends RegisterUserStates{}



