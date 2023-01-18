import 'package:flutter/material.dart';
import 'package:social_app/util/constant.dart';


BottomNavigationBarItem bottomNavBarItem ({
  required IconData icon,
  required String textLabel,
})=>BottomNavigationBarItem(
    icon:  Icon(
      icon,
    ),
    label: textLabel
);
