import 'package:conditional_builder/conditional_builder.dart';
import 'package:cv_analyzer/layout/company/cubit/cubit.dart';
import 'package:cv_analyzer/layout/company/cubit/states.dart';
import 'package:cv_analyzer/models/company/company_model.dart';
import 'package:cv_analyzer/modules/company/Job_details_company/job_details_company.dart';
import 'package:cv_analyzer/modules/company/create_job/create_job.dart';
import 'package:cv_analyzer/modules/company/cv_analysis/cv_analysis.dart';
import 'package:cv_analyzer/modules/company/test.dart';
import 'package:cv_analyzer/shared/components/components.dart';
import 'package:cv_analyzer/shared/components/constants.dart';
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class CompanyHome extends StatelessWidget {
  const CompanyHome({super.key});

  @override
  Widget build(BuildContext context) {

    ToastContext().init(context);
    return MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => CompanyCubit()..getAllJobData(token: token)),
    ],
      child: BlocConsumer<CompanyCubit, CompanyStates>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            showToast(
              text: '${state.logoutModel.message}',
              state: ToastStates.SUCCESS,
            );
            // CacheHelper.removeData(
            //   key: 'token',
            // ).then((value) {
            //   if (value) {
            //     token = '';
            //     CacheHelper.removeData(
            //       key: 'role',
            //     ).then((value) {
            //       if (value) {
            //         role = '';
            //       }
            //     });
            //   }
            // });
            signOut(context);
          } else if (state is LogoutErrorState) {
            showToast(
              text: '${state.logoutModel.message}',
              state: ToastStates.ERROR,
            );
          }
          if (state is CompanySuccessAllJobDataState) {
            showToast(
              text: 'Data fetched successfully',
              state: ToastStates.SUCCESS,
            );
            // CompanyCubit.get(context).getAllJobData(token: token);
          }
          if (state is CompanyErrorAllJobDataState) {
            showToast(
              text: 'There was an error fetching data',
              state: ToastStates.ERROR,
            );
          }
          if (state is CompanySuccessSingleJobDataState)
            {
              navigateTo(context, JobDetailsCompany(state.companySingleJobModel));
            }
          if(state is CompanyErrorSingleJobDataState){}
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: CompanyCubit.get(context).companyModel != null,
            builder: (context) => builderHomeCompany(CompanyCubit.get(context).companyModel!,context),
            fallback: (context) => Container(color: defaultColorAppBar,child: const Center(child: CircularProgressIndicator(backgroundColor: Colors.black87,))),
          );
        },
      ),
    );
  }
}
Widget builderHomeCompany(CompanyModel model,context)=>Scaffold(
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
  drawer: buildDrawer(CompanyCubit.get(context).companyModel,context),
  body:ConditionalBuilder(
    condition: CompanyCubit.get(context).companyModel != null,
    builder: (context) => ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildJobItem(model.data![index],context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: model.data!.length,
    ),
    fallback: (context) => const Center(child: CircularProgressIndicator(backgroundColor:Colors.black87,)),
  ) ,
);

Widget buildJobItem(DataModel model,context)=>SingleChildScrollView(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white70,
          ),
          width: double.infinity,
          height: 450,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.white70,
                      backgroundImage:
                      AssetImage('assets/images/job1.png'),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${model.subject}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge,
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.today,
                                color: Colors.black54,
                              ),
                              Text(
                                'from 15 minutes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'OoohBaby',
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    // height: 300.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: defaultColorAppBar,
                    ),
                    //color: defaultColorAppBar,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        children: [
                          buildItemBoxJob(Icons.code, 'Skills : ',
                              '${model.requiredSkills}'),
                          const SizedBox(
                            height: 10,
                          ),
                          buildItemBoxJob(
                              Icons.work_outline_outlined,
                              'Work Experience : ',
                              '${model.requiredWorkExperience}'),
                          const SizedBox(
                            height: 10,
                          ),
                          buildItemBoxJob(
                              Icons.engineering,
                              'Soft Skills : ',
                              '${model.requiredSoftSkills}'),
                          const SizedBox(
                            height: 10,
                          ),
                          buildItemBoxJob(Icons.language,
                              'Languages : ', '${model.requiredLanguages}'),
                          const SizedBox(
                            height: 10,
                          ),
                          buildItemBoxJob(Icons.access_time_sharp,
                              'Expire Time : ', '${model.expireTime}'),
                          const SizedBox(
                            height: 10,
                          ),
                          buildItemBoxJob(Icons.spa,
                              'Status Job : ', '${model.status}'),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            children: const [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.black,
                                size: 25,
                              ),
                              Text('Damasuce - Roken Aldden'),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            width: 35,
                            height: 35,
                            child: FloatingActionButton(
                              heroTag: null,
                              foregroundColor: Colors.white,
                              backgroundColor: defaultColor,
                              onPressed: () {
                                if (kDebugMode) {
                                  print('ID Item${model.id}');
                                }
                                CompanyCubit.get(context).getSingleJobData(id: model.id,token: token);
                                
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  ),
);

Widget buildDrawer(model,context) {
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
