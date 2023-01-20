import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/business_logic/authentication_logic/cubit.dart';
import 'package:social_app/business_logic/authentication_logic/states.dart';
import 'package:social_app/presentation/screen/authentication/screen/otp_phone.dart';
import 'package:social_app/presentation/screen/authentication/screen/reset_password.dart';
import 'package:social_app/presentation/screen/home/screen/home_screen.dart';
import 'package:social_app/presentation/shared_widget/custom_form_field.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/presentation/shared_widget/custom_text_button.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/images.dart';
import 'package:social_app/util/sharedpreference.dart';
import 'package:social_app/util/style.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ///============== Controller for login ========///
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is UserLoginErrorStates) {
          showToast(
            text: state.error,
            state: ToastStates.WARMIMG,
          );
        }
        if (state is UserLoginSuccessStates) {
          CacheHelper.saveData(key: 'token', value: state.uId).then((value) {
            showToast(text: MyStrings.loginSuccess, state: ToastStates.SUCCESS);
            print("bishoooo${CacheHelper.getData(key: 'token')}");
            navigatorAndRemove(context, const HomeScreen());
          });
        }
        if (state is GoogleSuccess) {
          alertDialog(
              context: context,
              textBody: MyStrings.successCreateUser,
              dialogType: DialogType.success,
              textButton: MyStrings.signIn,
              function: () {
                AuthCubit.get(context).userLoginWithGoogle();
              });
        }
        if (state is FacebookSuccess) {
          alertDialog(
              context: context,
              textBody: MyStrings.successCreateUser,
              dialogType: DialogType.success,
              textButton: MyStrings.signIn,
              function: () {
                AuthCubit.get(context).userLoginWithFacebook();
              });
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        MyImages.accessAccountLogin,
                        fit: BoxFit.cover,
                        height: 180.h,
                        width: 150.w,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                      ///========= TextFormField For Email========///
                      CustomFormField(
                        type: TextInputType.emailAddress,
                        controller: emailcontroller,
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
                        height: 15.h,
                      ),

                      ///========= TextFormField For password========///
                      CustomFormField(
                        type: TextInputType.visiblePassword,
                        controller: passwordcontroller,
                        text: MyStrings.password,
                        preffixIcon: Icons.lock_outline,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return MyStrings.emptyPassword;
                          }
                          return null;
                        },
                        suffixIcon: cubit.suffixLogin,
                        isPassword: cubit.isPasswordLogin,
                        suffixOnPressed: () {
                          cubit.isShowAndHideLoginPassWord();
                        },
                        onTap: () {},
                        borderOutLine: false,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                          child: CustomTextButton(
                              function: () {
                                navigatorTo(context, ResetPasswordScreen());
                              }, text: MyStrings.forgetPassword,color: MyColors.primaryColor,)),
                      SizedBox(
                        height: 10.h,
                      ),
                      ///========== Button For sign up ========///
                      ConditionalBuilder(
                        condition: state is! UserLoginLoadingStates,
                        builder: (context) {
                          return CustomMaterialButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLoginWithEmailAndPassword(
                                    email: emailcontroller.text.trim(),
                                    password: passwordcontroller.text.trim(),
                                  );
                                }
                              },
                              text: MyStrings.signIn,
                              radius: 10.0,
                              background: MyColors.primaryColor,
                              borderRadius: MyColors.primaryColor,
                              fontSize: 16.sp);
                        },
                        fallback: (context) =>
                            const Center(child: RefreshProgressIndicator()),
                      ),

                      SizedBox(
                        height: 3.h,
                      ),

                      ///======== Text & Button Text For input To Register========///
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            MyStrings.doNotHaveAccount,
                            style: TextStyle(
                              color: MyColors.greyColor,
                              fontSize: 16.sp,
                            ),
                          ),
                          CustomTextButton(
                              function: () {
                                navigatorTo(context, OtpPhoneScreen());
                              },
                              text: MyStrings.createAccountNow),
                        ],
                      ),
                      Row(children: <Widget>[
                        const Expanded(child: Divider()),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          MyStrings.orContinueWith,
                          style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        const Expanded(child: Divider()),
                      ]),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.google,
                                size: 25.sp,
                              ),
                              onPressed: () {
                                AuthCubit.get(context).signInWithGoogle();
                              }),
                          IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.facebook,
                                size: 25.sp,
                              ),
                              onPressed: () {
                                cubit.signInWithFacebook();
                              }),
                        ],
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
