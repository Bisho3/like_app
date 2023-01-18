import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/business_logic/authentication_logic/states.dart';
import 'package:social_app/data/model/authentication/create_user.dart';
import 'package:social_app/util/sharedpreference.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialStates());

  static AuthCubit get(context) => BlocProvider.of(context);

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

  void userRegister({required String email,
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
        uId: value.user!.uid,
      );
    }).catchError((error) {
      print(error.toString());
      emit(UserRegisterErrorStates(error.toString()));
    });
  }

  void createUser({required String email,
    required String city,
    required String area,
    required String location,
    required String address,
    required String phoneNumber,
    required String name,
    required String uId}) {
    CreateUser model = CreateUser(
      name: name,
      email: email,
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
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;
    final credentialGoogle = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    CacheHelper.saveData(key: "tokenGoogle", value: googleAuth?.accessToken);
    // print('saaaaaaaaaaaaaaaaaaa');
    // print(googleAuth?.accessToken);
    // print(googleAuth?.idToken);
    // print(googleUser?.email);
    // print(googleUser?.displayName);
    // print(googleUser?.serverAuthCode);
    // print(googleUser?.photoUrl);
    return await FirebaseAuth.instance.signInWithCredential(credentialGoogle);
  }

  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
  }
}
