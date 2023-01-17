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
import 'package:social_app/util/constant.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/style.dart';

class FirstStepRegisterScreen extends StatefulWidget {
  String? phoneNumber;
  FirstStepRegisterScreen({Key? key,required this.phoneNumber}) : super(key: key);
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
  bool notAccept = false;
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: AppConstant.emptyPassword),
    MinLengthValidator(8, errorText: AppConstant.minLengthValidationPassword),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: AppConstant.patternValidationPassword)
  ]);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
      listener:(context,state){} ,
      builder: (context,state){
        AuthCubit cubit = AuthCubit.get(context);
        return SafeArea(
          child: Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: CustomTextRegisterBar(
                        text: AppConstant.firstStepRegister
                    ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomFormField(
                        type: TextInputType.name,
                        text: AppConstant.name,
                        controller: nameController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return AppConstant.emptyName;
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
                        text: AppConstant.eMail,
                        controller: emailController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return AppConstant.emptyEmail;
                          } else if (value.characters.contains("@") &&
                              value.characters.contains(".")) {
                            return null;
                          } else {
                            return AppConstant.errorEmail;
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
                        text: AppConstant.password,
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
                        text: AppConstant.confirmPassword,
                        controller: confirmPasswordController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return AppConstant.emptyConfirmPassword;
                          }
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            return AppConstant.passwordNotIdentical;
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
                        height: 8.h,
                      ),
                      ///==== CheckBox & Text & Text Button For Terms & Condition =====///
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.w,
                            child: Checkbox(
                              activeColor: MyColors.foreignColor,
                              value: notAccept,
                              onChanged: (bool? value) {
                                setState(() {
                                  notAccept = value!;
                                });
                              },
                              shape: const CircleBorder(
                                  side: BorderSide(
                                    color: Colors.blue,
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text(
                            AppConstant.agree,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          CustomTextButton(
                              function: () {},
                              text: AppConstant.termsAndCondition,
                              color: MyColors.primaryColor),
                          Text(
                            AppConstant.and,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          CustomTextButton(
                            function: () {},
                            text: AppConstant.policies,
                          ),
                        ],
                      ),
                      CustomMaterialButton(
                          function: () {
                            if (formKey.currentState!.validate() &&
                                notAccept == true) {
                              navigatorTo(
                                  context, SecondStepRegisterScreen(
                                email: emailController.text,
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                                name: nameController.text,
                                phoneNumber:widget.phoneNumber!,
                              ));
                            } else if (notAccept == false) {
                              showToast(
                                  text: AppConstant.doNotAgreeTerms,
                                  state: ToastStates.WARMIMG);
                            }
                          },
                          text: AppConstant.next,
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
