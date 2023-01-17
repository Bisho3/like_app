import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormField extends StatelessWidget {
  TextInputType type;
  TextEditingController controller;
  String? Function(String? value) validate;
  String text;
  Function? onFieldSubmit;
  Function? onTap;
  IconData? preffixIcon;
  bool isPassword;
  IconData? suffixIcon;
  Function? suffixOnPressed;
  Function? onchange;
  Function? onSubmit;
  Function? preffixOnPressed;
  double radius = 10.0;
  String? initialValue;
  bool borderOutLine = true;

  CustomFormField({
    super.key,
    required this.type,
    required this.controller,
    required this.validate,
    required this.text,
    this.onFieldSubmit,
    this.onTap,
    this.preffixIcon,
    this.isPassword = false,
    this.suffixIcon,
    this.suffixOnPressed,
    this.onchange,
    this.preffixOnPressed,
    this.radius = 10.0,
    this.initialValue,
    this.borderOutLine = true,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      controller: controller,
      onFieldSubmitted: (String value) {
        onFieldSubmit!(value);
      },
      validator: (value) {
        return validate(value);
      },
      onTap: (){
        onTap!();
      },
      style: TextStyle(fontSize: 14.sp),
      initialValue: initialValue,
      obscureText: isPassword,
      decoration: InputDecoration(
        label: Text(
          text,
          style: TextStyle(fontSize: 14.sp),
        ),
        errorStyle: TextStyle(
          fontSize: 14.sp,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(right: 3.w, bottom: 1.h),
          child: Icon(
            preffixIcon,
            size: 22.w,
          ),
        ),
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: EdgeInsets.only(left: 1.w, bottom: 1.h),
                child: IconButton(
                    icon: Icon(
                      suffixIcon,
                      size: 22.w,
                    ),
                    onPressed: () {
                      suffixOnPressed!();
                    }),
              )
            : null,
        border: borderOutLine
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  radius,
                ),
              )
            : null,
      ),
    );
  }
}
