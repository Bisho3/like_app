import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/data/model/message/message.dart';
import 'package:social_app/util/style.dart';

class Message extends StatelessWidget {
  final MessageModel model;

  const Message({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.lightGrey,
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.r),
            topStart: Radius.circular(10.r),
            topEnd: Radius.circular(10.r),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        child: Text(
          "${model.text}",
        ),
      ),
    );
  }
}
