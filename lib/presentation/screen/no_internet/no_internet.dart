import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/util/constant.dart';
import 'package:social_app/util/images.dart';
import 'package:social_app/util/style.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(MyImages.disConnectInternet, height: 300.h),
            SizedBox(
              height: 1.h,
            ),
            Text(
              AppConstant.noInternet,
              style: TextStyle(
                color: MyColors.foreignColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              AppConstant.noInternetStatus,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomMaterialButton(
              function: () {},
              text: AppConstant.tryAgain,
              radius: 10.r,
              width: 180.w,
              fontSize: 22.sp,
              background: MyColors.whiteColor,
              textColor: MyColors.foreignColor,
              borderRadius: MyColors.foreignColor,
            ),
          ],
        ),
      ),
    );
  }
}
