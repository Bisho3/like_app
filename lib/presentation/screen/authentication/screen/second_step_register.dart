import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/business_logic/authentication_logic/cubit.dart';
import 'package:social_app/business_logic/authentication_logic/states.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/presentation/screen/authentication/screen/login.dart';
import 'package:social_app/presentation/screen/authentication/widget/drop_down.dart';
import 'package:social_app/presentation/screen/authentication/widget/location.dart';
import 'package:social_app/presentation/screen/authentication/widget/text_register_bar.dart';
import 'package:social_app/presentation/shared_widget/custom_form_field.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/util/adaptive/adaptive_indicator.dart';
import 'package:social_app/util/constant.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/style.dart';

class SecondStepRegisterScreen extends StatefulWidget {
  final String email;
  final String password;
  final String confirmPassword;
  final String name;
  final String phoneNumber;

  const SecondStepRegisterScreen(
      {Key? key,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.name,
      required this.phoneNumber})
      : super(key: key);

  @override
  State<SecondStepRegisterScreen> createState() =>
      _SecondStepRegisterScreenState();
}

class _SecondStepRegisterScreenState extends State<SecondStepRegisterScreen> {
  TextEditingController addressController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  String initialCityValue = MyStrings.chooseCity;
  String initialAreaValue = MyStrings.chooseArea;
  List<String> listCity = [MyStrings.chooseCity, MyStrings.cairo];
  List<String> listArea = [MyStrings.chooseArea, MyStrings.shoubraMasr];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is CreateUserSuccessStates) {
          alertDialog(
              context: context,
              textBody: MyStrings.successCreateUser,
              dialogType: DialogType.success,
              textButton: MyStrings.signIn,
              color: LogicCubit.get(context).isDark ?MyColors.whiteColor : HexColor('333739'),
              function: () {
                navigatorAndRemove(context, const LoginScreen());
              });
        }
        if (state is UserRegisterErrorStates) {
          showToast(text: state.error, state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title:
                    CustomTextRegisterBar(text: MyStrings.secondStepRegister),
              ),
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10.h),
                    child: Column(
                      children: [
                        CustomDropDownButton(
                          listItems: listCity,
                          initialValue: initialCityValue,
                          onChange: (value) {
                            initialCityValue = value;
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomDropDownButton(
                            listItems: listArea,
                            initialValue: initialAreaValue,
                            onChange: (value) {
                              initialAreaValue = value;
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomFormField(
                          text: MyStrings.address,
                          type: TextInputType.text,
                          controller: addressController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return MyStrings.emptyAddress;
                            }
                            return null;
                          },
                          radius: 30.0,
                          preffixIcon: Icons.home_outlined,
                          onTap: () {},
                        ),
                        SizedBox(
                          height: 10.h,
                        ),

                        ///======TextFormField For Location=====///
                        CustomFormField(
                          text: MyStrings.location,
                          type: TextInputType.text,
                          controller: locationController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return MyStrings.emptyLocation;
                            }
                            return null;
                          },
                          radius: 30.0,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => CustomLocation(
                                context: context,
                                controller: locationController,
                              ),
                            );
                          },
                          preffixIcon: Icons.location_on_outlined,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ConditionalBuilder(
                          condition: state is! UserRegisterLoadingStates,
                          builder: (context) {
                            return CustomMaterialButton(
                                function: () {
                                  if (initialCityValue == '???????? ????????????????' ||
                                      initialCityValue == 'Choose the county') {
                                    showToast(
                                        text: MyStrings.emptyCity,
                                        state: ToastStates.WARMIMG);
                                  } else if (initialAreaValue ==
                                          "???????? ??????????????" ||
                                      initialAreaValue == 'Choose the region') {
                                    showToast(
                                        text: MyStrings.emptyArea,
                                        state: ToastStates.WARMIMG);
                                  } else {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userRegister(
                                          email: widget.email,
                                          password: widget.password,
                                          confirmPassword:
                                              widget.confirmPassword,
                                          city: initialCityValue.trim(),
                                          area: initialAreaValue.trim(),
                                          location:
                                              locationController.text.trim(),
                                          phoneNumber: widget.phoneNumber,
                                          name: widget.name,
                                          address:
                                              addressController.text.trim());
                                    }
                                  }
                                },
                                text: MyStrings.completedRegistration,
                                // width: 50.w,
                                background: MyColors.primaryColor,
                                borderRadius: MyColors.primaryColor,
                                radius: 10.0,
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
          ),
        );
      },
    );
  }
}
