// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:cv_analyzer/layout/company/company_layout.dart';
import 'package:cv_analyzer/models/company/company_single_job.dart';
import 'package:cv_analyzer/models/company/delete_model.dart';
import 'package:cv_analyzer/modules/company/update_job/update_job.dart';
import 'package:cv_analyzer/modules/company/view_user_accept_job/view_user_accept_job.dart';
import 'package:cv_analyzer/shared/components/components.dart';
import 'package:cv_analyzer/shared/components/constants.dart';
import 'package:cv_analyzer/shared/network/end_points.dart';
import 'package:cv_analyzer/shared/network/remote/http_api.dart';
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
DeleteModel? deleteModel;
CompanySingleJobModel? compModel;

class JobDetailsCompany extends StatelessWidget {

  JobDetailsCompany(CompanySingleJobModel model, {super.key}) {
    compModel = model;
  }
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      // condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
      condition: compModel != null,
      // builder: (context) => builderWidget(ShopCubit.get(context).homeModel!, ShopCubit.get(context).categoriesModel!, context),
      builder: (context) =>
          infoJob(compModel!, context),
      // builder: (context) => Container(),
      fallback: (context) => Container(
          color: defaultColorAppBar,
          child: const Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.black87,
          ))),
    );
  }
}

Widget infoJob(CompanySingleJobModel model, context) => Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Job Information',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        elevation: 5,
      ),
      body: ConditionalBuilder(
        condition: model !=  null,
        builder: (context) => detailsJob(model.data!, context),
        fallback: (context) => Container(
            color: defaultColorAppBar,
            child: const Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.black87,
            ))),
      ),
    );

Widget detailsJob(DataModelJob model, context) {
  ToastContext().init(context);
  return Container(
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
            height: 590,
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
                      buildItemBoxJob(Icons.code, 'Skills : ',
                          '${model.requiredSkills}'),
                      const SizedBox(
                        height: 10,
                      ),
                      buildItemBoxJob(Icons.work_outline_outlined,
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
                      buildItemBoxJob(
                          Icons.language, 'Languages : ',
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
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  navigateTo(
                                      context, UpdateJobCompany(model: model));
                                },
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.update_rounded,
                                      color: Colors.green,
                                      size: 25.0,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'update',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  Future<http.Response> response = HttpApi
                                      .deleteJob(
                                    url: Uri.parse(
                                        '$baseURL/company/jobs/${model.id}'),
                                    token: token,
                                  );
                                  response.then((value) {
                                    if (kDebugMode) {
                                      print(value.statusCode);
                                    }
                                    var jsonResponse = jsonDecode(value.body);
                                    deleteModel =
                                        DeleteModel.fromJson(jsonResponse);
                                    if (value.statusCode == 200) {
                                      showToast(
                                        text: deleteModel!.message.toString(),
                                        state: ToastStates.SUCCESS,
                                      );
                                      navigateTo(context, const CompanyHome());
                                    } else {
                                      showToast(
                                        text: 'An error occurred, try later',
                                        state: ToastStates.ERROR,
                                      );
                                    }
                                  });
                                },
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                      size: 25.0,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Delete',
                                      style: TextStyle(
                                          color: Colors.red,
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
                      defaultButton(
                          text: 'View employee CVs',
                          function: () {
                            // navigateTo(context, ShowCvsUser());
                            navigateTo(context, ViewUserJob(model:compModel));
                          },
                          background: defaultColor,
                          height: 50,
                          width: 200,
                          radius: 15),
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
}