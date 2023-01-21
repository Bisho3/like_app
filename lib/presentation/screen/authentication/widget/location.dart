import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class CustomLocation extends StatelessWidget {
  final BuildContext context;
  final TextEditingController controller;

  const CustomLocation({
    Key? key,
    required this.context,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLocationPicker(
          initZoom: 11,
          minZoomLevel: 5,
          maxZoomLevel: 16,
          trackMyPosition: true,
          onPicked: (pickedData) {
            Navigator.pop(context);
            controller.text = pickedData.address;
          }),
    );
  }
}
