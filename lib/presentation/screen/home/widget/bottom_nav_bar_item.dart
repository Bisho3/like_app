import 'package:flutter/material.dart';


BottomNavigationBarItem bottomNavBarItem ({
  required IconData icon,
  required String textLabel,
})=>BottomNavigationBarItem(
    icon:  Icon(
      icon,
    ),
    label: textLabel
);
