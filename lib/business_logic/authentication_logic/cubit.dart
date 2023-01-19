import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/business_logic/authentication_logic/states.dart';
import 'package:social_app/data/model/authentication/create_user.dart';
import 'package:social_app/data/model/authentication/facebook_model.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/strings.dart';
import 'package:social_app/util/images.dart';
import 'package:social_app/util/sharedpreference.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialStates());


  static AuthCubit get(context) => BlocProvider.of(context);

  String? uIdToken;

  IconData suffixLogin = Icons.visibility_off_outlined;
  bool isPasswordLogin = true;

  void isShowAndHideLoginPassWord() {
    isPasswordLogin = !isPasswordLogin;
    suffixLogin = isPasswordLogin
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ShowAndHideLoginPassword());
  }

  IconData suffixRegisterPassword = Icons.visibility_off_outlined;
  bool isPasswordRegisterPassword = true;

  void isShowAndHideRegisterPassword() {
    isPasswordRegisterPassword = !isPasswordRegisterPassword;
    suffixRegisterPassword = isPasswordRegisterPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ShowAndHideRegisterPassword());
  }

  IconData suffixRegisterConfirmPassword = Icons.visibility_off_outlined;
  bool isPasswordRegisterConfirmPassword = true;

  void isShowAndHideRegisterConfirmPassword() {
    isPasswordRegisterConfirmPassword = !isPasswordRegisterConfirmPassword;
    suffixRegisterConfirmPassword = isPasswordRegisterConfirmPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ShowAndHideRegisterConfirmPassword());
  }

  void userRegister(
      {required String email,
      required String password,
      required String confirmPassword,
      required String city,
      required String area,
      required String location,
      required String address,
      required String phoneNumber,
      required String name}) {
    emit(UserRegisterLoadingStates());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('Bisho');
      print(value.user?.email);
      print(value.user?.uid);
      createUser(
        email: email,
        phoneNumber: phoneNumber,
        city: city,
        area: area,
        location: location,
        name: name,
        address: address,
        profileImage: MyImages.profileImage,
        bio: MyStrings.bio,
        coverImages: MyImages.coverImageHome,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      print(error.toString());
      emit(UserRegisterErrorStates(error.toString()));
    });
  }

  void createUser({
    required String email,
    String? city,
    String? area,
    String? location,
    String? address,
    String? phoneNumber,
    required String name,
    required String uId,
    required String profileImage,
    String? coverImages,
    String? bio,
  }) {
    CreateUser model = CreateUser(
      name: name,
      email: email,
      bio: MyStrings.bio,
      coverImage: MyImages.coverImageHome,
      profileImage: MyImages.profileImage,
      phoneNumber: phoneNumber,
      location: location,
      city: city,
      area: area,
      address: address,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorStates(error.toString()));
    });
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(UserLoginLoadingStates());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(UserLoginSuccessStates(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(UserLoginErrorStates(error.toString()));
    });
  }

  ///========= otp message =========///
  late String verificationId;

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(PhoneLoadingStates());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verification Is Completed');
    await signIn(credential);
  }

  verificationFailed(FirebaseAuthException error) {
    print('verification Is Failed');
    print(error.toString());
    emit(ErrorOccurred(error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    print('code is sent');
    this.verificationId = verificationId;
    emit(PhoneNumberSubmit());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.toString(), smsCode: otpCode);
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    } catch (error) {
      print(error.toString());
      emit(ErrorOccurred(error.toString()));
    }
  }

  ///======== google =====///

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    CacheHelper.saveData(key: "tokenGoogle", value: googleAuth?.accessToken);
    print('saaaaaaaaaaaaaaaaaaa');
    createUser(
      uId: "${googleAuth?.idToken}",
      email: "${googleUser?.email}",
      name: "${googleUser?.displayName}",
      profileImage: "${googleUser?.photoUrl}",
      address: MyStrings.address,
      area: MyStrings.chooseArea,
      bio: MyStrings.bio,
      city: MyStrings.chooseCity,
      coverImages: MyImages.coverImageHome,
      location: MyStrings.location,
      phoneNumber: MyStrings.phoneNumber
    );
    uIdToken = googleAuth?.idToken;
    emit(GoogleSuccess());
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  ///=========== facebook ======///
  FacebookModel? facebookModel;

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    final userData = await FacebookAuth.instance.getUserData();
    facebookModel = FacebookModel.fromJson(userData);
    createUser(
      uId: "${facebookModel?.id}",
      email: "${facebookModel?.email}",
      name: "${facebookModel?.name}",
      profileImage: "${facebookModel?.facebookPhotoModel?.url}",
    );
    uIdToken = facebookModel?.id;
    emit(FacebookSuccess());
    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  ///=======signOut====///
  Future<void> signOutFromApp() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.i.logOut();
    CacheHelper.removeData(key: 'token');
    CacheHelper.removeData(key: 'tokenGoogle');
    CacheHelper.removeData(key: 'tokenFacebook');
    emit(SignOutSuccess());
  }
}
