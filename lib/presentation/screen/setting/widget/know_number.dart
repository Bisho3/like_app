import 'package:flutter/material.dart';

class CustomKnownNumberStatus extends StatelessWidget {
  String number;
  String text;
  Function function;
   CustomKnownNumberStatus({Key? key,required this.number,required this.text,required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        child: Column(
          children: [
            Text(number,style: Theme.of(context).textTheme.subtitle2),
            Text(text,style: Theme.of(context).textTheme.caption),
          ],
        ),
        onTap: (){
          function();
        },
      ),
    );
  }
}
