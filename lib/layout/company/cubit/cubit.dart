import 'dart:convert';
import 'dart:io';

// import 'dart:html';

import 'package:cv_analyzer/layout/company/cubit/states.dart';
import 'package:cv_analyzer/models/company/company_model.dart';
import 'package:cv_analyzer/models/company/company_single_job.dart';
import 'package:cv_analyzer/models/Auth/logout_model.dart';
import 'package:cv_analyzer/models/company/create_update_model.dart';
import 'package:cv_analyzer/models/company/delete_model.dart';
import 'package:cv_analyzer/models/company/job_analyzsis_model.dart';
import 'package:cv_analyzer/models/company/show_job_analysis_model.dart';
import 'package:cv_analyzer/models/company/show_single_job_analysis_model.dart';
import 'package:cv_analyzer/modules/login/cubit/cubit.dart';
import 'package:cv_analyzer/shared/components/constants.dart';
import 'package:cv_analyzer/shared/network/end_points.dart';
import 'package:cv_analyzer/shared/network/remote/http_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class CompanyCubit extends Cubit<CompanyStates> {
  CompanyCubit() : super(CompanyInitialState());

  LoginCubit? loginCubit;

  static CompanyCubit get(context) => BlocProvider.of(context);

  LogoutModel? logoutModel;

  LogoutModel getModelData() {
    return logoutModel!;
  }

  void companyLogout({
    @required String? token,
  }) {
    if (kDebugMode) {
      print('Token: $token');
    }
    emit(LogoutLoadingState());
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
        emit(LogoutSuccessState(logoutModel!));
      } else {
        if (kDebugMode) {
          print(value.statusCode);
        }
        emit(LogoutErrorState(logoutModel!));
      }
    });
  }

  // String? chosenItem;
  // List<String> items = ["with cvs", "without cvs"];
  // String? value;
  // void changeTypeCVS() {
  //   value = selectType;
  //   emit(onChangeSelcet());
  //   if (value == items[1]) {
  //     print('Clear Cache File is Not Empty With Input(without cvs)');
  //     file = PlatformFile(
  //       name: '',
  //       size: 0,
  //     );
  //     emit(clearCacheFile());
  //     fileDetails();
  //   }
  // }

  var fileTypeList = ['zip'];
  FilePickerResult? result;
  File? file;

  void pickFiles() async {
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
    emit(selcetFileArchive());
    // fileDetails();
  }

  void fileDetails() {
    // final kb = file!.size / 1024;
    // final mb = kb / 1024;
    // final size = (mb >= 1)
    //     ? '${mb.toStringAsFixed(2)} MB'
    //     : '${kb.toStringAsFixed(2)} KB';
    // print('File Name: ${file!.name}');
    // print('File Size: $size');
    // print('File Extension: ${file!.extension}');
    // print('File Path: ${file!.path}');
  }

  List<String> status = ["ongoing", "finished"];
  String? chosenStatus;

  void changeStatusJob(selectType) {
    chosenStatus = selectType;

    emit(onChangeSelcetState());
  }

  CompanyModel? companyModel;

  void getAllJobData({
    @required String? token,
  }) async {
    emit(CompanyLoadingAllJobDataState());
    Future<http.Response> response = HttpApi.getData(
      url: ALLJOBCOMPANY,
      token: '$token',
    );
    response.then((value) {
      if (kDebugMode) {
        print('Value $value');
      }
      var jsonResponse = jsonDecode(value.body);
      companyModel = CompanyModel.fromJson(jsonResponse);
      if (value.statusCode == 200) {
        if (kDebugMode) {
          print(value.statusCode);
          print(value.body);
        }
        // companyModel!.data!.forEach((element) {
        //   companyJobData.addAll({
        //     element.id : value.body,
        //   });
        // });
        emit(CompanySuccessAllJobDataState());
      } else {
        if (kDebugMode) {
          print(value.statusCode);
          print(value.body);
        }
        emit(CompanyErrorAllJobDataState());
      }
    });
  }

  CompanySingleJobModel? companySingleJobModel;

  void getSingleJobData({
    @required int? id,
    @required String? token,
  }) async {
    emit(CompanyLoadingSingleJobDataState());
    Future<http.Response> response = HttpApi.getData(
      url: Uri.parse('$baseURL/company/jobs/$id'),
      token: '$token',
    );
    response.then((value) {
      var jsonResponse = jsonDecode(value.body);
      companySingleJobModel = CompanySingleJobModel.fromJson(jsonResponse);
      if (value.statusCode == 200) {
        if (kDebugMode) {
          print(value.body);
        }
        emit(CompanySuccessSingleJobDataState(companySingleJobModel!));
      } else {
        if (kDebugMode) {
          print(value.statusCode);
          print(value.body);
        }
        emit(CompanyErrorSingleJobDataState());
      }
    });
  }

