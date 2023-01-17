import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/data/model/onboarding/onboarding.dart';
import 'package:social_app/util/style.dart';

class CustomOnBoardingItem extends StatelessWidget {
   CustomOnBoardingItem({Key? key,required this.model}) : super(key: key);
  BoardingModel model;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: SvgPicture.asset(
                model.image,
                color: MyColors.primaryColor,
                width: 100.0.w,
                height: 150.h,
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Text(
              model.title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 4.0.h,
          ),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 17.sp,
              color: Colors.grey,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}