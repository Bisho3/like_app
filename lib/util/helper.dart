import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/util/style.dart';

void navigatorTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigatorAndRemove(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: MyColors.whiteColor,
    fontSize: 12.sp,
  );
}

enum ToastStates { SUCCESS, ERROR, WARMIMG }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARMIMG:
      color = Colors.amber;
      break;
  }
  return color;
}

AwesomeDialog alertDialog({
  required BuildContext context,
  required String textBody,
  required DialogType dialogType,
  required String textButton,
  required Function function,
})=> AwesomeDialog(
  context: context,
  animType: AnimType.scale,
  dialogType: dialogType,
  body: Center(
    child: Text(
    textBody,
    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 16.sp),
  ),
  ),
    dismissOnTouchOutside: false,
  btnOkOnPress: () {
   function();
  },
  btnOkText: textButton
)..show();

