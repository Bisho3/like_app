import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/util/style.dart';

class BlockEditOneItem extends StatelessWidget {
  final String titleText;
  final Widget widget;
   const BlockEditOneItem({Key? key,required this.titleText,required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: MyColors.foreignColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: Column(
          children: [
            Text(
              titleText,
              style: TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            widget,
          ],
        ),
      ),
    );
  }
}
