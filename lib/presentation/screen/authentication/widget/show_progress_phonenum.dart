import 'package:flutter/material.dart';
import 'package:social_app/util/style.dart';

void showProgressIndicator(BuildContext context) {
  AlertDialog alertDialog = const AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(MyColors.blackColor),
      ),
    ),
  );
  showDialog(
      barrierColor: MyColors.whiteColor.withOpacity(0),
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return alertDialog;
      });
}
