// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:cv_analyzer/layout/company/company_layout.dart';
import 'package:path/path.dart';
import 'package:cv_analyzer/layout/company/cubit/cubit.dart';
import 'package:cv_analyzer/layout/company/cubit/states.dart';
import 'package:cv_analyzer/shared/components/components.dart';
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class CvAnalysis extends StatelessWidget {
  CvAnalysis({super.key});

  var subjectController = TextEditingController();
  var skillsController = TextEditingController();
  var workExperienceController = TextEditingController();
  var softSkillsController = TextEditingController();
  var languagesController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  // var buttom = GlobalKey<E>()
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider(
      create: (context) => CompanyCubit(),
      child: BlocConsumer<CompanyCubit, CompanyStates>(
        listener: (context, state) {
          if (state is CreateJobAnalyzsisSuccessState) {
            showToast(
              text: 'CVs have been successfully analyzed',
              state: ToastStates.SUCCESS,
            );
            navigateTo(context, const CompanyHome());
          }
          if (state is CreateJobAnalyzsisErrorState) {
            showToast(
              text: 'Something went wrong while analyzing CVs',
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'CV Analysis',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                        controller: subjectController,
                        type: TextInputType.text,
                        prefixIcon: Icons.subject,
                        labelText: 'Subject',
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your subject';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: skillsController,
                        type: TextInputType.multiline,
                        maxLines: null,
                        labelText: 'Required Skills',
                        prefixIcon: Icons.code,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your required skills';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: workExperienceController,
                        type: TextInputType.number,
                        labelText: 'Required Work Experience',
                        prefixIcon: Icons.work_outline_outlined,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your work experience';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: softSkillsController,
                        type: TextInputType.multiline,
                        maxLines: null,
                        labelText: 'Required Soft Skills',
                        prefixIcon: Icons.engineering,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your soft skills';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: languagesController,
                        type: TextInputType.multiline,
                        maxLines: null,
                        labelText: 'Required Languages',
                        prefixIcon: Icons.language,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the work required languages';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              // height: 100,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.purpleAccent.shade200),
                                ),
                                child: const Text(
                                  'Pick file',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () async {
                                  CompanyCubit.get(context).pickFiles();
                                },
                                //Text('Pick file')
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (CompanyCubit.get(context).file != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Selected file name : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              basename(CompanyCubit.get(context).file!.path),
                            ),
                          ],
                        ),
                      if (CompanyCubit.get(context).file == null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Selected file name : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'Selected Folder ZIP',
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! CreateJobAnalyzsisLoadingState,
                        builder: (context) => defaultButton(
                          text: 'Start Analysis',
                          radius: 25.0,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              CompanyCubit.get(context).createAnalyzesJob(
                                subject: subjectController.text,
                                requiredSkills: skillsController.text,
                                requiredWorkExperience:
                                    workExperienceController.text,
                                requiredSoftSkills: softSkillsController.text,
                                requiredLanguages: languagesController.text,
                                cvs: CompanyCubit.get(context).file!,
                              );
                            }
                          },
                          background: defaultColor,
                          isUpperCase: true,
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
