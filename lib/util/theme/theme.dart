

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/util/style.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: MyColors.whiteColor,
  fontFamily: "hanimation",
  appBarTheme: const AppBarTheme(
    backgroundColor: MyColors.whiteColor,
    elevation: 0.0,
    backwardsCompatibility: false,
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: MyColors.whiteColor,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: MyColors.blackColor,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: MyColors.blackColor),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: MyColors.primaryColor,
    unselectedItemColor: MyColors.greyColor,
    elevation: 20.0,
    backgroundColor: MyColors.whiteColor,
  ),
  textTheme:  TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: MyColors.blackColor,
    ),
    subtitle1: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: MyColors.blackColor,
      height: 1.3,
    ),
  ),
);
