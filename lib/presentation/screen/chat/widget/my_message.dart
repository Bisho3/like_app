import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/data/model/message/message.dart';
import 'package:social_app/util/style.dart';

class MyMessage extends StatelessWidget {
 final MessageModel model;
  const MyMessage({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.primaryColor.withOpacity(0.2 ),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.r),
            topStart: Radius.circular(10.r),
            topEnd: Radius.circular(10.r),
          ),
        ),
        padding: EdgeInsets.symmetric(
            vertical: 5.h,
            horizontal: 10.w,
        ),
        child: Text(
          "${model.text}",
        ),
      ),
    );
  }
}

