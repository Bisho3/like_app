import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/presentation/screen/feed/widget/feed_item.dart';
import 'package:social_app/util/constant.dart';
import 'package:social_app/util/images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:social_app/util/style.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstant.homeBar),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5.0,
              margin: EdgeInsets.all(8.h),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Image(
                    image: const NetworkImage(MyImages.coverImageHome),
                    width: double.infinity,
                    height: 180.h,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.h),
                    child: Text(
                      AppConstant.communicateWithFriends,
                      style: Theme
                          .of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: MyColors.whiteColor),
                    ),
                  ),
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics:const NeverScrollableScrollPhysics(),
              itemBuilder:(context, index)=>FeedItem(),
              separatorBuilder: (context,index)=>SizedBox(
                height: 8.h,
              ),
              itemCount: 10,),
            SizedBox(
              height: 8.h,
            ),
          ],
        ),
      ),
    );
  }
}
