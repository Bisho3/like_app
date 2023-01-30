import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/business_logic/authentication_logic/cubit.dart';
import 'package:social_app/business_logic/authentication_logic/states.dart';
import 'package:social_app/presentation/shared_widget/custom_form_field.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/util/adaptive/adaptive_indicator.dart';
import 'package:social_app/util/constant.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/images.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/style.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          showToast(text: MyStrings.resetSuccess, state: ToastStates.SUCCESS);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        MyImages.resetPasswordImage,
                        fit: BoxFit.cover,
                        height: 180.h,
                        width: 150.w,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),

                      ///========= TextFormField For Email========///
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
                        borderOutLine: false,
                        onTap: () {},
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      ConditionalBuilder(
                        condition: state is! ResetPasswordLoading,
                        builder: (context) {
                          return CustomMaterialButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  AuthCubit.get(context).resetPassword(
                                      emailController.text.trim());
                                }
                              },
                              text: MyStrings.send,
                              radius: 10.0,
                              background: MyColors.primaryColor,
                              borderRadius: MyColors.primaryColor,
                              fontSize: 16.sp);
                        },
                        fallback: (context) =>
                            Center(child: AdaptiveIndicator(
                              os: getOs(),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
