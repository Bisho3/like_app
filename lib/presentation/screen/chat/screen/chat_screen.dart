import 'package:flutter/material.dart';
import 'package:social_app/util/constant.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstant.chats),
      ),
      body: Column(
        children: [
          Text(
            'chaaaats'
          ),
        ],
      ),
    );
  }
}
