
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/authentication/widget/drop_down.dart';
import 'package:social_app/presentation/screen/authentication/widget/location.dart';
import 'package:social_app/presentation/screen/setting/widget/block_edit.dart';
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
  TextEditingController nameController =TextEditingController();
  TextEditingController bioController =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  GlobalKey<FormState> formKeyAboutProfile =GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  GlobalKey<FormState> formKeyAboutRegion = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyResetPassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {
        if (state is ResetPasswordEditProfileSuccess) {
          showToast(text: MyStrings.resetSuccess, state: ToastStates.SUCCESS);
        }
        if (state is GetProfileImageSuccess) {
          showToast(
              text: MyStrings.addedSuccessfully, state: ToastStates.SUCCESS);
        }
        if (state is GetCoverImageSuccess) {
          showToast(
              text: MyStrings.addedSuccessfully, state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        LogicCubit cubit = LogicCubit.get(context);
        var userModel = cubit.userModel;
        var profileImage = cubit.profileImages;
        var coverImage = cubit.coverImage;

        nameController.text = (userModel?.name)!;
        bioController.text = (userModel?.bio)!;
        phoneController.text = (userModel?.phoneNumber)!;
        addressController.text = (userModel?.address)!;
        locationController.text = (userModel?.location)!;
        String initialCityValue = (userModel?.city)!;
        String initialAreaValue = (userModel?.area)!;
        emailController.text = (userModel?.email)!;
        List<String> listCity = [
          (userModel?.city)!,
          MyStrings.cairo,
          "القليوبية"
        ];
        List<String> listArea = [
          (userModel?.area)!,
          MyStrings.shoubraMasr,
          "شبراالخيمة"
        ];
        return Scaffold(
          appBar: AppBar(
            title: Text(MyStrings.editProfile),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.h),
              child: Column(
                children: [
                  if (state is UpdateUserLoadingStates)
                    Column(
                      children: [
                        const LinearProgressIndicator(),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    ),
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
                              child: coverImage == null
                                  ? CustomNetworkImage(
                                      image:
                                          "${userModel?.coverImage == null ? MyImages.coverImageHome : userModel?.coverImage}",
                                      width: double.infinity,
                                      height: 140.h,
                                      border: BorderRadius.only(
                                        topRight: Radius.circular(5.r),
                                        topLeft: Radius.circular(5.r),
                                      ),
                                    )
                                  : Image(image: FileImage(coverImage)),
                            ),
                            CustomUploadImageButton(
                              function: () {
                                cubit.getCoverImage();
                              },
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
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(
                                          "${userModel?.profileImage == null ? MyImages.profileImage : userModel?.profileImage}")
                                      : Image(image: FileImage(profileImage))
                                          .image),
                            ),
                            CustomUploadImageButton(
                              function: () {
                                cubit.getProfileImage();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (cubit.profileImages != null || cubit.coverImage != null)
                    Column(
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            if (cubit.profileImages != null)
                              Expanded(
                                child: Column(
                                  children: [
                                    CustomMaterialButton(
                                      function: () {
                                        cubit.uploadProfileImage();
                                      },
                                      text: MyStrings.uploadProfile,
                                      radius: 10.r,
                                      borderRadius: MyColors.foreignColor,
                                      background: MyColors.whiteColor,
                                      textColor: MyColors.primaryColor,
                                      fontSize: 16.sp,
                                    ),
                                    if (state is UploadProfileImageLoading)
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          const LinearProgressIndicator(),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            SizedBox(width: 5.w),
                            if (cubit.coverImage != null)
                              Expanded(
                                  child: Column(
                                children: [
                                  CustomMaterialButton(
                                    function: () {
                                      cubit.uploadCoverImage();
                                    },
                                    text: MyStrings.uploadCover,
                                    radius: 10.r,
                                    borderRadius: MyColors.foreignColor,
                                    background: MyColors.whiteColor,
                                    textColor: MyColors.primaryColor,
                                  ),
                                  if (state is UploadCoverImageLoading)
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        const LinearProgressIndicator(),
                                      ],
                                    ),
                                ],
                              )),
                          ],
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Form(
                    key: formKeyAboutProfile,
                    child: BlockEditOneItem(
                      titleText: MyStrings.aboutProfile,
                      widget: Column(
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
                            function: () {
                              if (formKeyAboutProfile.currentState!
                                  .validate()) {
                                cubit.updateCurrentUsers(
                                  name: nameController.text.trim(),
                                  bio: bioController.text.trim(),
                                  phoneNumber: phoneController.text,
                                  byEmail: userModel?.byEmail,
                                  location: userModel?.location,
                                  coverImages: userModel?.coverImage,
                                  city: userModel?.city,
                                  area: userModel?.area,
                                  address: userModel?.address,
                                  profileImage: userModel?.profileImage,
                                  email: userModel?.email,
                                  uId: userModel?.uId,
                                );
                              }
                            },
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
                  Form(
                    key: formKeyAboutRegion,
                    child:
                    BlockEditOneItem(
                      titleText: MyStrings.aboutCity,
                      widget: Column(
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
                            function: () {
                              if (formKeyAboutRegion.currentState!
                                  .validate()) {
                                cubit.updateCurrentUsers(
                                  name: userModel?.name,
                                  bio: userModel?.bio,
                                  phoneNumber: userModel?.phoneNumber,
                                  byEmail: userModel?.byEmail,
                                  location: locationController.text.trim(),
                                  coverImages: userModel?.coverImage,
                                  city: initialCityValue.trim(),
                                  area: initialAreaValue.trim(),
                                  address: addressController.text.trim(),
                                  profileImage: userModel?.profileImage,
                                  email: userModel?.email,
                                  uId: userModel?.uId,
                                );
                              }
                            },
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
                  userModel?.byEmail == true
                      ? Form(
                          key: formKeyResetPassword,
                          child: Column(
                            children: [
                              BlockEditOneItem(titleText: MyStrings.resetPassword, widget: Column(
                                children: [
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
                                    condition: state
                                    is! ResetPasswordEditProfileLoading,
                                    builder: (context) {
                                      return CustomMaterialButton(
                                          function: () {
                                            if (formKeyResetPassword
                                                .currentState!
                                                .validate()) {
                                              print("this.reset");
                                              cubit.resetPassword(
                                                  emailController.text
                                                      .trim());
                                            }
                                          },
                                          text: MyStrings.send,
                                          radius: 10.0,
                                          background: MyColors.primaryColor,
                                          borderRadius:
                                          MyColors.primaryColor,
                                          fontSize: 16.sp);
                                    },
                                    fallback: (context) => const Center(
                                        child: RefreshProgressIndicator()),
                                  ),
                                ],
                              ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                      BlockEditOneItem(
                        titleText: MyStrings.language,
                        widget:  ConditionalBuilder(
                          condition: state is! ConvertLanguageLoading,
                          builder: (context) => Row(
                            children: [
                              Expanded(
                                child: CustomMaterialButton(
                                  function: () {
                                    cubit.convertToArabicLanguage(context);
                                  },
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
                                  function: () {
                                    cubit.convertToEnglishLanguage(context);
                                  },
                                  text: 'English',
                                  radius: 10,
                                  textColor: MyColors.primaryColor,
                                  background: MyColors.whiteColor,
                                  borderRadius: MyColors.foreignColor,
                                ),
                              ),
                            ],
                          ),
                          fallback: (context) =>
                          const Center(child: RefreshProgressIndicator()),
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