//Create Job Company
  CreateUpdateModel? createModel;

  void createJob({
    @required String? subject,
    @required String? requiredSkills,
    @required int? requiredWorkExperience,
    @required String? requiredSoftSkills,
    @required String? requiredLanguages,
    @required String? expireTime,
  }) {
    emit(CreateLoadingState());
    Future<http.Response> response = HttpApi.postData(
      url: CREATEJOB,
      body: {
        'subject': subject,
        'required_skills': requiredSkills,
        'required_work_experience': '$requiredWorkExperience',
        'required_soft_skills': requiredSoftSkills,
        'required_languages': requiredLanguages,
        'expire_time': expireTime,
      },
      headers: {
        'Authorization': '$baseToken $token',
        'Accept': 'application/json',
      },
    );
    response.then((value) {
      if (kDebugMode) {
        print(value.statusCode);
      }
      var jsonResponse = jsonDecode(value.body);
      createModel = CreateUpdateModel.fromJson(jsonResponse);
      if (value.statusCode == 200) {
        emit(CreateSuccessState(createModel!));
      } else {
        emit(CreateErrorState(createModel!));
      }
    });
  }

  CreateUpdateModel? updateModel;

  void updateJob({
    @required int? id,
    @required String? subject,
    @required String? requiredSkills,
    @required String? requiredWorkExperience,
    @required String? requiredSoftSkills,
    @required String? requiredLanguages,
    @required String? expireTime,
    @required String? status,
    @required int? companyId,
  }) {
    // print(id.runtimeType);
    if (kDebugMode) {
      print(id);
    }
    emit(UpdateLoadingState());

    Future<http.Response> response = HttpApi.postData(
      url: Uri.parse('$baseURL/company/jobs/$id'),
      body: {
        'subject': subject,
        'required_skills': requiredSkills,
        'required_work_experience': requiredWorkExperience,
        'required_soft_skills': requiredSoftSkills,
        'required_languages': requiredLanguages,
        'expire_time': expireTime,
        'status': status,
        'company_id': '$companyId',
        '_method': 'put',
      },
      headers: {
        'Authorization': '$baseToken $token',
        // 'Accept':'application/json',
      },
    );
    response.then((value) {
      // print(value.statusCode);
      var jsonResponse = jsonDecode(value.body);
      updateModel = CreateUpdateModel.fromJson(jsonResponse);
      if (value.statusCode == 200) {
        emit(UpdateSuccessState(updateModel!));
      } else {
        emit(UpdateErrorState(updateModel!));
      }
    });
  }

  DeleteModel? deleteModel;

  void deleteJob({
    @required int? id,
    @required String? token,
  }) {
    emit(DeleteLoadingState());
    Future<http.Response> response = HttpApi.deleteJob(
      url: Uri.parse('$baseURL/company/jobs/$id'),
      token: token,
    );
    response.then((value) {
      if (kDebugMode) {
        print(value.statusCode);
      }
      var jsonResponse = jsonDecode(value.body);
      deleteModel = DeleteModel.fromJson(jsonResponse);
      if (value.statusCode == 200) {
        emit(DeleteSuccessState(deleteModel!));
      } else {
        emit(DeleteErrorState(deleteModel!));
      }
    });
  }

  JobAnalyzesModel? jobAnalyzesModel;

  Future<void> createAnalyzesJob({
    @required String? subject,
    @required String? requiredSkills,
    @required String? requiredWorkExperience,
    @required String? requiredSoftSkills,
    @required String? requiredLanguages,
    @required File? cvs,
  }) async {
    emit(CreateJobAnalyzsisLoadingState());
    var request = http.MultipartRequest("POST", CREATEJOBANALYZIES);
    final headers = {
      'Authorization': '$baseToken $token',
      'Accept': 'application/json',
    };
    request.headers.addAll(headers);
    request.fields['subject'] = subject.toString();
    request.fields['required_skills'] = requiredSkills.toString();
    request.fields['required_work_experience'] =
        requiredWorkExperience.toString();
    request.fields['required_soft_skills'] = requiredSoftSkills.toString();
    request.fields['required_languages'] = requiredLanguages.toString();
    request.files.add(await http.MultipartFile.fromPath("cvs", cvs!.path));
    var sendRequest = await request.send();
    var response = await http.Response.fromStream(sendRequest);
    var jsonResponse = jsonDecode(response.body);
    jobAnalyzesModel = JobAnalyzesModel.fromJson(jsonResponse);

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('stauts Job Analysis : ${response.statusCode}');
      }
      emit(CreateJobAnalyzsisSuccessState(jobAnalyzesModel!));
    } else {
      emit(CreateJobAnalyzsisErrorState(jobAnalyzesModel!));
    }
  }

  ShowJobAnalyzesModel? showJobAnalyzesModel;

  void getAllJobAnalysisData({
    @required String? token,
  }) async {
    emit(CompanyLoadingAllJobAnalysisDataState());
    Future<http.Response> response = HttpApi.getData(
      url: ALLJOBANALYZIES,
      token: '$token',
    );
    response.then((value) {
      if (kDebugMode) {
        print('Value $value');
      }
      var jsonResponse = jsonDecode(value.body);
      showJobAnalyzesModel = ShowJobAnalyzesModel.fromJson(jsonResponse);
      if (value.statusCode == 200) {
        if (kDebugMode) {
          print(value.statusCode);
          print(value.body);
        }
        emit(CompanySuccessAllJobAnalysisDataState());
      } else {
        if (kDebugMode) {
          print(value.statusCode);
          print(value.body);
        }
        emit(CompanyErrorAllJobAnalysisDataState());
      }
    });
  }

  ShowSingleJobAnalyzesModel? showSingleJobAnalyzesModel;

  void getSingleJobAnalysisData({
    @required int? id,
    @required String? token,
  }) async {
    emit(CompanyLoadingSingleJobAnalysisDataState());
    Future<http.Response> response = HttpApi.getData(
      url: Uri.parse('$baseURL/company/job-analyzies/$id'),
      token: '$token',
    );
    response.then((value) {
      var jsonResponse = jsonDecode(value.body);
      showSingleJobAnalyzesModel =
          ShowSingleJobAnalyzesModel.fromJson(jsonResponse);
      if (value.statusCode == 200) {
        if (kDebugMode) {
          print(value.body);
        }
        emit(CompanySuccessSingleJobAnalysisDataState(
            showSingleJobAnalyzesModel!));
      } else {
        if (kDebugMode) {
          print(value.statusCode);
          print(value.body);
        }
        emit(CompanyErrorSingleJobAnalysisDataState());
      }
    });
  }
}
