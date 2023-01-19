import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:social_app/business_logic/authentication_logic/cubit.dart';
import 'package:social_app/business_logic/authentication_logic/states.dart';
import 'package:social_app/presentation/screen/authentication/screen/fisrst_step_register.dart';
import 'package:social_app/presentation/screen/authentication/widget/show_progress_phonenum.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/style.dart';

class ConfrimPhoneNumber extends StatelessWidget {
  String phoneNumber;
  ConfrimPhoneNumber({Key? key,required this.phoneNumber}) : super(key: key);

  TextEditingController verificationController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit ,AuthStates>(
        listener: (context, state) {
          if(state is PhoneLoadingStates){
            showProgressIndicator(context);
          }
          if(state is PhoneOTPVerified){
            Navigator.pop(context);
            showToast(text: MyStrings.phoneOTPVerified, state: ToastStates.SUCCESS);
            navigatorAndRemove(context, FirstStepRegisterScreen(phoneNumber: phoneNumber,));
          }
          if(state is ErrorOccurred){
            Navigator.pop(context);
            String errorMsg = (state).error;
            showToast(text: errorMsg, state:ToastStates.WARMIMG);
          }
        },
        builder: (context,state) {
      return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              MyStrings.confirmPhone,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: MyColors.primaryColor,
              ),
            ),
          ),
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: Column(
                textDirection: TextDirection.rtl,
                children: [
                  Center(
                    child: Text(
                      MyStrings.otpMessage,
                      style: TextStyle(
                        color: MyColors.foreignColor,
                        fontSize: 24.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Pinput(
                    controller: pinController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return MyStrings.emptyOtp;
                      } else if (value.length < 6) {
                        return MyStrings.lessValidationOtp;
                      }
                      return null;
                    },
                    length: 6,
                    onCompleted: (code) {
                      otpCode = code;
                      print(code);
                    },
                    defaultPinTheme: PinTheme(
                      height: 40.h,
                      width: 40.w,
                      textStyle: TextStyle(fontSize: 17.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        border: Border.all(
                          color: MyColors.foreignColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  CustomMaterialButton(
                    function: () {
                      showProgressIndicator(context);
                      if (formKey.currentState!.validate()) {
                        cubit.submitOTP(pinController.text);
                      }
                    },
                    text: MyStrings.next,
                    radius: 10.0,
                    fontSize: 22.sp,
                    textColor: MyColors.primaryColor,
                    background: MyColors.whiteColor,
                    borderRadius: MyColors.foreignColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
