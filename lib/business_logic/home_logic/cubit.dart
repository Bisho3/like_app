import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/authentication_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/data/model/authentication/create_user.dart';
import 'package:social_app/presentation/screen/chat/screen/chat_screen.dart';
import 'package:social_app/presentation/screen/feed/screen/feed_screen.dart';
import 'package:social_app/presentation/screen/new_post/screen/new_post_screen.dart';
import 'package:social_app/presentation/screen/setting/screen/profile_screen.dart';
import 'package:social_app/presentation/screen/users/screen/users_screen.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/sharedpreference.dart';


class LogicCubit extends Cubit<LogicStates> {
  LogicCubit() : super(LogicInitialStates());

  static LogicCubit get(context) => BlocProvider.of(context);
  final FirebaseAuth auth = FirebaseAuth.instance;

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

   CreateUser? userModel;
  void getUserData() {
    emit(GetUserLoadingStates());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: "token"))
        .get()
        .then((value){
          userModel = CreateUser.fromJson(value.data()!);
          emit(GetUserSuccessStates());
    })
        .catchError((error) {
      print("4444444444444");
      print(error.toString());
          emit(GetUserErrorStates(error.toString()));
    });
  }
  ///========== reset password ==========///
  void resetPassword(String email) {
    emit(ResetPasswordLoading());
    auth
        .sendPasswordResetEmail(
      email: email,
    )
        .then((value) {
      emit(ResetPasswordSuccess());
    }).catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(ResetPasswordFail(error.toString()));
    });
  }

}
