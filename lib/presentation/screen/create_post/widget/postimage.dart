import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/util/style.dart';

class PostImage extends StatelessWidget {
  const PostImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LogicCubit cubit = LogicCubit.get(context);
        return Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              height: 140.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                    image:Image(image: FileImage(cubit.postImage!.absolute))
                        .image),
              ),
            ),
            IconButton(
              onPressed: () {
                cubit.removePostImage();
              },
              icon: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.lightGrey,
                    ),
                    shape: BoxShape.circle),
                child: CircleAvatar(
                  radius: 20.w,
                  backgroundColor: MyColors.whiteColor,
                  child: Icon(
                    Icons.close,
                    color: MyColors.greyColor,
                    size: 18.sp,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
