import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/setting/widget/about_profile.dart';
import 'package:social_app/presentation/screen/setting/widget/about_region.dart';
import 'package:social_app/presentation/screen/setting/widget/icon_image_button.dart';
import 'package:social_app/presentation/screen/setting/widget/image_profile_and_cover.dart';
import 'package:social_app/presentation/screen/setting/widget/language.dart';
import 'package:social_app/presentation/screen/setting/widget/reset_password.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/presentation/shared_widget/network_image.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/images.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/style.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {
        if (state is GetUserSuccessStates) {
          showToast(
              text: MyStrings.addedSuccessfully, state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        LogicCubit cubit = LogicCubit.get(context);
        var userModel = cubit.userModel;

        return Scaffold(
          appBar: AppBar(
            title: Text(MyStrings.editProfile),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                  ImageProfileAndCover(
                    editCover: true,
                    editProfile: true,
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
                              ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AboutProfile(),
                  SizedBox(
                    height: 10.h,
                  ),
                  AboutRegion(),
                  SizedBox(
                    height: 10.h,
                  ),
                  userModel?.byEmail == true
                      ? ResetPassword()
                      : const SizedBox(),
                      const Language(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
