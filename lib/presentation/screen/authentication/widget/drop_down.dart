import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/util/style.dart';

class CustomDropDownButton extends StatelessWidget {
  final List<String> listItems;
  final Function? onChange;
  final String? initialValue;

  const CustomDropDownButton(
      {Key? key,
      required this.listItems,
      required this.onChange,
      required this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity.w,
      // height: 9.h,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        value: initialValue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(
            30,
          ),
          bottomRight: Radius.circular(
            30,
          ),
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
        items: listItems
            .toSet()
            .map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(
                        color: MyColors.greyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp),
                  ),
                ))
            .toList(),
        style: TextStyle(fontSize: 16.sp),
        onChanged: (e) {
          onChange!(e);
        },
      ),
    );
  }
}
