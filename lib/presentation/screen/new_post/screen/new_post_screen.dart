import 'package:flutter/material.dart';
import 'package:social_app/util/constant.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstant.uploadPost),
      ),
      body: Column(
        children: [
          Text('new post'),
        ],
      ),
    );
  }
}
