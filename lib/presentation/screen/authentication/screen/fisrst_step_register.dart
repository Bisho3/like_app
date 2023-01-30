import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:social_app/business_logic/authentication_logic/cubit.dart';
import 'package:social_app/business_logic/authentication_logic/states.dart';
import 'package:social_app/presentation/screen/authentication/screen/second_step_register.dart';
import 'package:social_app/presentation/screen/authentication/widget/text_register_bar.dart';
import 'package:social_app/presentation/shared_widget/custom_form_field.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/presentation/shared_widget/custom_text_button.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/style.dart';

class FirstStepRegisterScreen extends StatefulWidget {
  final String? phoneNumber;

  const FirstStepRegisterScreen({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  State<FirstStepRegisterScreen> createState() =>
      _FirstStepRegisterScreenState();
}

class _FirstStepRegisterScreenState extends State<FirstStepRegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: MyStrings.emptyPassword),
    MinLengthValidator(8, errorText: MyStrings.minLengthValidationPassword),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: MyStrings.patternValidationPassword)
  ]);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return SafeArea(
          child: Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: CustomTextRegisterBar(text: MyStrings.firstStepRegister),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomFormField(
                        type: TextInputType.name,
                        text: MyStrings.name,
                        controller: nameController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return MyStrings.emptyName;
                          }
                          return null;
                        },
                        radius: 30.0,
                        preffixIcon: Icons.person,
                        onTap: () {},
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomFormField(
                        type: TextInputType.emailAddress,
                        text: MyStrings.eMail,
                        controller: emailController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return MyStrings.emptyEmail;
                          } else if (value.characters.contains("@") &&
                              value.characters.contains(".")) {
                            return null;
                          } else {
                            return MyStrings.errorEmail;
                          }
                        },
                        radius: 30.0,
                        preffixIcon: Icons.email_outlined,
                        onTap: () {},
                      ),
                      SizedBox(
                        height: 15.h,
                      ),

                      ///=========== TextFormField For Password=====///
                      CustomFormField(
                        type: TextInputType.visiblePassword,
                        text: MyStrings.password,
                        controller: passwordController,
                        validate: passwordValidator,
                        suffixIcon: cubit.suffixRegisterPassword,
                        isPassword: cubit.isPasswordRegisterPassword,
                        suffixOnPressed: () {
                          cubit.isShowAndHideRegisterPassword();
                        },
                        radius: 30.0,
                        preffixIcon: Icons.lock_outline,
                        onTap: () {},
                      ),
                      SizedBox(
                        height: 15.h,
                      ),

                      ///=========== TextFormField For Confirm Password=====///
                      CustomFormField(
                        type: TextInputType.visiblePassword,
                        text: MyStrings.confirmPassword,
                        controller: confirmPasswordController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return MyStrings.emptyConfirmPassword;
                          }
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            return MyStrings.passwordNotIdentical;
                          }
                          return null;
                        },
                        suffixIcon: cubit.suffixRegisterConfirmPassword,
                        isPassword: cubit.isPasswordRegisterConfirmPassword,
                        suffixOnPressed: () {
                          cubit.isShowAndHideRegisterConfirmPassword();
                        },
                        radius: 30.0,
                        preffixIcon: Icons.lock_outline,
                        onTap: () {},
                      ),

                      SizedBox(
                        height: 30.h,
                      ),

                      ///==== CheckBox & Text & Text Button For Terms & Condition =====///
                      CustomMaterialButton(
                          function: () {
                            if (formKey.currentState!.validate() ) {
                              navigatorTo(
                                  context,
                                  SecondStepRegisterScreen(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    confirmPassword:
                                        confirmPasswordController.text.trim(),
                                    name: nameController.text.trim(),
                                    phoneNumber: widget.phoneNumber!.trim(),
                                  ));
                            }
                          },
                          text: MyStrings.next,
                          radius: 10.0,
                          background: MyColors.primaryColor,
                          borderRadius: MyColors.primaryColor,
                          fontSize: 20.sp),
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
