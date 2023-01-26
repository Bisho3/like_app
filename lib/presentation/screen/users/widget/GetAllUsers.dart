import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/data/model/authentication/create_user.dart';

class GetAllUser extends StatelessWidget {
  final CreateUser model;

  const GetAllUser({Key? key,required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.sp,
            backgroundImage: NetworkImage("${model.profileImage}"),
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            "${model.name}",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
