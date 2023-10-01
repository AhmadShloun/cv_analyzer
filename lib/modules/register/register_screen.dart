import 'package:cv_analyzer/modules/register/register_company/register_company.dart';
import 'package:cv_analyzer/modules/register/register_user/register_user.dart';
import 'package:cv_analyzer/shared/components/components.dart';
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: defaultColor),
        backgroundColor: defaultColorAppBar,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: defaultColorAppBar,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Image(image: AssetImage('assets/images/register.png')),
            const Spacer(),
            defaultButton(
              text: 'Register as a company',
              background: defaultColor,
              function: () {
                navigateTo(context, RegisterCompany());
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            defaultButton(
              text: 'Register as a user',
              background: defaultColor,
              function: () {
                navigateTo(context, RegisterUser());
              },
            ),
          ],
        ),
      ),
    );
  }
}
