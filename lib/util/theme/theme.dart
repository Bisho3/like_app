import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
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

ThemeData darkTheme = ThemeData(
  // primarySwatch: MyColors.primaryColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  fontFamily: "hanimation",
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: MyColors.primaryColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: MyColors.primaryColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),
  textTheme:  TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: MyColors.whiteColor,
    ),
    subtitle1: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: MyColors.whiteColor,
      height: 1.3,
    ),
    caption: const TextStyle(
      color: MyColors.whiteColor
    ),
    subtitle2: const TextStyle(
        color: MyColors.whiteColor
    ),
  ),
  cardTheme: CardTheme(
    color: HexColor('333739'),
    surfaceTintColor: MyColors.yellowColor,
    shadowColor: MyColors.lightGrey,
    clipBehavior: Clip.antiAliasWithSaveLayer,
  ),
  iconTheme: const IconThemeData(
    color: MyColors.whiteColor,
  ),
  inputDecorationTheme:  InputDecorationTheme(
    hintStyle: TextStyle(
      color: MyColors.lightGrey ,
      fontSize: 14.sp
    ),
    prefixIconColor: MyColors.greyColor,
      suffixIconColor: MyColors.greyColor,
    labelStyle: const TextStyle(
      color: MyColors.greyColor,
    ),

  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(MyColors.lightGrey)
    )
  ),
);
