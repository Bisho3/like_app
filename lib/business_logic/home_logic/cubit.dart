
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/chat/screen/chat_screen.dart';
import 'package:social_app/presentation/screen/feed/screen/feed_screen.dart';
import 'package:social_app/presentation/screen/new_post/screen/new_post_screen.dart';
import 'package:social_app/presentation/screen/setting/screen/setting_screen.dart';
import 'package:social_app/presentation/screen/users/screen/users_screen.dart';
import 'package:social_app/util/constant.dart';

class LogicCubit extends Cubit<LogicStates>{
  LogicCubit() : super(LogicInitialStates());
  static LogicCubit get(context) => BlocProvider.of(context);

  int currentIndex =0;
  List<Widget> screens =[
    FeedScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  void changeNavBottom(int index){
    currentIndex = index;
    if(index ==2){
      emit(LogicUploadNewPostStates());
    }else{
      currentIndex = index;
      emit(LogicChangeNavBottomStates());
    }

  }
}