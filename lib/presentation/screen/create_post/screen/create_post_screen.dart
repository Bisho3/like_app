import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/create_post/widget/postimage.dart';
import 'package:social_app/presentation/screen/create_post/widget/profileimage_and_name.dart';
import 'package:social_app/presentation/shared_widget/custom_text_button.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/style.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    LogicCubit.get(context).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {
        if (state is CreatePostSuccess) {
          showToast(
              text: MyStrings.addedSuccessfully, state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        LogicCubit cubit = LogicCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(MyStrings.createPost),
            actions: [
              CustomTextButton(
                function: () {
                  if (cubit.postImage == null) {
                    cubit.createPost(
                        dateTime: DateTime.now().toString(),
                        text: textController.text.trim());
                  } else {
                    cubit.uploadPostImage(
                      dateTime: DateTime.now().toString(),
                      text: textController.text.trim(),
                    );
                  }
                },
                text: MyStrings.post,
                color: MyColors.primaryColor,
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              children: [
                if (state is CreatePostLoading)
                  Column(
                    children: [
                      const LinearProgressIndicator(),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                const ProfileImageAndName(),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: MyStrings.askPost, border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                if (cubit.postImage != null) const PostImage(),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          cubit.getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera_alt_outlined,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(MyStrings.addPhotos),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
