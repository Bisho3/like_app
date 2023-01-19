import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/data/model/onboarding/onboarding.dart';
import 'package:social_app/presentation/screen/authentication/screen/login.dart';
import 'package:social_app/presentation/screen/splash_screen_and_onboarding/widget/custom_onboarding_item.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/presentation/shared_widget/custom_text_button.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/images.dart';
import 'package:social_app/util/sharedpreference.dart';
import 'package:social_app/util/style.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: MyImages.firstImageOnBoarding,
      title: MyStrings.firstTextOnBoarding,
      body: '',
    ),
    BoardingModel(
        image: MyImages.secondImageOnBoarding,
        title: MyStrings.secondTextTitleOnBoarding,
        body: MyStrings.secondTextBodyOnBoarding
    ),
    BoardingModel(
        image: MyImages.thiredImageOnBoarding,
        title: MyStrings.thirdTextTitleOnBoarding,
        body: MyStrings.thirdTextBodyOnBoarding),
  ];
  var pageController = PageController();
  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value == true) {
        navigatorAndRemove(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CustomTextButton( function: () {
            submit();
          }, text: "buttonSkip".tr(), color: MyColors.primaryColor,)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(3.h),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
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
                CustomOnBoardingItem(
                  model:boarding[index]
                ),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: 3,
              effect: ScrollingDotsEffect(
                  dotColor: Colors.grey,
                  dotHeight: 13.w,
                  dotWidth: 13.w,
                  fixedCenter: false,
                  spacing: 4.w,
                  activeDotColor: MyColors.primaryColor,
                  strokeWidth: 1.0),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomMaterialButton(
                function: () {
                  if (isLast) {
                    submit();
                  } else {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 750),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  }
                },
                text: "buttonSkip".tr(),
                width: 120.w,
                fontSize: 19.sp
            ),

            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
