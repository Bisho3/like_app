import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextRegisterBar extends StatelessWidget {
  String text;

  CustomTextRegisterBar({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: Padding(
        padding: EdgeInsets.all(14.h),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
        ),
      ),
    );
  }
}
