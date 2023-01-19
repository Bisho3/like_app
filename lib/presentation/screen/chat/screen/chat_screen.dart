import 'package:flutter/material.dart';
import 'package:social_app/util/strings.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyStrings.chats),
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
