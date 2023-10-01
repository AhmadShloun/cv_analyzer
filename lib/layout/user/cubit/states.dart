// ignore_for_file: camel_case_types

import 'package:cv_analyzer/models/Auth/login_model.dart';
import 'package:cv_analyzer/models/Auth/logout_model.dart';
import 'package:cv_analyzer/models/user/user_single_job.dart';

abstract class UserStates{}

class UserInitialState extends UserStates{}
//----------Logout User---------
class LogoutUserLoadingState extends UserStates{}
class LogoutUserSuccessState extends UserStates{
  final LogoutModel logoutModel;
  LogoutUserSuccessState(this.logoutModel);
}
class LogoutUserErrorState extends UserStates{
  final LogoutModel logoutModel;

  LogoutUserErrorState(this.logoutModel);
}

//-------Job All User Data-------
class UserLoadingAllJobDataState extends UserStates{}
class UserSuccessAllJobDataState extends UserStates{}
class UserErrorAllJobDataState extends UserStates{}


//-------Job Single User Data-------
class UserLoadingSingleJobDataState extends UserStates{}
class UserSuccessSingleJobDataState extends UserStates{
  final UserSingleJobModel userSingleJobModel;
  UserSuccessSingleJobDataState(this.userSingleJobModel);
}
class UserErrorSingleJobDataState extends UserStates{}

//-------------Selecte PDF----------------
class selcetFilePDF extends UserStates{}
//------UPDATE PROFILE USER---------
class UserUpdateProfileLoadingState extends UserStates{}
class UserUpdateProfileSuccessState extends UserStates{
  final LoginModel loginModel;
  UserUpdateProfileSuccessState(this.loginModel);
}
class UserUpdateProfileErrorState extends UserStates{
  final LoginModel loginModel;
  UserUpdateProfileErrorState(this.loginModel);
}
class Refresh extends UserStates{}







