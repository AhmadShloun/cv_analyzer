
// ignore_for_file: must_be_immutable

import 'package:conditional_builder/conditional_builder.dart';
import 'package:cv_analyzer/models/company/show_single_job_analysis_model.dart';
import 'package:cv_analyzer/modules/company/show_job_single_user_analysis/show_job_zip.dart';
import 'package:cv_analyzer/shared/components/components.dart';
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

// DeleteModel? deleteModel;
ShowSingleJobAnalyzesModel? showSingleJobAnalyzesModel;
class JobSinleAnlysisDetailsCompany extends StatelessWidget {
  ShowSingleJobAnalyzesModel? compModel;

  JobSinleAnlysisDetailsCompany(ShowSingleJobAnalyzesModel model, {super.key}) {
    compModel = model;
  }
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: compModel != null,
      builder: (context) =>
          infoJob(compModel!, context),
      fallback: (context) => Container(
          color: defaultColorAppBar,
          child: const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black87,
              ))),
    );
  }
}

Widget infoJob(ShowSingleJobAnalyzesModel model, context) => Scaffold(
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

Widget detailsJob(DataSingleJobAnalyzesModel model, context) {
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
                      // Row(
                      //   children: [
                      //     TextButton(
                      //         onPressed: () {
                      //           // navigateTo(
                      //           //     context, UpdateJobCompany(model: model));
                      //         },
                      //         child: Row(
                      //           children: [
                      //             Icon(
                      //               Icons.remove_red_eye_outlined,
                      //               color: Colors.green,
                      //               size: 25.0,
                      //             ),
                      //             SizedBox(
                      //               width: 8,
                      //             ),
                      //             Text(
                      //               'Show Result',
                      //               style: TextStyle(
                      //                   color: Colors.green,
                      //                   fontWeight: FontWeight.bold,
                      //                   fontSize: 18),
                      //             ),
                      //           ],
                      //         )),
                      //     SizedBox(
                      //       width: 15,
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 50,
                      ),
                      defaultButton(
                          text: 'View employee CVs',
                          function: () {
                            navigateTo(context, ShowJobZip(model:showSingleJobAnalyzesModel));
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