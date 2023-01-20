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
import 'package:social_app/util/strings.dart';
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
          showProgressIndicator(context);
        }
        if(state is PhoneNumberSubmit){
          Navigator.pop(context);
          showToast(text: MyStrings.phoneNumberSubmit, state: ToastStates.SUCCESS);
          navigatorAndRemove(context, ConfrimPhoneNumber(phoneNumber: phoneNumberController.text.trim(),));
        }
        if(state is ErrorOccurred){
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
                            return MyStrings.emptyPhoneNumber;
                          } else if (value.length < 11) {
                            return MyStrings.lessValidatePhoneNumber;
                          } else if (value.length > 11) {
                            return MyStrings.moreValidatePhoneNumber;
                          }
                          String check = value.substring(0, 3);
                          if (check != '010' &&
                              check != '012' &&
                              check != '011' &&
                              check != '015') {
                            return MyStrings.errorPhoneNumber;
                          }
                          return null;
                        },
                        text: MyStrings.phoneNumber,
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
                            AuthCubit.get(context).submitPhoneNumber(phoneNumberController.text.trim());
                          }else{
                            Navigator.pop(context);
                            return;
                          }
                        },
                        text: MyStrings.register,
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
