import 'package:flutter/material.dart';
import 'package:social_app/util/style.dart';

class CustomMaterialButton extends StatelessWidget {
  double? width;
  Color? background ;
  Function function;
  String text;
  double? fontSize ;
  Color? textColor ;
  double? radius ;
  Color borderRadius ;

  CustomMaterialButton({super.key,
    required this.function,
    required this.text,
    this.width = double.infinity,
    this.background = MyColors.primaryColor,
    this.fontSize = 18,
    this.textColor = MyColors.whiteColor,
    this.radius = 30.0,
    this.borderRadius = MyColors.primaryColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(
            radius!,
          ),
          border: Border.all(color: borderRadius)),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
