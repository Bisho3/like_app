import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
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
    return BlocConsumer<LogicCubit,LogicStates>(
      listener:(context,state){} ,
      builder: (context,state){
       return SizedBox(
          width: double.infinity.w,
          // height: 9.h,
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: initialValue,
            dropdownColor: LogicCubit.get(context).isDark ? MyColors.whiteColor : HexColor('333739'),
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
                borderRadius: BorderRadius.circular(30),
              ),
              enabledBorder: LogicCubit.get(context).isDark
                  ? OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: MyColors.greyColor,
                  ),
                borderRadius: BorderRadius.circular(30),
              )
                  :  OutlineInputBorder(
                borderSide:const BorderSide(color: MyColors.lightGrey),
                borderRadius: BorderRadius.circular(30),

              ),
            ),
            items: listItems
                .toSet()
                .map((e) => DropdownMenuItem<String>(
              value: e,
              child: Text(
                e,
                style: TextStyle(
                    color: LogicCubit.get(context).isDark ? MyColors.greyColor:MyColors.whiteColor,
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
      },
    );
  }
}
