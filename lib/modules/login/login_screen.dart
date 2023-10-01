import 'package:conditional_builder/conditional_builder.dart';
import 'package:cv_analyzer/layout/company/company_layout.dart';
import 'package:cv_analyzer/layout/user/user_layout.dart';
import 'package:cv_analyzer/modules/login/cubit/cubit.dart';
import 'package:cv_analyzer/modules/login/cubit/states.dart';
import 'package:cv_analyzer/modules/login/or_divider.dart';
import 'package:cv_analyzer/modules/login/social_icon.dart';
import 'package:cv_analyzer/modules/register/register_screen.dart';
import 'package:cv_analyzer/shared/components/components.dart';
import 'package:cv_analyzer/shared/components/constants.dart';
import 'package:cv_analyzer/shared/network/local/cache_helper.dart';
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    // Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (kDebugMode) {
              print('id : ${state.loginModel.data!.id}');
            }

            showToast(
              text: 'You are logged in successfully',
              state: ToastStates.SUCCESS,
            );
            CacheHelper.saveData(
              key: 'token',
              value: state.loginModel.token,
            ).then((value) {
              token = '${state.loginModel.token}';
              if (state.loginModel.data!.role == 'Employee') {
                CacheHelper.saveData(
                    key: 'role', value: state.loginModel.data!.role);
                navigateAndFinish(context, UserHome(model: state.loginModel));
              } else if ((state.loginModel.data!.role == 'Company')) {
                CacheHelper.saveData(
                    key: 'role', value: state.loginModel.data!.role);
                navigateAndFinish(context, const CompanyHome());
              }
              //else ADMIN
            });
          } else if (state is LoginErrorState) {
            showToast(
              text: 'login error',
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: defaultColorAppBar,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: defaultColorAppBar,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Login',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black.withAlpha(140),
                                    ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
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
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          labelText: 'Password',
                          prefixIcon: Icons.lock,
                          onPassword: LoginCubit.get(context).isPasswordShow,
                          suffixIcon: LoginCubit.get(context).suffix,
                          suffixPress: () {
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your password';
                            }
                            return null;
                          },
                          // onSubmitted: (value) {
                          //   print('ahmad');
                          //   if (formKey.currentState!.validate()) {
                          //     LoginCubit.get(context).userLogin(
                          //       email: emailController.text,
                          //       password: passwordController.text,
                          //     );
                          //   }
                          // },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                            text: 'login',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            background: defaultColor,
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              text: 'register',
                              function: () {
                                navigateTo(context, RegisterScreen());
                              },
                            ),
                          ],
                        ),
                        OrDivider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SocalIcon(
                              iconSrc: "assets/icons/facebook.svg",
                              press: () {
                                return null;
                              },
                            ),
                            SocalIcon(
                              iconSrc: "assets/icons/twitter.svg",
                              press: () {
                                return null;
                              },
                            ),
                            SocalIcon(
                              iconSrc: "assets/icons/google-plus.svg",
                              press: () {
                                return null;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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
