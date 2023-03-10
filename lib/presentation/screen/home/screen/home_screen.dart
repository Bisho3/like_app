import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/presentation/screen/home/widget/bottom_nav_bar_item.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((event) {
      alertDialogNotification(
        context: context,
        color: LogicCubit.get(context).isDark ?MyColors.whiteColor : HexColor('333739'),
        imageUrl: '${event.notification?.android?.imageUrl}',
        body: '${event.notification?.body}',
        title: '${event.notification?.title}',
       
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      alertDialogNotification(
        context: context,
        color: LogicCubit.get(context).isDark ?MyColors.whiteColor : HexColor('333739'),
        imageUrl: '${event.notification?.android?.imageUrl}',
        body: '${event.notification?.body}',
        title: '${event.notification?.title}',
      );
    });
  }

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
              bottomNavBarItem(
                icon: Icons.home_outlined,
                textLabel: MyStrings.home,
              ),
              bottomNavBarItem(
                icon: FontAwesomeIcons.commentDots,
                textLabel: MyStrings.chats,
              ),
              bottomNavBarItem(
                icon: Icons.upload_file_outlined,
                textLabel: MyStrings.createPost,
              ),
              bottomNavBarItem(
                icon: Icons.person_outlined,
                textLabel: MyStrings.users,
              ),
              bottomNavBarItem(
                icon: FontAwesomeIcons.gears,
                textLabel: MyStrings.settings,
              ),
            ],
          ),
        );
      },
    );
  }
}
