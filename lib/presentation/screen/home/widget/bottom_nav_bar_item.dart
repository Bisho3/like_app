import 'package:flutter/material.dart';
import 'package:social_app/util/strings.dart';


BottomNavigationBarItem bottomNavBarItem ({
  required IconData icon,
  required String textLabel,
})=>BottomNavigationBarItem(
    icon:  Icon(
      icon,
    ),
    label: textLabel
);
