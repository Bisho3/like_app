import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/setting/widget/block_edit.dart';
import 'package:social_app/presentation/shared_widget/custom_form_field.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/style.dart';

class AboutProfile extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKeyAboutProfile = GlobalKey<FormState>();

  AboutProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LogicCubit cubit = LogicCubit.get(context);
        var userModel = cubit.userModel;

        nameController.text = (userModel?.name)!;
        bioController.text = (userModel?.bio)!;
        phoneController.text = (userModel?.phoneNumber)!;

        return Form(
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
                    if (formKeyAboutProfile.currentState!.validate()) {
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
        );
      },
    );
  }
}
