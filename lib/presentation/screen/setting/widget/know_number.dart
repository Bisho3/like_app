import 'package:flutter/material.dart';

class CustomKnownNumberStatus extends StatelessWidget {
  final String number;
  final String text;


  const CustomKnownNumberStatus(
      {Key? key,
      required this.number,
      required this.text,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(number, style: Theme.of(context).textTheme.subtitle2),
          Text(text, style: Theme.of(context).textTheme.caption),
        ],
      ),
    );
  }
}
