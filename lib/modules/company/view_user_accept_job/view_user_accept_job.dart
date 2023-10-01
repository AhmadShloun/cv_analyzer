import 'package:cv_analyzer/models/company/company_single_job.dart';
import 'package:cv_analyzer/shared/components/components.dart';
import 'package:cv_analyzer/shared/components/constants.dart';
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
CompanySingleJobModel? compModel;
class ViewUserJob extends StatelessWidget {
  @override
  ViewUserJob({super.key, model})
  {
    compModel = model;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View User',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.separated(
          // itemBuilder: (context, index) => User_Info(users[index], context),
          itemBuilder: (context, index) => JobItem(compModel!.data!.jobApplicants![index],context),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey,
                ),
              ),
          itemCount: compModel!.data!.jobApplicants!.length),
    );
  }
}
Widget JobItem(JobApplicants model,context) => Row(
  mainAxisAlignment: MainAxisAlignment.start,
  // crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    CircleAvatar(
      radius: 30.0,
      backgroundColor: defaultColor,
      child: Text(
        '${model.score}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          // fontWeight: FontWeight.bold,
        ),
      ),
    ),
    const SizedBox(
      width: 20.0,
    ),
    Text(
      '${model.employee!.firstName}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    ),
    const Spacer(),
    defaultTextButton(

      function: () async {

        isNetwork = false;
        if (kDebugMode) {
          print("ahmad");
        }
        // const url = "http://10.0.2.2:8000/employees/CVs/1660004963.pdf";
        // http://localhost:8000/employees/CVs/1660004963.pdf
        const url = 'http://10.0.2.2:8000/employees/CVs/1660004963.pdf';
        final file = await loadPdfFromNetwork(url);
        openPdf(context, file, url);
      },
      text: 'Show Cv',
    ),
  ],
);