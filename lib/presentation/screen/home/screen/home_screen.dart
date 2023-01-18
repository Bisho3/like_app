import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/presentation/screen/home/widget/bottom_nav_bar_item.dart';
import 'package:social_app/presentation/screen/new_post/screen/new_post_screen.dart';
import 'package:social_app/util/constant.dart';
import 'package:social_app/util/helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {
        // if(state is LogicUploadNewPostStates){
        //   navigatorTo(context, NewPostScreen());
        // }
      },
      builder: (context, state) {
        LogicCubit cubit = LogicCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeNavBottom(index);
            },
            items: [
              bottomNavBarItem(icon: Icons.home_outlined, textLabel: AppConstant.home,),
              bottomNavBarItem(icon: FontAwesomeIcons.commentDots, textLabel: AppConstant.chats,),
              bottomNavBarItem(icon: Icons.upload_file_outlined, textLabel: AppConstant.uploadPost,),
              bottomNavBarItem(icon: Icons.person_outlined, textLabel: AppConstant.users,),
              bottomNavBarItem(icon: FontAwesomeIcons.gears, textLabel: AppConstant.settings,),
            ],
          ),
        );
      },
    );
  }
}
