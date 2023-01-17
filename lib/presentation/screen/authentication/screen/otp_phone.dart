import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/business_logic/authentication_logic/cubit.dart';
import 'package:social_app/business_logic/authentication_logic/states.dart';
import 'package:social_app/presentation/screen/authentication/screen/confirm_phone_number.dart';
import 'package:social_app/presentation/screen/authentication/widget/show_progress_phonenum.dart';
import 'package:social_app/presentation/shared_widget/custom_form_field.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/util/constant.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/images.dart';
import 'package:social_app/util/style.dart';

class OtpPhoneScreen extends StatelessWidget {
  OtpPhoneScreen({Key? key}) : super(key: key);
  TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if(state is PhoneLoadingStates){
          print("11111111111111");
          showProgressIndicator(context);
        }
        if(state is PhoneNumberSubmit){
          print("2222222222222");
          Navigator.pop(context);
          navigatorAndRemove(context, ConfrimPhoneNumber(phoneNumber: phoneNumberController.text,));
        }
        if(state is ErrorOccurred){
          print("333333333333333333");
          Navigator.pop(context);
          String errorMsg = (state).error;
          showToast(text: errorMsg, state:ToastStates.WARMIMG);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(MyImages.phoneAuth, height: 280.h),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomFormField(
                        type: TextInputType.phone,
                        controller: phoneNumberController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return AppConstant.emptyPhoneNumber;
                          } else if (value.length < 11) {
                            return AppConstant.lessValidatePhoneNumber;
                          } else if (value.length > 11) {
                            return AppConstant.moreValidatePhoneNumber;
                          }
                          String check = value.substring(0, 3);
                          if (check != '010' &&
                              check != '012' &&
                              check != '011' &&
                              check != '015') {
                            return AppConstant.errorPhoneNumber;
                          }
                          return null;
                        },
                        text: AppConstant.phoneNumber,
                        onTap: (){},
                        preffixIcon: Icons.phone),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomMaterialButton(
                        function: () {
                          showProgressIndicator(context);
                          if (formKey.currentState!.validate()) {
                            Navigator.pop(context);
                            AuthCubit.get(context).submitPhoneNumber(phoneNumberController.text);
                          }else{
                            Navigator.pop(context);
                            return;
                          }
                        },
                        text: AppConstant.register,
                        radius: 10.r),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
