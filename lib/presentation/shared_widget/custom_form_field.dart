import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormField extends StatelessWidget {
  final TextInputType type;
  final TextEditingController controller;
  final String? Function(String? value) validate;
  final String text;
  final Function? onFieldSubmit;
  final Function? onTap;
  final IconData? preffixIcon;
  final bool isPassword;
  final IconData? suffixIcon;
  final Function? suffixOnPressed;
  final Function? onchange;
  final Function? onSubmit;
  final Function? preffixOnPressed;
  final double radius;
  final String? initialValue;
  final bool borderOutLine;

  const CustomFormField({
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
      onTap: () {
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
