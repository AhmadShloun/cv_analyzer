import 'dart:convert';
import 'dart:io';
import 'package:cv_analyzer/layout/user/cubit/states.dart';
import 'package:cv_analyzer/models/Auth/login_model.dart';
import 'package:cv_analyzer/models/Auth/logout_model.dart';
import 'package:cv_analyzer/models/user/user_model.dart';
import 'package:cv_analyzer/models/user/user_single_job.dart';
import 'package:cv_analyzer/shared/components/constants.dart';
import 'package:cv_analyzer/shared/network/end_points.dart';
import 'package:cv_analyzer/shared/network/remote/http_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitialState());

  static UserCubit get(context) => BlocProvider.of(context);

  LogoutModel? logoutModel;

  void userLogout({
    @required String? token,
  }) {
    if (kDebugMode) {
      print('Token: $token');
    }
    emit(LogoutUserLoadingState());
    Future<http.Response> response = HttpApi.postData(
      url: LOGOUT,
      headers: {
        'Authorization': '$baseToken $token',
        'Accept': 'application/json',
      },
      body: {},
    );
    response.then((value) {
      if (kDebugMode) {
        print('Value $value');
      }
      var jsonResponse = jsonDecode(value.body);
      logoutModel = LogoutModel.fromJson(jsonResponse);
      if (value.statusCode == 200) {
        if (kDebugMode) {
          print(value.statusCode);
          print(value.body);
        }
        emit(LogoutUserSuccessState(logoutModel!));
      } else {
        if (kDebugMode) {
          print(value.statusCode);
        }
        emit(LogoutUserErrorState(logoutModel!));
      }
    });
  }

  var fileTypeList = ['pdf'];
  FilePickerResult? result;
  File? file;

  void pickFilesPDF() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: fileTypeList,
    );
    if (result == null) {
      return;
    }
    file = File(result!.files.single.path!);
    if (kDebugMode) {
      print(file);
    }
    emit(selcetFilePDF());
  }

  Map<String, dynamic> userData = {};

  // UpdateProfileModel? updateProfileModel;
  LoginModel? loginModel;

  Future<void> updateProfile({
    @required String? firstName,
    @required String? lastName,
    @required String? phone,
    @required String? address,
    @required String? birthdate,
    @required File? cv,
  }) async {
    emit(UserUpdateProfileLoadingState());
    var request = http.MultipartRequest("POST", UPDATEPROFILE);
    final headers = {
      'Authorization': '$baseToken $token',
      'Accept': 'application/json',
    };
    request.headers.addAll(headers);
    request.fields['first_name'] = firstName.toString();
    request.fields['last_name'] = lastName.toString();
    request.fields['phone'] = phone.toString();
    request.fields['address'] = address.toString();
    request.fields['birthdate'] = birthdate.toString();
    request.files.add(await http.MultipartFile.fromPath("cv", cv!.path));

    var sendRequest = await request.send();
    var response = await http.Response.fromStream(sendRequest);
    var jsonResponse = jsonDecode(response.body);
    loginModel = LoginModel.fromJson(jsonResponse);
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('stauts Job Analysis : ${response.statusCode}');
      }
      emit(UserUpdateProfileSuccessState(loginModel!));
    } else {
      emit(UserUpdateProfileErrorState(loginModel!));
    }
  }

  UserModel? userModel;

  void getAllJobData({
    @required String? token,
  }) async {
    emit(UserLoadingAllJobDataState());
    Future<http.Response> response = HttpApi.getData(
      url: ALLJOBUSER,
      token: '$token',
    );
    response.then((value) {
      if (kDebugMode) {
        print('Value $value');
      }
      var jsonResponse = jsonDecode(value.body);
      userModel = UserModel.fromJson(jsonResponse);
      if (value.statusCode == 200) {
        if (kDebugMode) {
          print(value.statusCode);
          print(value.body);
        }
        emit(UserSuccessAllJobDataState());
      } else {
        if (kDebugMode) {
          print(value.statusCode);
          print(value.body);
        }
        emit(UserErrorAllJobDataState());
      }
    });
  }

  UserSingleJobModel? userSingleJobModel;

  void getSingleJobData({
    @required int? id,
    @required String? token,
  }) async {
    emit(UserLoadingSingleJobDataState());
    Future<http.Response> response = HttpApi.getData(
      url: Uri.parse('$baseURL/employee/jobs/$id}'),
      token: '$token',
    );
    response.then((value) {
      var jsonResponse = jsonDecode(value.body);
      userSingleJobModel = UserSingleJobModel.fromJson(jsonResponse);
      if (value.statusCode == 200) {
        if (kDebugMode) {
          print(value.body);
        }
        emit(UserSuccessSingleJobDataState(userSingleJobModel!));
      } else {
        if (kDebugMode) {
          print(value.statusCode);
          print(value.body);
        }
        emit(UserErrorSingleJobDataState());
      }
    });
  }
}
