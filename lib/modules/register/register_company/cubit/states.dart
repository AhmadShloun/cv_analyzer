import 'package:cv_analyzer/models/Auth/register_model.dart';

abstract class RegisterCompanyStates{}

class RegisterCompanyInitialState extends RegisterCompanyStates{}

class RegisterCompanyLoadingState extends RegisterCompanyStates{}

class RegisterCompanySuccessState extends RegisterCompanyStates{
  final RegisterModel registerModel;

  RegisterCompanySuccessState(this.registerModel);
}

class RegisterCompanyErrorState extends RegisterCompanyStates{
  final String error;

  RegisterCompanyErrorState(this.error);
}

class RegisterCompanyChangePasswordVisibilityState extends RegisterCompanyStates{}



