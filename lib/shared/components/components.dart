// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:io';
import 'package:cv_analyzer/modules/login/login_screen.dart';
import 'package:cv_analyzer/modules/pdf_viewer_page/pdf_viewer_page.dart';
import 'package:cv_analyzer/shared/network/local/cache_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//--------------------defaultButton----------------------------
Widget defaultButton({
  Color background = Colors.blue,
  double width = double.infinity,
  double height = 40.0,
  double ?radius=10.0 ,

  bool isUpperCase = true,
  @required String? text,
  @required Function? function,
}) =>
    Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius!),
          color: background,
        ),

        child: MaterialButton(
          // height: 40.0,
          onPressed: () {
            function!();
          },
          child: Text(
            isUpperCase ? text!.toUpperCase() : text!,
            style: const TextStyle(
              color: Colors.white,

            ),
          ),
        ),
      ),
    );


//--------------------defaultTextButton----------------------------
Widget defaultTextButton({
  @required Function()? function,
  @required String? text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text!.toUpperCase()),
    );



//--------------------defaultTextButton----------------------------
Widget defaultFormField({
  @required TextEditingController? controller,
  @required TextInputType? type,
  String? Function(String?)? onSubmitted,
  @required String? labelText,
  IconData? prefixIcon,
  IconData? suffixIcon,
  Function? suffixPress,
  bool onPassword = false,
  Function(String)? onChange,
  @required String? Function(String?)? validate,
  var  maxLines = 1,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      maxLines: maxLines,
      obscureText: onPassword,
      onChanged: onChange,
      validator: validate,
      onFieldSubmitted: onSubmitted,

      decoration: InputDecoration(
        labelText: labelText,

        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            suffixIcon,
          ),
          onPressed: () {
            suffixPress!();
          },
        ),
        border: const OutlineInputBorder(),
      ),
    );


//--------------------myDivider----------------------------
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );


//--------------------navigateTo----------------------------
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );


//--------------------navigateAndFinish----------------------------
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      //عايز الغي يلي فات او اخلي true
      (Route<dynamic> route) => false,
    );


//--------------------Toast----------------------------
void showToast({
  required String text,
  required ToastStates state,
}) =>
    Toast.show(
      text,
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
      backgroundColor: chooseToastColor(state),
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
//--------------------defaultTextButton----------------------------

//----------DATE ---------
Widget defaultFormField_Date({
  @required TextEditingController? controller,
  @required TextInputType? type,
  Function? onSubmitted,
  Function? onTap,
  @required String? validate,
  @required String? labelText,
  @required IconData? prefixIcon,
  IconData? suffixIcon,
  Function? suffixPress,
  bool onPassword = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: onPassword,
      onTap: () {
        onTap!();
      },
      onChanged: (val) {
        if (kDebugMode) {
          print(val);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return validate;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            suffixIcon,
          ),
          onPressed: () {
            suffixPress!();
          },
        ),
        border: const OutlineInputBorder(),
      ),
    );
//---------------------------
Widget buildItemBoxJob(icon, item, required)
{
  return Row(
    children: [
      Icon(
        icon,
        color: Colors.black87,
        size: 30,
      ),
      Text(
        '  $item',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
      ),
      Expanded(
        child: Text(
          required,
          maxLines:3 ,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
//--------------Sing Up----------
void signOut(context)
{
  CacheHelper.removeData(key: 'token',).then((value){
    if(value)
    {
      token='';
      CacheHelper.removeData(key: 'role',).then((value){
        if(value)
        {
          role='';
        }
      });
      navigateAndFinish(context, LoginScreen(),);
    }
  });
}

// PDF File
Future<File?> pickFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );
  if (result == null) return null;
  return File(result.paths.first ?? '');
}

Future<File> loadPdfFromNetwork(String url) async {
  final response = await http.get(Uri.parse(url));
  final bytes = response.bodyBytes;
  return _storeFile(url, bytes);
}

Future<File> _storeFile(String url, List<int> bytes) async {
  final filename = basename(url);
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/$filename');
  await file.writeAsBytes(bytes, flush: true);
  if (kDebugMode) {
    print('$file');
  }
  return file;
}

void openPdf(BuildContext context, File file, String url) =>
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PdfViewerPage(
          file: file,
          url: url,
        ),
      ),
    );