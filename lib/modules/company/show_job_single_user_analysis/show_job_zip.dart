
import 'package:cv_analyzer/layout/company/cubit/cubit.dart';
import 'package:cv_analyzer/layout/company/cubit/states.dart';
import 'package:cv_analyzer/models/company/show_job_analysis_model.dart';
import 'package:cv_analyzer/shared/components/components.dart';
import 'package:cv_analyzer/shared/components/constants.dart';
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
ShowJobAnalyzesModel? showJobAnalyzesModel;
class ShowJobZip extends StatelessWidget {
  ShowJobZip({super.key, model})
  {
    showJobAnalyzesModel=model;
  }
  @override
  Widget build(BuildContext context) {
    // create: (context) => CompanyCubit()..getAllJobData(token: token),

    ToastContext().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CompanyCubit()..getAllJobAnalysisData(token: token)),
      ],
      child: BlocConsumer<CompanyCubit, CompanyStates>(
        listener: (context, state) {
          // if (state is CompanySuccessSingleJobAnalysisDataState)
          // {
          //   navigateTo(context, JobSinleAnlysisDetailsCompany(state.showSingleJobAnalyzesModel));
          //   print("Fm : ${state.showSingleJobAnalyzesModel.data!.id!}");
          // }
          // if(state is CompanyErrorSingleJobDataState)
          // {
          //
          // }
        },
        builder: (context, state) {
          return builderHomeCompany(showJobAnalyzesModel!,context);
        },
      ),
    );
  }
}
Widget builderHomeCompany(ShowJobAnalyzesModel model,context)=>Scaffold(
  appBar: AppBar(
    title: const Center(
        child: Text(
          'All Jobs Analysis',
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
  body:buildJobItem(model,context)
);

Widget buildJobItem(model,context)=>SingleChildScrollView(
  // physics: BouncingScrollPhysics(),
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
                                CompanyCubit.get(context).getSingleJobAnalysisData(id: model.id,token: token);
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
          //color: Colors.red,
        ),
      ),
    ],
  ),
);



