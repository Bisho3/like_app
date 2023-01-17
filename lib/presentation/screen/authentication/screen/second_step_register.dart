import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/authentication_logic/cubit.dart';
import 'package:social_app/business_logic/authentication_logic/states.dart';
import 'package:social_app/presentation/screen/authentication/screen/login.dart';
import 'package:social_app/presentation/screen/authentication/widget/drop_down.dart';
import 'package:social_app/presentation/screen/authentication/widget/location.dart';
import 'package:social_app/presentation/screen/authentication/widget/text_register_bar.dart';
import 'package:social_app/presentation/screen/home/home_screen.dart';
import 'package:social_app/presentation/shared_widget/custom_form_field.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/util/constant.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/style.dart';

class SecondStepRegisterScreen extends StatefulWidget {
  String email;
  String password;
  String confirmPassword;
  String name;
  String phoneNumber;

  SecondStepRegisterScreen(
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
  String initialCityValue = AppConstant.chooseCity;
  String initialAreaValue = AppConstant.chooseArea;
  List<String> listCity = [AppConstant.chooseCity, AppConstant.cairo];
  List<String> listArea = [AppConstant.chooseArea, AppConstant.shoubraMasr];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is CreateUserSuccessStates) {
          navigatorAndRemove(context, LoginScreen());
          showToast(
              text: AppConstant.successCreateUser, state: ToastStates.SUCCESS);
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
                title:    CustomTextRegisterBar(
                    text: AppConstant.secondStepRegister
                ),
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
                          text: AppConstant.address,
                          type: TextInputType.text,
                          controller: addressController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return AppConstant.emptyAddress;
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
                          text: AppConstant.location,
                          type: TextInputType.text,
                          controller: locationController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return AppConstant.emptyLocation;
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
                                  if (initialCityValue == 'أختر المحافظة' ||
                                      initialCityValue == 'Choose the county') {
                                    showToast(
                                        text: AppConstant.emptyCity,
                                        state: ToastStates.WARMIMG);
                                  } else if (initialAreaValue ==
                                          "أختر المنطقة" ||
                                      initialAreaValue == 'Choose the region') {
                                    showToast(
                                        text: AppConstant.emptyArea,
                                        state: ToastStates.WARMIMG);
                                  } else {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userRegister(
                                          email: widget.email,
                                          password: widget.password,
                                          confirmPassword:
                                              widget.confirmPassword,
                                          city: initialCityValue,
                                          area: initialAreaValue,
                                          location: locationController.text,
                                          phoneNumber: widget.phoneNumber,
                                          name: widget.name,
                                          address: addressController.text);
                                    }
                                  }
                                },
                                text: AppConstant.completedRegistration,
                                // width: 50.w,
                                background: MyColors.primaryColor,
                                borderRadius: MyColors.primaryColor,
                                radius: 10.0,
                                fontSize: 16.sp);
                          },
                          fallback: (context) =>
                              const Center(child: RefreshProgressIndicator()),
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
