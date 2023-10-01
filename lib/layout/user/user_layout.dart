import 'package:conditional_builder/conditional_builder.dart';
import 'package:cv_analyzer/layout/user/cubit/cubit.dart';
import 'package:cv_analyzer/layout/user/cubit/states.dart';
import 'package:cv_analyzer/models/Auth/login_model.dart';
import 'package:cv_analyzer/models/user/user_model.dart';
import 'package:cv_analyzer/modules/user/Job_details_user/job_details_user.dart';
import 'package:cv_analyzer/modules/user/profile_user/profile_user.dart';
import 'package:cv_analyzer/shared/components/components.dart';
import 'package:cv_analyzer/shared/components/constants.dart';
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';


LoginModel? loginModel;
class UserHome extends StatelessWidget {

  UserHome({super.key, model})
  {
    loginModel = model;
  }
  @override
  Widget build(BuildContext context) {

    ToastContext().init(context);
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => LoginCubit()..loginModel,),
        BlocProvider(create: (context) => UserCubit()..getAllJobData(token: token),)
      ],
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is LogoutUserSuccessState) {
            showToast(
              text: '${state.logoutModel.message}',
              state: ToastStates.SUCCESS,
            );
            signOut(context);
          } else if (state is LogoutUserErrorState) {
            showToast(
              text: '${state.logoutModel.message}',
              state: ToastStates.ERROR,
            );
          }
          if (state is UserSuccessAllJobDataState) {
            showToast(
              text: 'Data fetched successfully',
              state: ToastStates.SUCCESS,
            );
          }
          if (state is UserErrorAllJobDataState) {
            showToast(
              text: 'There was an error fetching data',
              state: ToastStates.ERROR,
            );
          }
          if (state is UserSuccessSingleJobDataState)
          {
            navigateTo(context, JobDetailsUser(state.userSingleJobModel));
          }
          if(state is UserErrorSingleJobDataState){}
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: UserCubit.get(context).userModel != null,
            builder: (context) => builderHomeUser(UserCubit.get(context).userModel!,context),
            fallback: (context) => Container(color: defaultColorAppBar,child: const Center(child: CircularProgressIndicator(backgroundColor: Colors.black87,))),
          );
        },
      ),
    );
  }
}
Widget builderHomeUser(UserModel model,context)=>Scaffold(
  appBar: AppBar(
    title: const Center(
        child: Text(
          'Jobs Chances',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
    actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
  ),
  drawer: buildDrawer(context),
  body: ConditionalBuilder(
    condition: UserCubit.get(context).userModel != null,
    builder: (context) => ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildJobItem(model.data![index],context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: model.data!.length,
    ),
    fallback: (context) => const Center(child: CircularProgressIndicator(backgroundColor:Colors.black87,)),
  ),
);
Widget buildJobItem(DataUserModel model,context)=>SingleChildScrollView(
  physics: const BouncingScrollPhysics(),
  child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white70,
          ),
          width: double.infinity,
          height: 450.0,
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
                    height: 300.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: defaultColorAppBar,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                                UserCubit.get(context).getSingleJobData(id: model.id, token: token);
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
Widget buildDrawer(context) {
  return Drawer(
    child: Row(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text('Name : Ahmad Shloun '),
                accountEmail: const Text('Email  : kingsh201@gmail.com'),
                currentAccountPicture: const CircleAvatar(
                  child: Icon(
                    Icons.person_outline,
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
                leading: const Icon(Icons.person),
                title: const Text("Profile"),
                onTap: () {
                  navigateTo(context, ProfileUser(loginModel!));
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.upload),
              //   title: Text("upload Cv"),
              //   onTap: () {
              //     UserCubit.get(context).pickFiles();
              //   },
              // ),
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
                  UserCubit.get(context).userLogout(token: token);
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
