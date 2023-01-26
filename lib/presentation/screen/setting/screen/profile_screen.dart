import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/business_logic/authentication_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/authentication/screen/login.dart';
import 'package:social_app/presentation/screen/setting/screen/edit_profile.dart';
import 'package:social_app/presentation/screen/setting/widget/image_profile_and_cover.dart';
import 'package:social_app/presentation/screen/setting/widget/know_number.dart';
import 'package:social_app/presentation/screen/setting/widget/icon_image_button.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/presentation/shared_widget/network_image.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/images.dart';
import 'package:social_app/util/style.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    LogicCubit.get(context).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LogicCubit.get(context).userModel;
        return ConditionalBuilder(
          condition: state is! GetUserLoadingStates,
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text(MyStrings.settings),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Column(
                    children: [
                       const ImageProfileAndCover(
                         editCover: false,
                         editProfile: false,
                       ),
                      Text(
                        "${cubit?.name}",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        "${cubit?.bio}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Row(
                          children: [
                            CustomKnownNumberStatus(
                              number: '100',
                              text: MyStrings.post,
                              function: () {},
                            ),
                            CustomKnownNumberStatus(
                              number: '256',
                              text: MyStrings.photos,
                              function: () {},
                            ),
                            CustomKnownNumberStatus(
                              number: '1K',
                              text: MyStrings.followers,
                              function: () {},
                            ),
                            CustomKnownNumberStatus(
                              number: '10',
                              text: MyStrings.following,
                              function: () {},
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: OutlinedButton(
                            onPressed: () async {},
                            child: Text(MyStrings.addPhotos),
                          )),
                          SizedBox(
                            width: 5.w,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              navigatorTo(context, const EditProfileScreen());
                            },
                            child: const Icon(FontAwesomeIcons.penToSquare),
                          ),
                        ],
                      ),
                      CustomMaterialButton(
                          function: ()  {
                             AuthCubit.get(context).signOutFromApp();
                            navigatorAndRemove(context, LoginScreen());
                          },
                          text: 'exit'),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) =>
              const Center(child: RefreshProgressIndicator()),
        );
      },
    );
  }
}
