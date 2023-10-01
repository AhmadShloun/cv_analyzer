import 'package:conditional_builder/conditional_builder.dart';
import 'package:cv_analyzer/layout/company/company_layout.dart';
import 'package:cv_analyzer/layout/company/cubit/cubit.dart';
import 'package:cv_analyzer/layout/company/cubit/states.dart';
import 'package:cv_analyzer/shared/components/components.dart';
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class CreateJobCompany extends StatelessWidget {
  CreateJobCompany({super.key});

  var subjectController = TextEditingController();
  var skillsController = TextEditingController();
  var workExperienceController = TextEditingController();
  var softSkillsController = TextEditingController();
  var languagesController = TextEditingController();
  var dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider(
      create: (context) => CompanyCubit(),
      child: BlocConsumer<CompanyCubit, CompanyStates>(
        listener: (context, state) {
          if (state is CreateSuccessState) {
            showToast(
              text: '${state.createModel.message}',
              state: ToastStates.SUCCESS,
            );
            navigateTo(context, const CompanyHome());
          }
          if (state is CreateErrorState) {
            showToast(
              text: '${state.createModel.message}',
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text(
                  'Create Job',
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         // height: 100,
                      //         width: 150,
                      //         child: DropdownButtonFormField(
                      //           value: CompanyCubit.get(context).value,
                      //           items: CompanyCubit.get(context).items.map((e) {
                      //             return DropdownMenuItem(
                      //               child: Text(e),
                      //               value: e,
                      //             );
                      //           }).toList(),
                      //           icon: Icon(Icons.keyboard_arrow_down),
                      //           autofocus: true,
                      //           // autofocus: true,
                      //           focusColor: Colors.white,
                      //           hint: Text(
                      //             'Select Type',
                      //             style: TextStyle(
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.w500),
                      //           ),
                      //           onChanged: (value) {
                      //             CompanyCubit.get(context)
                      //                 .changeTypeCVS(value);
                      //             CompanyCubit.get(context).chosenItem =
                      //                 value.toString();
                      //             typeCVSController.text = value.toString();
                      //             print(typeCVSController.text);
                      //           },
                      //           validator: (value) =>
                      //               value == null ? 'field required' : null,
                      //         ),
                      //       ),
                      //       Spacer(),
                      //       if (CompanyCubit.get(context).value ==
                      //           CompanyCubit.get(context).items[0])
                      //         ElevatedButton(
                      //           style: ButtonStyle(
                      //             backgroundColor: MaterialStateProperty.all(
                      //                 Colors.grey.shade50),
                      //           ),
                      //           child: Text(
                      //             'Pick file',
                      //             style: TextStyle(color: Colors.black),
                      //           ),
                      //           onPressed: () async {
                      //             CompanyCubit.get(context).pickFiles();
                      //           }, //Text('Pick file')
                      //         ),
                      //     ],
                      //   ),
                      // ),
                      // if (CompanyCubit.get(context).file != null &&
                      //     CompanyCubit.get(context).value ==
                      //         CompanyCubit.get(context).items[0])
                      //   Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         'Selected file name : ',
                      //         style: TextStyle(fontWeight: FontWeight.bold),
                      //       ),
                      //       SizedBox(
                      //         width: 15.0,
                      //       ),
                      //       Text(
                      //         CompanyCubit.get(context).file!.name,
                      //       ),
                      //     ],
                      //   ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
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
                      defaultFormField_Date(
                        controller: dateController,
                        type: TextInputType.datetime,
                        validate: 'Date is Empty ..!',
                        labelText: 'Expire Time',
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2050-12-31'),
                          ).then((value) {
                            var formatter = DateFormat('yyy-MM-dd');
                            dateController.text = formatter.format(value!);
                            if (kDebugMode) {
                              print(dateController.text);
                            }
                          });
                        },
                        prefixIcon: Icons.calendar_today,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       'Job Status : ',
                      //       style: TextStyle(fontWeight: FontWeight.bold),
                      //     ),
                      //     SizedBox(
                      //       width: 25.0,
                      //     ),
                      //     Container(
                      //       width: 150.0,
                      //       height: 100.0,
                      //       child: Center(
                      //         child: DropdownButtonFormField(
                      //           value: CompanyCubit.get(context).chosenStatus,
                      //           items:
                      //               CompanyCubit.get(context).status.map((e) {
                      //             return DropdownMenuItem(
                      //               value: e,
                      //               child: Text(e),
                      //             );
                      //           }).toList(),
                      //           icon: Icon(Icons.keyboard_arrow_down),
                      //           // autofocus: true,
                      //           // focusColor: Colors.red,
                      //           hint: Text(
                      //             'Select Status Job',
                      //             style: TextStyle(fontSize: 14),
                      //           ),
                      //           onChanged: (value) {
                      //             CompanyCubit.get(context)
                      //                 .changeStatusJob(value);
                      //             CompanyCubit.get(context).chosenStatus =
                      //                 value.toString();
                      //             statusJobController.text = value.toString();
                      //             print(statusJobController.text);
                      //           },
                      //           validator: (value) =>
                      //               value == null ? 'field required' : null,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      ConditionalBuilder(
                        condition: state is! CreateLoadingState,
                        builder: (context) => defaultButton(
                          text: 'Create Job',
                          radius: 25.0,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              CompanyCubit.get(context).createJob(
                                subject: subjectController.text,
                                requiredSkills: skillsController.text,
                                requiredWorkExperience:
                                    int.parse(workExperienceController.text),
                                requiredSoftSkills: softSkillsController.text,
                                requiredLanguages: languagesController.text,
                                expireTime: dateController.text,
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
