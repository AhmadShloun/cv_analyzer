
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';


ThemeData darkTheme = ThemeData(
  primarySwatch: buildMaterialColor(defaultColor),
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(

    titleSpacing: 20.0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: defaultColor,
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    // backgroundColor: HexColor('333739'),
    backgroundColor: Colors.purple,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor:HexColor('ebeff2'),
  primarySwatch: buildMaterialColor(defaultColor),
  appBarTheme: AppBarTheme(
    //اذا عمل ايرور بحذف المكتبة وبرجعا
    //color: Colors.white,
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: defaultColor,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: defaultColor,
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
);