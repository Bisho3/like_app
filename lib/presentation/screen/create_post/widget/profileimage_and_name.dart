import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';

class ProfileImageAndName extends StatelessWidget {
  const ProfileImageAndName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LogicCubit cubit = LogicCubit.get(context);
        return Row(
          children: [
            CircleAvatar(
              radius: 25.sp,
              backgroundImage: NetworkImage("${cubit.userModel?.profileImage}"),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Text(
                "${cubit.userModel?.name}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        );
      },
    );
  }
}
