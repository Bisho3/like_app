import 'package:flutter/material.dart';
import 'package:social_app/util/style.dart';

class CustomMyDivider extends StatelessWidget {
  const CustomMyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 10.0,
        bottom: 10.0,
        start: 10.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1,
        color: MyColors.greyColor,
      ),
    );
  }
}
