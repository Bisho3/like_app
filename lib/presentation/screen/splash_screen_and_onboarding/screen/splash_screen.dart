import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/util/images.dart';


class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key,required this.startScreen}) : super(key: key);

  Widget startScreen;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer(const Duration(seconds: 5), () {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => widget.startScreen,
        ),
      );
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(10.h),
        child: Center(
          child:SvgPicture.asset(MyImages.splashImage),
        ),
      ),
    );
  }
}
