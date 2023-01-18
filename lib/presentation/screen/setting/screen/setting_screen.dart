import 'package:flutter/material.dart';
import 'package:social_app/util/constant.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstant.settings),
      ),
      body: Column(
        children: [
          Text('settings')
        ],
      ),
    );
  }
}
