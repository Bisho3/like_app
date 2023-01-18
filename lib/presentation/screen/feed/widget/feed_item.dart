import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/util/constant.dart';
import 'package:social_app/util/images.dart';
import 'package:social_app/util/style.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 8.h),
      child: Padding(
        padding: EdgeInsets.all(8.h),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.sp,
                  backgroundImage:  const NetworkImage(MyImages.profileImage),
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
                            'بيشو عماد',
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
                        'january 25,2023 at 2:30 pm',
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
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 10.h,
                  top: 5.h
              ),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          end: 6.w
                      ),
                      child: SizedBox(
                        height: 25.h,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text('#softwar',style:Theme.of(context).textTheme.caption?.copyWith(color: MyColors.primaryColor)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 140.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0.r),
                  image: const DecorationImage(
                      image: NetworkImage(MyImages.coverImageHome,),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(
                  vertical: 5.h
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.h
                        ),
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
                            Text('120',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(
                            vertical: 5.h
                        ),
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
                            Text('120 ${AppConstant.comment}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(
                  bottom: 10.h
              ),
              child: Container(
                width: double.infinity,
                height: 1.h,
                color: MyColors.lightGrey,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15.sp,
                          backgroundImage: NetworkImage(MyImages.profileImage),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          AppConstant.writeComment,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: (){},
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
                      Text(AppConstant.like,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
