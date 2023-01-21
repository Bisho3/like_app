import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/setting/widget/block_edit.dart';
import 'package:social_app/presentation/shared_widget/custom_form_field.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/style.dart';

class ResetPassword extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKeyResetPassword = GlobalKey<FormState>();

  ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {
        if (state is ResetPasswordEditProfileSuccess) {
          showToast(text: MyStrings.resetSuccess, state: ToastStates.SUCCESS);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        LogicCubit cubit = LogicCubit.get(context);

        var userModel = cubit.userModel;
        emailController.text = (userModel?.email)!;

        return Form(
          key: formKeyResetPassword,
          child: Column(
            children: [
              BlockEditOneItem(
                titleText: MyStrings.resetPassword,
                widget: Column(
                  children: [
                    CustomFormField(
                      type: TextInputType.emailAddress,
                      controller: emailController,
                      text: MyStrings.eMail,
                      preffixIcon: Icons.person_outline_sharp,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return MyStrings.emptyEmail;
                        }
                        return null;
                      },
                      borderOutLine: true,
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ConditionalBuilder(
                      condition: state is! ResetPasswordEditProfileLoading,
                      builder: (context) {
                        return CustomMaterialButton(
                            function: () {
                              if (formKeyResetPassword.currentState!
                                  .validate()) {
                                cubit
                                    .resetPassword(emailController.text.trim());
                              }
                            },
                            text: MyStrings.send,
                            radius: 10.0,
                            background: MyColors.primaryColor,
                            borderRadius: MyColors.primaryColor,
                            fontSize: 16.sp);
                      },
                      fallback: (context) =>
                          const Center(child: RefreshProgressIndicator()),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
