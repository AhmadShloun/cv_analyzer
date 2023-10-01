import 'package:conditional_builder/conditional_builder.dart';
import 'package:cv_analyzer/layout/company/company_layout.dart';
import 'package:cv_analyzer/modules/register/register_company/cubit/cubit.dart';
import 'package:cv_analyzer/modules/register/register_company/cubit/states.dart';
import 'package:cv_analyzer/shared/components/components.dart';
import 'package:cv_analyzer/shared/components/constants.dart';
import 'package:cv_analyzer/shared/network/local/cache_helper.dart';
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class RegisterCompany extends StatelessWidget {
  RegisterCompany({super.key});

  var nameController = TextEditingController();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var password1Controller = TextEditingController();
  var password2Controller = TextEditingController();
  var workFieldController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider(
      create: (context) => RegisterCompanyCubit(),
      child: BlocConsumer<RegisterCompanyCubit, RegisterCompanyStates>(
        listener: (context, state) {
          if (state is RegisterCompanySuccessState) {
            showToast(
              text: 'Login done successfully',
              state: ToastStates.SUCCESS,
            );
            CacheHelper.saveData(
              key: 'token',
              value: state.registerModel.token,
            ).then((value) {
              token = '${state.registerModel.token}';

              navigateAndFinish(context, const CompanyHome());
            });
          } else if (state is RegisterCompanyErrorState) {
            showToast(
              text: state.error.toString(),
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text(
                  'Register Company',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        labelText: 'Name Company',
                        prefixIcon: Icons.drive_file_rename_outline_outlined,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your name company';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: usernameController,
                        type: TextInputType.name,
                        labelText: 'User Name',
                        prefixIcon: Icons.person_outline,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your user name company';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        labelText: 'Email Address',
                        prefixIcon: Icons.email_outlined,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: password1Controller,
                        type: TextInputType.visiblePassword,
                        labelText: 'Password',
                        prefixIcon: Icons.lock,
                        suffixIcon: RegisterCompanyCubit.get(context).suffix,
                        suffixPress: () {
                          RegisterCompanyCubit.get(context)
                              .changePasswordVisibility();
                        },
                        onPassword:
                            RegisterCompanyCubit.get(context).isPasswordShow,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: password2Controller,
                        type: TextInputType.visiblePassword,
                        labelText: 'Re-enter password',
                        prefixIcon: Icons.lock,
                        onPassword:
                            RegisterCompanyCubit.get(context).isPasswordShow,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please re-enter the password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: workFieldController,
                        type: TextInputType.multiline,
                        maxLines: null,
                        labelText: 'Work Field',
                        prefixIcon: Icons.text_fields,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the work field';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterCompanyLoadingState,
                        builder: (context) => defaultButton(
                          text: 'register',
                          function: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCompanyCubit.get(context).companyRegister(
                                name: nameController.text,
                                username: usernameController.text,
                                email: emailController.text,
                                password1: password1Controller.text,
                                password2: password2Controller.text,
                                workField: workFieldController.text,
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
