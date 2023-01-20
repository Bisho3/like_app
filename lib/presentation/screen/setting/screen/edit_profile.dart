import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/authentication/widget/drop_down.dart';
import 'package:social_app/presentation/screen/authentication/widget/location.dart';
import 'package:social_app/presentation/screen/setting/widget/upload_image_button.dart';
import 'package:social_app/presentation/shared_widget/custom_form_field.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/presentation/shared_widget/network_image.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/images.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/style.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController locationController = TextEditingController();


  List<String> listCity = [MyStrings.chooseCity, MyStrings.cairo,"القليوبية"];
  List<String> listArea = [MyStrings.chooseArea, MyStrings.shoubraMasr,"شبرا الخيمة"];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {
      if(state is ResetPasswordSuccess){
        showToast(text: MyStrings.resetSuccess , state: ToastStates.SUCCESS);
      }
      },
      builder: (context, state) {
        var cubit = LogicCubit.get(context).userModel;
        nameController.text = (cubit?.name)!;
        bioController.text = (cubit?.bio)!;
        phoneController.text = (cubit?.phoneNumber)!;
        addressController.text = (cubit?.address)!;
        locationController.text = (cubit?.location)!;
        String initialCityValue = (cubit?.city)!;
        String initialAreaValue = (cubit?.area)!;
        return Scaffold(
          appBar: AppBar(
            title: Text(MyStrings.editProfile),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 190.h,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topStart,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: CustomNetworkImage(
                                image:
                                    "${cubit?.coverImage == null ? MyImages.coverImageHome : cubit?.coverImage}",
                                width: double.infinity,
                                height: 140.h,
                                border: BorderRadius.only(
                                  topRight: Radius.circular(5.r),
                                  topLeft: Radius.circular(5.r),
                                ),
                              ),
                            ),
                            CustomUploadImageButton(
                              function: () {},
                            ),
                          ],
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            CircleAvatar(
                              radius: 63.r,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.r,
                                backgroundColor: MyColors.greyColor,
                                backgroundImage: NetworkImage(
                                    "${cubit?.profileImage == null ? MyImages.profileImage : cubit?.profileImage}"),
                              ),
                            ),
                            CustomUploadImageButton(
                              function: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColors.foreignColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(10.h),
                      child: Column(
                        children: [
                          Text(
                           MyStrings.aboutProfile,
                            style: TextStyle(
                                color: MyColors.primaryColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
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
                            radius: 10.0,
                            preffixIcon: Icons.person,
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomFormField(
                            type: TextInputType.text,
                            text: MyStrings.bio,
                            controller: bioController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return MyStrings.emptyBio;
                              }
                              return null;
                            },
                            radius: 10.0,
                            preffixIcon: Icons.info_outline,
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomFormField(
                              type: TextInputType.phone,
                              controller: phoneController,
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
                              onTap: () {},
                              preffixIcon: Icons.phone),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomMaterialButton(
                            function: () {},
                            text: MyStrings.update,
                            radius: 10,
                            textColor: MyColors.primaryColor,
                            background: MyColors.whiteColor,
                            borderRadius: MyColors.foreignColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColors.foreignColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(10.h),
                      child: Column(
                        children: [
                          Text(
                          MyStrings.aboutCity,
                            style: TextStyle(
                                color: MyColors.primaryColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
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
                            radius: 10.0,
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
                            radius: 10.0,
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
                          CustomMaterialButton(
                            function: () {},
                            text: MyStrings.update,
                            radius: 10,
                            textColor: MyColors.primaryColor,
                            background: MyColors.whiteColor,
                            borderRadius: MyColors.foreignColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  cubit?.byEmail == true ?
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: MyColors.foreignColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Column(
                            children: [
                              Text(
                                MyStrings.resetPassword,
                                style: TextStyle(
                                    color: MyColors.primaryColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
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
                                condition: state is! ResetPasswordLoading,
                                builder: (context) {
                                  return CustomMaterialButton(
                                      function: () {
                                        // if (formKey.currentState!.validate()) {
                                         // LogicCubit.get(context).resetPassword(emailController.text.trim());
                                        // }
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
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  )
                      :const SizedBox(),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColors.foreignColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(10.h),
                      child: Column(
                        children: [
                          Text(
                            MyStrings.language,
                            style: TextStyle(
                                color: MyColors.primaryColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomMaterialButton(
                                  function: () {},
                                  text: MyStrings.arabic,
                                  radius: 10,
                                  textColor: MyColors.primaryColor,
                                  background: MyColors.whiteColor,
                                  borderRadius: MyColors.foreignColor,
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Expanded(
                                child: CustomMaterialButton(
                                  function: () {},
                                  text: 'English',
                                  radius: 10,
                                  textColor: MyColors.primaryColor,
                                  background: MyColors.whiteColor,
                                  borderRadius: MyColors.foreignColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
