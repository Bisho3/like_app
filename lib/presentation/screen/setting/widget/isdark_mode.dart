import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/setting/widget/block_edit.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/style.dart';

class IsDark extends StatefulWidget {
  const IsDark({Key? key}) : super(key: key);

  @override
  State<IsDark> createState() => _IsDarkState();
}

class _IsDarkState extends State<IsDark> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlockEditOneItem(
          titleText: MyStrings.titleIsDark,
          widget: Row(
            children: [
              Text(
                MyStrings.isDark,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1,
              ),
              const Spacer(),
              Switch(
                value:LogicCubit.get(context).isDark? false : true,
                onChanged: (value) {
                  setState(() {
                    isOn = value;
                  });
                  LogicCubit.get(context).changeAppMode();
                },
              activeColor: MyColors.primaryColor,
              inactiveThumbColor: MyColors.foreignColor,
                activeTrackColor: MyColors.lightGrey,
                inactiveTrackColor: MyColors.lightGrey,
                splashRadius: 10.r,
              ),
            ],
          ),
        );
      },
    );
  }
}
