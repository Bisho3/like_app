import 'package:flutter/material.dart';
import 'package:social_app/util/strings.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyStrings.uploadPost),
      ),
      body: Column(
        children: [
          Text('new post'),
        ],
      ),
    );
  }
}
