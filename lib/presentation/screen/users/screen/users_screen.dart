import 'package:flutter/material.dart';
import 'package:social_app/util/strings.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyStrings.users),
      ),
      body: Column(
        children: [
          Text('users'),
        ],
      ),
    );
  }
}
