import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/data/model/post/post.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/images.dart';
import 'package:social_app/util/style.dart';

class FeedItem extends StatelessWidget {
  TextEditingController commentController = TextEditingController();
  final int index;
  final CreatePost model;

   FeedItem({
    Key? key,
    required this.index,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LogicCubit cubit = LogicCubit.get(context);
        return Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5.0,
          margin: EdgeInsets.symmetric(horizontal: 8.h),
          child: Padding(
            padding: EdgeInsets.all(8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.sp,
                      backgroundImage: NetworkImage("${model.profileImage}"),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${model.name}",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: MyColors.primaryColor,
                                size: 16.sp,
                              ),
                            ],
                          ),
                          Text(
                            '${model.dateTime}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.more_horiz,
                        size: 22.sp,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: Container(
                    width: double.infinity,
                    height: 1.h,
                    color: MyColors.lightGrey,
                  ),
                ),
                Text(
                  '${model.text}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //       bottom: 10.h,
                //       top: 5.h
                //   ),
                //   child: SizedBox(
                //     width: double.infinity,
                //     child: Wrap(
                //       children: [
                //         Padding(
                //           padding: EdgeInsetsDirectional.only(
                //               end: 6.w
                //           ),
                //           child: SizedBox(
                //             height: 25.h,
                //             child: MaterialButton(
                //               onPressed: () {},
                //               minWidth: 1.0,
                //               padding: EdgeInsets.zero,
                //               child: Text('#softwar',style:Theme.of(context).textTheme.caption?.copyWith(color: MyColors.primaryColor)),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                if (model.postImage != '')
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 15.h),
                    child: Container(
                      height: 140.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0.r),
                          image: DecorationImage(
                              image: NetworkImage("${model.postImage}"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.heart,
                                  size: 16.sp,
                                  color: MyColors.redColor,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  '${cubit.like[index]}',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  FontAwesomeIcons.commentDots,
                                  size: 16.sp,
                                  color: MyColors.yellowColor,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "${cubit.numComment[index]}",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  MyStrings.comment,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {

                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Container(
                    width: double.infinity,
                    height: 1.h,
                    color: MyColors.lightGrey,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15.sp,
                            backgroundImage: NetworkImage(
                                "${cubit.userModel?.profileImage}"),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: commentController,
                              decoration: InputDecoration(
                                  hintText: MyStrings.writeComment,
                                  border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.heart,
                            size: 16.sp,
                            color: MyColors.redColor,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            MyStrings.like,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: () {
                        cubit.likePost(cubit.postId[index]);
                      },
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            FontAwesomeIcons.commentDots,
                            size: 16.sp,
                            color: MyColors.yellowColor,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            MyStrings.comment,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: (){
                        if(commentController.text == '' || commentController.text == ' '){
                        }else{
                          cubit.commentPost(cubit.postId[index],commentController.text.trim());
                        }

                      },
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
