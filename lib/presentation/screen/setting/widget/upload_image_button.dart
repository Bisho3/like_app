import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/util/style.dart';

class CustomUploadImageButton extends StatelessWidget {
  Function function;
   CustomUploadImageButton({Key? key,required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: ()
      {
        function();
      },
      icon: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: MyColors.lightGrey,
            ),
            shape: BoxShape.circle),
        child: CircleAvatar(
          radius:  20.w,
          backgroundColor: MyColors.whiteColor,
          child:  Icon(
            Icons.edit,
            color: MyColors.greyColor,
            size: 18.sp,
          ),
        ),
      ),
    );
  }
}
