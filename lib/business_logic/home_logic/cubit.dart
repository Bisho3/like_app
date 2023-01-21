import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/data/model/authentication/create_user.dart';
import 'package:social_app/presentation/screen/chat/screen/chat_screen.dart';
import 'package:social_app/presentation/screen/feed/screen/feed_screen.dart';
import 'package:social_app/presentation/screen/new_post/screen/new_post_screen.dart';
import 'package:social_app/presentation/screen/setting/screen/profile_screen.dart';
import 'package:social_app/presentation/screen/users/screen/users_screen.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/sharedpreference.dart';
import 'package:social_app/util/strings.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
    const SettingsScreen(),
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

  ///=========== get users ============///
  CreateUser? userModel;

  void getUserData() {
    emit(GetUserLoadingStates());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: "token"))
        .get()
        .then((value) {
      userModel = CreateUser.fromJson(value.data()!);
      emit(GetUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorStates(error.toString()));
    });
  }

  ///========== reset password ==========///
  void resetPassword(String email) {
    emit(ResetPasswordEditProfileLoading());
    auth
        .sendPasswordResetEmail(
      email: email,
    )
        .then((value) {
      emit(ResetPasswordEditProfileSuccess());
    }).catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(ResetPasswordFail(error.toString()));
    });
  }

  ///============== convert language ========///
  void convertToArabicLanguage(BuildContext context) async {
    emit(ConvertLanguageLoading());
    await context.setLocale(const Locale("ar", "EG"));
    emit(ConvertToArabicLanguageSuccess());
  }

  void convertToEnglishLanguage(BuildContext context) async {
    emit(ConvertLanguageLoading());
    await context.setLocale(const Locale("en", "US"));
    emit(ConvertToEnglishLanguageSuccess());
  }

  ///======== Image ==========///
  File? profileImages;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    XFile? selectedImages = await picker.pickImage(source: ImageSource.gallery);

    if (selectedImages != null) {
      profileImages = File(selectedImages.path);
      // uploadProfileImage(image: File(imageFileToProfile!.path));
      emit(GetProfileImageSuccess());
    } else {
      emit(GetProfileImageError());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    XFile? selectedImages = await picker.pickImage(source: ImageSource.gallery);

    if (selectedImages != null) {
      coverImage = File(selectedImages.path);
      emit(GetCoverImageSuccess());
    } else {
      emit(GetCoverImageError());
    }
  }
  void uploadProfileImage() {
    emit(UploadProfileImageLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('profile/${Uri.file(profileImages!.path).pathSegments.last}')
        .putFile(profileImages!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateCurrentUsers(
          name: userModel?.name,
          bio: userModel?.bio,
          phoneNumber:userModel?.phoneNumber,
          byEmail: userModel?.byEmail,
          location: userModel?.location,
          coverImages: userModel?.coverImage,
          city: userModel?.city,
          area: userModel?.area,
          address: userModel?.address,
          profileImage: value,
          email: userModel?.email,
          uId: userModel?.uId,
        );
      }).catchError((error) {
        emit(UploadProfileImageError());
      });
    }).catchError((error) {
      emit(UploadProfileImageError());
    });
  }

  void uploadCoverImage() {
    emit(UploadCoverImageLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('cover/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateCurrentUsers(
          name: userModel?.name,
          bio: userModel?.bio,
          phoneNumber:userModel?.phoneNumber,
          byEmail: userModel?.byEmail,
          location: userModel?.location,
          coverImages: value,
          city: userModel?.city,
          area: userModel?.area,
          address: userModel?.address,
          profileImage: userModel?.profileImage,
          email: userModel?.email,
          uId: userModel?.uId,
        );
      }).catchError((error) {
        emit(UploadCoverImageError());
      });
    }).catchError((error) {
      emit(UploadCoverImageError());
    });
  }

  ///========== update current users========///
  void updateCurrentUsers({
    String? email,
    String? city,
    String? area,
    String? location,
    String? address,
    String? phoneNumber,
    String? name,
    String? uId,
    String? profileImage,
    String? coverImages,
    String? bio,
    bool? byEmail,
  }) {
    emit(UpdateUserLoadingStates());
      CreateUser model = CreateUser(
          name: name,
          email: userModel?.email,
          bio: bio,
          coverImage: coverImages,
          profileImage: profileImage,
          phoneNumber: phoneNumber,
          location: location,
          city: city,
          area: area,
          address: address,
          uId: userModel?.uId,
          byEmail: userModel?.byEmail);
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel?.uId)
          .update(model.toMap())
          .then((value) {
        getUserData();
      }).catchError((error) {
        emit(UpdateUserErrorStates(error.toString()));
      });

  }
}
