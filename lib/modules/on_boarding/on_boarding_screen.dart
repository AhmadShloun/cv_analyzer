import 'package:cv_analyzer/modules/login/login_screen.dart';
import 'package:cv_analyzer/shared/components/components.dart';
import 'package:cv_analyzer/shared/network/local/cache_helper.dart';
import 'package:cv_analyzer/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String? image;
  final String? title;
  final String? body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/writeCV.png',
      title: 'Write Your CV',
      body:
          'After you register in the application, you must upload your CV in order to increase your chance of getting a new job.',
    ),
    BoardingModel(
      image: 'assets/images/Searchjobs.png',
      title: 'Search Jobs',
      body:
          'You will have many available job opportunities in order to search through them for a suitable job.',
    ),
    BoardingModel(
      image: 'assets/images/Apply.png',
      title: 'Apply For Jobs',
      body:
          'After searching and finding the right job opportunity for you, you can apply for it.',
    ),
    BoardingModel(
      image: 'assets/images/AddNewJob.png',
      title: 'Add New Job',
      body:
          'You can register as a company and add new job opportunities and our system will suggest the best suitable employees for you.',
    ),
    BoardingModel(
      image: 'assets/images/Anlayze.png',
      title: 'Analyze CVs',
      body:
          'Also, if you are a company, you can upload a number of CVs to be analyzed by our system.',
    ),
    BoardingModel(
      image: 'assets/images/WelCome.png',
      title: 'Welcome to CV Analysis',
      body: '',
    ),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, LoginScreen(),);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultColorAppBar,

        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: defaultColorAppBar,
          statusBarIconBrightness: Brightness.dark,
        ),
        actions: [
          if (!isLast) defaultTextButton(function: submit, text: 'skip'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(

                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            if (!isLast)
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      //المسافات بين النقط
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                    count: boarding.length,
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    foregroundColor: Colors.white,
                    backgroundColor: defaultColor,
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Center(
            child: Text(
              '${model.title}',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: const TextStyle(
              fontSize: 14.5,
              height: 1.5,
            ),
          ),
          if (model.body == '')
            defaultButton(
              text: 'Get Started',
              height: 50.0,
              radius: 80.0,
              background: defaultColor,
              function: () {
                submit();
              },
            ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      );
}
