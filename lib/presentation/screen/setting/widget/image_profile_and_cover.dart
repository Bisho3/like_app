import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/setting/widget/icon_image_button.dart';
import 'package:social_app/presentation/shared_widget/network_image.dart';
import 'package:social_app/util/images.dart';
import 'package:social_app/util/style.dart';

class ImageProfileAndCover extends StatelessWidget {
  const ImageProfileAndCover(
      {Key? key, this.editCover = false, this.editProfile = false})
      : super(key: key);
  final bool editCover;
  final bool editProfile;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LogicCubit cubit = LogicCubit.get(context);
        var userModel = cubit.userModel;
        var profileImage = cubit.profileImages;
        var coverImage = cubit.coverImage;
        return SizedBox(
          height: 190.h,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              editCover == false
                  ? Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: CustomNetworkImage(
                        image: userModel?.coverImage ?? MyImages.coverImageHome,
                        width: double.infinity,
                        height: 140.h,
                        border: BorderRadius.only(
                          topRight: Radius.circular(5.r),
                          topLeft: Radius.circular(5.r),
                        ),
                      ),
                    )
                  : Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: coverImage == null
                              ? CustomNetworkImage(
                                  image: userModel?.coverImage ??
                                      MyImages.coverImageHome,
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
              editProfile == false
                  ? CircleAvatar(
                      radius: 63.r,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60.r,
                        backgroundColor: MyColors.greyColor,
                        backgroundImage: NetworkImage(
                            userModel?.profileImage ?? MyImages.profileImage),
                      ),
                    )
                  : Stack(
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
                                  ? NetworkImage(userModel?.profileImage ??
                                      MyImages.profileImage)
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
        );
      },
    );
  }
}
