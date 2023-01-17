import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/util/style.dart';

class CustomTextButton extends StatelessWidget {
  Function function;
  String text;
  FontWeight? fontWeight;
  Color color ;
CustomTextButton({super.key,
    required this.function,
  required this.text,
  this.fontWeight ,
  this.color = MyColors.foreignColor
});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text.toUpperCase(),
        style: TextStyle(fontWeight: fontWeight, color: color, fontSize: 16.sp),
      ),
    );
  }
}
