import 'package:conditional_builder/conditional_builder.dart';
import 'package:cv_analyzer/layout/user/user_layout.dart';
import 'package:cv_analyzer/modules/register/register_user/cubit/cubit.dart';
import 'package:cv_analyzer/modules/register/register_user/cubit/states.dart';
import 'package:cv_analyzer/shared/components/components.dart';
import 'package:cv_analyzer/shared/components/constants.dart';
import 'package:cv_analyzer/shared/network/local/cache_helper.dart';
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class RegisterUser extends StatelessWidget {
  RegisterUser({super.key});

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var password1Controller = TextEditingController();
  var password2Controller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider(
      create: (context) => RegisterUserCubit(),
      child: BlocConsumer<RegisterUserCubit, RegisterUserStates>(
        listener: (context, state) {
          if (state is RegisterUserSuccessState) {
            showToast(
              text: 'Login done successfully',
              state: ToastStates.SUCCESS,
            );
            CacheHelper.saveData(
              key: 'token',
              value: state.registerModel.token,
            ).then((value) {
              token = '${state.registerModel.token}';
              navigateAndFinish(context, UserHome());
            });
          } else if (state is RegisterUserErrorState) {
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
                  'Register User',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
                        controller: firstNameController,
                        type: TextInputType.name,
                        labelText: 'First Name',
                        prefixIcon: Icons.drive_file_rename_outline_outlined,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: lastNameController,
                        type: TextInputType.name,
                        labelText: 'Last Name',
                        prefixIcon: Icons.drive_file_rename_outline_outlined,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: userNameController,
                        type: TextInputType.text,
                        labelText: 'User Name',
                        prefixIcon: Icons.person_outline,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your username';
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
                        suffixIcon: RegisterUserCubit.get(context).suffix,
                        suffixPress: () {
                          RegisterUserCubit.get(context)
                              .changePasswordVisibility();
                        },
                        onPassword:
                            RegisterUserCubit.get(context).isPasswordShow,
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
                            RegisterUserCubit.get(context).isPasswordShow,
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
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterUserLoadingState,
                        builder: (context) => defaultButton(
                          text: 'register',
                          function: () {
                            if (formKey.currentState!.validate()) {
                              RegisterUserCubit.get(context).userRegister(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                username: userNameController.text,
                                email: emailController.text,
                                password1: password1Controller.text,
                                password2: password2Controller.text,
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
