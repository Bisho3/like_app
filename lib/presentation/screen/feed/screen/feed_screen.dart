import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/feed/widget/feed_item.dart';
import 'package:social_app/presentation/shared_widget/network_image.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/images.dart';
import 'package:social_app/util/style.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LogicCubit.get(context).getUserData();
    LogicCubit.get(context).getPost();

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    LogicCubit.get(context).posts.clear();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit,LogicStates>(
      listener:(context,state){} ,
      builder: (context,state){
        return ConditionalBuilder(
          condition: LogicCubit.get(context).posts.isNotEmpty,
          builder: (context){
            return WillPopScope(
              onWillPop: ()async{
                LogicCubit.get(context).posts.clear();
                return true;
              },
              child: Scaffold(
                appBar: AppBar(
                  title: Text(MyStrings.homeBar),
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
                            CustomNetworkImage(
                              image:  MyImages.coverImageHome,
                              width: double.infinity,
                              height: 180.h,
                            ),

                            Padding(
                              padding: EdgeInsets.all(3.h),
                              child: Text(
                                MyStrings.communicateWithFriends,
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
                        itemBuilder:(context, index)=>FeedItem(
                          model: LogicCubit.get(context).posts[index],
                          index: index,
                        ),
                        separatorBuilder: (context,index)=>SizedBox(
                          height: 8.h,
                        ),
                        itemCount: LogicCubit.get(context).posts.length,),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context)=>const Center(child: RefreshProgressIndicator()),
        );
      },
    );
  }
}
