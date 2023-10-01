// ignore_for_file: must_be_immutable

import 'package:conditional_builder/conditional_builder.dart';
import 'package:cv_analyzer/layout/user/cubit/cubit.dart';
import 'package:cv_analyzer/layout/user/cubit/states.dart';
import 'package:cv_analyzer/layout/user/user_layout.dart';
import 'package:cv_analyzer/models/Auth/login_model.dart';
import 'package:cv_analyzer/shared/components/components.dart';
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:path/path.dart';
LoginModel? loginModel;
class ProfileUser extends StatelessWidget {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var cvController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var birthdateController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  ProfileUser(model, {super.key}) {
    loginModel = model;
    firstNameController.text = loginModel!.data!.profile!.firstName!;
    lastNameController.text = loginModel!.data!.profile!.lastName!;
    cvController.text= loginModel!.data!.profile!.cv!;
    phoneController.text = loginModel!.data!.profile!.phone!;
    addressController.text = loginModel!.data!.profile!.address!;
    birthdateController.text = loginModel!.data!.profile!.birthdate!;
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if(state is UserUpdateProfileSuccessState)
            {
              showToast(
                text: 'Update Profile Success',
                state: ToastStates.SUCCESS,
              );
              navigateTo(context, UserHome(model:state.loginModel));
            }
          if(state is UserUpdateProfileErrorState)
          {
            showToast(
              text: 'Update Profile Error',
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text(
                  'Profile',
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
                        controller: phoneController,
                        type: TextInputType.phone,
                        labelText: 'Phone',
                        prefixIcon: Icons.phone,
                        validate: (value) {
                          if (value!.isEmpty) return 'please enter your phone';
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: addressController,
                        type: TextInputType.streetAddress,
                        labelText: 'Address',
                        prefixIcon: Icons.location_on,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField_Date(
                        controller: birthdateController,
                        type: TextInputType.datetime,
                        validate: ' birthdate is Empty ..!',
                        labelText: ' Birthdate',
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2050-12-31'),
                          ).then((value) {
                            var formatter = DateFormat('yyy-MM-dd');
                            birthdateController.text = formatter.format(value!);
                            if (kDebugMode) {
                              print(birthdateController.text);
                            }
                          });
                        },
                        prefixIcon: Icons.calendar_today,
                      ),
                      const SizedBox(
                        height: 30.0,
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
                                  UserCubit.get(context).pickFilesPDF();
                                }, //Text('Pick file')
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (UserCubit.get(context).file != null)
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
                              basename(UserCubit.get(context).file!.path),
                              // '${cvController.text.substring(14)}',
                            ),
                          ],
                        ),
                      if (UserCubit.get(context).file == null)
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
                            Text(basename(loginModel!.data!.profile!.cv!)),
                          ],
                        ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ConditionalBuilder(
                        // condition: state is! RegisterUserLoadingState,
                        condition: state is! UserUpdateProfileLoadingState,
                        builder: (context) => defaultButton(
                          text: 'update profile',
                          function: () {
                            // print(UserCubit.get(context).file);
                            if (formKey.currentState!.validate()) {
                              UserCubit.get(context).updateProfile(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                                birthdate: birthdateController.text ,
                                cv:UserCubit.get(context).file,
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
