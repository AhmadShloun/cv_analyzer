// @dart=2.9
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cv_analyzer/layout/company/company_layout.dart';
import 'package:cv_analyzer/layout/user/user_layout.dart';
import 'package:cv_analyzer/modules/company/test.dart';
import 'package:cv_analyzer/modules/login/login_screen.dart';
import 'package:cv_analyzer/modules/on_boarding/on_boarding_screen.dart';
import 'package:cv_analyzer/shared/bloc_observer.dart';
import 'package:cv_analyzer/shared/components/constants.dart';
import 'package:cv_analyzer/shared/network/local/cache_helper.dart';
import 'package:cv_analyzer/shared/network/remote/dio_helper.dart';
import 'package:cv_analyzer/shared/styles/themes.dart';
import 'package:flutter/material.dart';
Widget widget;
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {

  BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      //await
      DioHelper.init();
      await CacheHelper.init();


      // bool  isDark = CacheHelper.getData(key: 'isDark') ??false ;
      bool  onBoarding = CacheHelper.getData(key: 'onBoarding') ??false ;
      token = CacheHelper.getData(key: 'token')??'';
      role = CacheHelper.getData(key: 'role')??'';
      if(onBoarding)
        {
          if(token != '')
            {
              if(role == 'Employee') {
                widget = UserHome();
              }
              if(role == 'Company') {
                widget = const CompanyHome();
              }
            }
          else {
            widget = LoginScreen();
          }
        }
      else
        {
          widget=const OnBoardingScreen();
        }
      HttpOverrides.global = MyHttpOverrides();
      runApp(MyApp(startWidget: widget,));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({Key key, @required this.startWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:lightTheme ,
      darkTheme:darkTheme,
      themeMode: ThemeMode.light,
      // home:const Splash(),
      home:test(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return widget;
  }
}