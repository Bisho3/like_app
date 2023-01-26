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
import 'package:social_app/data/model/post/post.dart';
import 'package:social_app/presentation/screen/chat/screen/chat_screen.dart';
import 'package:social_app/presentation/screen/create_post/screen/create_post_screen.dart';
import 'package:social_app/presentation/screen/feed/screen/feed_screen.dart';
import 'package:social_app/presentation/screen/setting/screen/profile_screen.dart';
import 'package:social_app/presentation/screen/users/screen/users_screen.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/sharedpreference.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class LogicCubit extends Cubit<LogicStates> {
  LogicCubit() : super(LogicInitialStates());

  static LogicCubit get(context) => BlocProvider.of(context);
  final FirebaseAuth auth = FirebaseAuth.instance;

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedScreen(),
    ChatsScreen(),
    const CreatePostScreen(),
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
          phoneNumber: userModel?.phoneNumber,
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
          phoneNumber: userModel?.phoneNumber,
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

  ///=========post======///
  File? postImage;

  Future<void> getPostImage() async {
    XFile? selectedImages = await picker.pickImage(source: ImageSource.gallery);

    if (selectedImages != null) {
      postImage = File(selectedImages.path);
      emit(GetPostImageSuccess());
    } else {
      emit(GetPostImageError());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostSuccess());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        emit(CreatePostError(error.toString()));
      });
    }).catchError((error) {
      emit(CreatePostError(error.toString()));
    });
  }

  void createPost(
      {required String dateTime, required String text, String? postImage}) {
    emit(CreatePostLoading());
    CreatePost model = CreatePost(
      name: userModel?.name,
      uId: userModel?.uId,
      profileImage: userModel?.profileImage,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccess());
    }).catchError((error) {
      emit(CreatePostError(error.toString()));
    });
  }

  List<CreatePost> posts = [];
  List<String> postId = [];
  List<int> like = [];
  List<int> numComment = [];

  void getPost() {
    emit(GetPostLoading());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference
            .collection('comments')
            .get()
            .then((value) {
              numComment.add(value.docs.length);
        })
            .catchError(() {});
        element.reference.collection('likes').get().then((value) {
          like.add(value.docs.length);
          print("Bishoooo ${value.docs.length}");
          postId.add(element.id);
          posts.add(CreatePost.fromJson(element.data()));
          emit(GetPostSuccess());
        }).catchError((error) {
          emit(GetPostError(error.toString()));
        });
      }
    }).catchError((error) {
      emit(GetPostError(error.toString()));
    });
  }

  ///=========== likes =======///
  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel?.uId)
        .set({'like': true}).then((value) {
      emit(LikePostSuccess());
    }).catchError((error) {
      emit(LikePostError(error.toString()));
    });
  }

  ///=======comments =========///
  void commentPost(String postId, String text) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel?.uId)
        .set({'comment': text}).then((value) {
      emit(CommentPostSuccess());
    }).catchError((error) {
      emit(CommentPostError(error.toString()));
    });
  }
  ///======== get all Users =================///

List<CreateUser> users =[];

  void getAllUsers(){
    emit(GetAllUsersLoading());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        users.add(CreateUser.fromJson(element.data()));
      }
      emit(GetAllUsersSuccess());
    }).catchError((error) {
      emit(GetAllUsersError(error.toString()));
    });
  }
}
