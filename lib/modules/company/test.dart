import 'package:cv_analyzer/layout/company/cubit/cubit.dart';
import 'package:cv_analyzer/modules/company/create_job/create_job.dart';
import 'package:cv_analyzer/modules/company/cv_analysis/cv_analysis.dart';
import 'package:cv_analyzer/shared/components/components.dart';
import 'package:cv_analyzer/shared/components/constants.dart';
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
class test extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
              'All Jobs',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: buildDrawer(context),

    );
  }
}
Widget buildDrawer(context) {
  return Drawer(
    child: Row(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text('Name : Development Company'),
                accountEmail: const Text('Email  : company@gmail.com'),
                currentAccountPicture: const CircleAvatar(
                  child: Icon(
                    Icons.work_outline,
                    size: 50,
                  ),
                ),
                decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: const BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(100.0),
                    )),
                currentAccountPictureSize: const Size.square(80.0),
              ),
              ListTile(
                leading: const Icon(Icons.post_add_sharp),
                title: const Text("Create New Job"),
                onTap: () {
                  navigateTo(context, CreateJobCompany());
                },
              ),
              ListTile(
                leading: const Icon(Icons.manage_search),
                title: const Text("CV analysis"),
                onTap: () {
                  navigateTo(context, CvAnalysis());
                },
              ),
              ListTile(
                leading: const Icon(Icons.article_outlined),
                title: const Text("Show All Analysis"),
                onTap: () {
                  navigateTo(context,test());
                },
              ),

              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Setting"),
                onTap: () {},
              ),

              const Divider(),
              ListTile(
                title: const Text("LOGOUT"),
                leading: const Icon(Icons.exit_to_app),
                onTap: () {
                  CompanyCubit.get(context).companyLogout(token: token);
                  // id = null;
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}