import 'package:flutter/material.dart';
import 'package:social_app/util/constant.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstant.users),
      ),
      body: Column(
        children: [
          Text('users'),
        ],
      ),
    );
  }
}
