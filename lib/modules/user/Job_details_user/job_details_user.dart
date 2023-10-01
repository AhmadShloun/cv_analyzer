// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:cv_analyzer/layout/user/user_layout.dart';
import 'package:cv_analyzer/models/user/apply_job_model.dart';
import 'package:cv_analyzer/models/user/cancel_model.dart';
import 'package:cv_analyzer/models/user/user_single_job.dart';
import 'package:cv_analyzer/shared/components/components.dart';
import 'package:cv_analyzer/shared/components/constants.dart';
import 'package:cv_analyzer/shared/network/end_points.dart';
import 'package:cv_analyzer/shared/network/remote/http_api.dart';
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

UserApplyJobModel? userApplyJobModel;
UserCancelJobModel? userCancelJobModel;

class JobDetailsUser extends StatelessWidget {
  UserSingleJobModel? userModel;

  JobDetailsUser(UserSingleJobModel model, {super.key}) {
    userModel = model;
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: userModel != null,
      builder: (context) => infoJob(userModel!, context),
      fallback: (context) => Container(
          color: defaultColorAppBar,
          child: const Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.black87,
          ))),
    );

  }
}

Widget infoJob(UserSingleJobModel model, context) => Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Center(
            child: Text(
          'Job Information',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
      ),
      body: ConditionalBuilder(
        condition: model != null,
        builder: (context) => detailsJob(model.data!, context),
        fallback: (context) => Container(
            color: defaultColorAppBar,
            child: const Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.black87,
            ))),
      ),
    );

Widget detailsJob(DataJobModel model, context) => Container(
      height: double.infinity,
      width: double.infinity,
      color: defaultColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '${model.subject}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 585,
              decoration: BoxDecoration(
                borderRadius: const BorderRadiusDirectional.only(
                    topStart: Radius.circular(60), topEnd: Radius.circular(60)),
                color: defaultColorAppBar,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildItemBoxJob(
                            Icons.code, 'Skills : ', '${model.requiredSkills}'),
                        const SizedBox(
                          height: 10,
                        ),
                        buildItemBoxJob(
                            Icons.work_outline_outlined,
                            'Work Experience : ',
                            '${model.requiredWorkExperience}'),
                        const SizedBox(
                          height: 10,
                        ),
                        buildItemBoxJob(Icons.engineering, 'Soft Skills : ',
                            '${model.requiredSoftSkills}'),
                        const SizedBox(
                          height: 10,
                        ),
                        buildItemBoxJob(Icons.language, 'Languages : ',
                            '${model.requiredLanguages}'),
                        const SizedBox(
                          height: 10,
                        ),
                        buildItemBoxJob(Icons.access_time_sharp,
                            'Expire Time : ', '${model.expireTime}'),
                        const SizedBox(
                          height: 10,
                        ),
                        buildItemBoxJob(
                            Icons.spa, 'Status Job : ', '${model.status}'),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.black,
                              size: 25,
                            ),
                            Text('Damasuce - Roken Aldden'),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            if (model.isApply == false)
                              Container(
                                // height: 25,
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadiusDirectional.all(
                                      Radius.circular(25.0)),
                                  color: defaultColor,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Future<http.Response> response =
                                        HttpApi.postData(
                                            url: APPLYJOB,
                                            headers: {
                                          'Authorization': '$baseToken $token',
                                          'Accept': 'application/json',
                                        },
                                            body: {
                                          'job_id': '${model.id}',
                                        });
                                    response.then((value) {
                                      if (kDebugMode) {
                                        print(value.statusCode);
                                      }
                                      var jsonResponse = jsonDecode(value.body);
                                      userApplyJobModel =
                                          UserApplyJobModel.fromJson(
                                              jsonResponse);
                                      if (value.statusCode == 200) {
                                        showToast(
                                          text:
                                              'The job has been successfully applied for',
                                          state: ToastStates.SUCCESS,
                                        );
                                        navigateTo(context, UserHome());
                                      } else {
                                        showToast(
                                          text:
                                              'There was a problem when applying for the job',
                                          state: ToastStates.ERROR,
                                        );
                                      }
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.done_outline,
                                        color: Colors.white,
                                        size: 25.0,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Apply',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            const SizedBox(
                              width: 15,
                            ),
                            if (model.isApply == true)
                              Container(
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadiusDirectional.all(
                                      Radius.circular(25.0)),
                                  color: defaultColor,
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      Future<http.Response> response =
                                          HttpApi.deleteJob(
                                        url: Uri.parse(
                                            '$baseURL/employee/jobs/cancel-apply/${model.id}'),
                                        token: token,
                                      );
                                      response.then((value) {
                                        if (kDebugMode) {
                                          print(value.statusCode);
                                        }
                                        var jsonResponse =
                                            jsonDecode(value.body);
                                        userCancelJobModel =
                                            UserCancelJobModel.fromJson(
                                                jsonResponse);
                                        if (value.statusCode == 200) {
                                          showToast(
                                            text:
                                                userCancelJobModel!.message.toString(),
                                            state: ToastStates.SUCCESS,
                                          );
                                          navigateTo(context, UserHome());
                                        } else {
                                          showToast(
                                            text:
                                                userCancelJobModel!.message.toString(),
                                            state: ToastStates.ERROR,
                                          );
                                        }
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 25.0,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Cansel',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ],
                                    )),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
