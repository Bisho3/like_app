import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/authentication/widget/drop_down.dart';
import 'package:social_app/presentation/screen/authentication/widget/location.dart';
import 'package:social_app/presentation/screen/setting/widget/block_edit.dart';
import 'package:social_app/presentation/shared_widget/custom_form_field.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/style.dart';

class AboutRegion extends StatelessWidget {
  AboutRegion({Key? key}) : super(key: key);
  final TextEditingController addressController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final GlobalKey<FormState> formKeyAboutRegion = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LogicCubit cubit = LogicCubit.get(context);
        var userModel = cubit.userModel;
        addressController.text = (userModel?.address)!;
        locationController.text = (userModel?.location)!;
        String initialCityValue = (userModel?.city)!;
        String initialAreaValue = (userModel?.area)!;

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
        return Form(
          key: formKeyAboutRegion,
          child: BlockEditOneItem(
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
                    if (formKeyAboutRegion.currentState!.validate()) {
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
        );
      },
    );
  }
}
