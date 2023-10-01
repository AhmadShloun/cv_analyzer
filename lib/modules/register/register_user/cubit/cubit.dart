import 'dart:convert';

import 'package:cv_analyzer/models/Auth/register_model.dart';
import 'package:cv_analyzer/modules/register/register_user/cubit/states.dart';

import 'package:cv_analyzer/shared/network/end_points.dart';
import 'package:cv_analyzer/shared/network/remote/http_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class RegisterUserCubit extends Cubit<RegisterUserStates> {
  RegisterUserCubit() : super(RegisterUserInitialState());

  static RegisterUserCubit get(context) => BlocProvider.of(context);

  RegisterModel? registerModel;

  void userRegister({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password1,
    required String password2,
  }) {
    emit(RegisterUserLoadingState());
    Future<http.Response> response = HttpApi.postData(
      url: REGISTER_USER,
      body: {
        'first_name': firstName,
        'last_name': lastName,
        'username': username,
        'email': email,
        'password1': password1,
        'password2': password2,
      },
    );
    response.then((value) {
      var jsonResponse = jsonDecode(value.body);
      registerModel = RegisterModel.fromJson(jsonResponse);
      if (value.statusCode == 400) {
        if (kDebugMode) {
          print(value.statusCode);
        }
        emit(RegisterUserErrorState(value.toString()));
      } else {
        if (kDebugMode) {
          print(value.statusCode);
          print(value.body);
        }
        emit(RegisterUserSuccessState(registerModel!));
      }
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShow = true;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(RegisterUserChangePasswordVisibilityState());
  }
}
