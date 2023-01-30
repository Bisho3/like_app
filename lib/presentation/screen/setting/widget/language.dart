import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/setting/widget/block_edit.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/util/adaptive/adaptive_indicator.dart';
import 'package:social_app/util/constant.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/style.dart';

class Language extends StatelessWidget {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LogicCubit cubit = LogicCubit.get(context);

        return BlockEditOneItem(
          titleText: MyStrings.language,
          widget: ConditionalBuilder(
            condition: state is! ConvertLanguageLoading,
            builder: (context) => Row(
              children: [
                Expanded(
                  child: CustomMaterialButton(
                    function: () {
                      cubit.convertToArabicLanguage(context);
                       SystemNavigator.pop();
                    },
                    text: MyStrings.arabic,
                    radius: 10,
                    textColor: MyColors.primaryColor,
                    background: MyColors.whiteColor,
                    borderRadius: MyColors.foreignColor,
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: CustomMaterialButton(
                    function: () {
                      cubit.convertToEnglishLanguage(context);
                      SystemNavigator.pop();
                      },
                    text: 'English',
                    radius: 10,
                    textColor: MyColors.primaryColor,
                    background: MyColors.whiteColor,
                    borderRadius: MyColors.foreignColor,
                  ),
                ),
              ],
            ),
            fallback: (context) =>
                Center(child: AdaptiveIndicator(
                  os: getOs(),
                )),
          ),
        );
      },
    );
  }
}