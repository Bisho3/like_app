import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/authentication_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/data/model/authentication/create_user.dart';
import 'package:social_app/presentation/screen/chat/screen/chat_screen.dart';
import 'package:social_app/presentation/screen/feed/screen/feed_screen.dart';
import 'package:social_app/presentation/screen/new_post/screen/new_post_screen.dart';
import 'package:social_app/presentation/screen/setting/screen/setting_screen.dart';
import 'package:social_app/presentation/screen/users/screen/users_screen.dart';


class LogicCubit extends Cubit<LogicStates> {
  LogicCubit() : super(LogicInitialStates());

  static LogicCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    FeedScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  void changeNavBottom(int index) {
    currentIndex = index;
    if (index == 2) {
      emit(LogicUploadNewPostStates());
    } else {
      currentIndex = index;
      emit(LogicChangeNavBottomStates());
    }
  }

   CreateUser? model;
  void getUserData() {
    emit(GetUserLoadingStates());
    FirebaseFirestore.instance
        .collection('users')
        .doc(AuthCubit().uIdToken)
        .get()
        .then((value){
          print("111111111111");
          print(value.data());
          print(value.data());
          model = CreateUser.fromJson(value.data()!);
          print("2222222222222222");
          print(value.data());
          print("3333333333333333");
          emit(GetUserSuccessStates());
    })
        .catchError((error) {
      print("4444444444444");
      print(error.toString());
          emit(GetUserErrorStates(error.toString()));
    });
  }
}
