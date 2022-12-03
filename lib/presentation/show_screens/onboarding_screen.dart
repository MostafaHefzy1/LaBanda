import 'package:flutter/material.dart';
import 'package:labanda/data/service/data_local/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/string_manager.dart';
import '../resources/value_manager.dart';

class BoardingModel {
  final String image;
  final String title;
  final String subTitle;

  BoardingModel(
      {required this.image, required this.title, required this.subTitle});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  List<BoardingModel> boarding = [
    BoardingModel(
      image: ImageAssets.onBoarding1,
      title: AppStrings.titleOnBoarding1,
      subTitle: AppStrings.subtitleOnBoarding1,
    ),
    BoardingModel(
      image: ImageAssets.onBoarding2,
      title: AppStrings.titleOnBoarding2,
      subTitle: AppStrings.subtitleOnBoarding2,
    ),
    BoardingModel(
      image: ImageAssets.onBoarding3,
      title: AppStrings.titleOnBoarding3,
      subTitle: AppStrings.subtitleOnBoarding3,
    ),
  ];

  bool isLast = false;

  void submit() {
    CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value == true) {
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: BouncingScrollPhysics(),
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
                itemBuilder: (context, index) =>
                    bulidBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: AppSize.s40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                      activeDotColor: ColorManager.primaryColor,
                      dotColor: ColorManager.myGrey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                  backgroundColor: ColorManager.primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bulidBoardingItem(BoardingModel model) => Column(
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          SizedBox(
            height: AppSize.s14,
          ),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            model.subTitle,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: AppSize.s14,
          ),
        ],
      );
}
