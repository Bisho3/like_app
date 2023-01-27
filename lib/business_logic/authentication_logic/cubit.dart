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

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookAuth facebookAuth = FacebookAuth.instance;
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
        byEmail: true,
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
    required bool? byEmail,
  }) {
    CreateUser model = CreateUser(
        name: name,
        email: email,
        bio: MyStrings.bio,
        coverImage: coverImages,
        profileImage: profileImage,
        phoneNumber: phoneNumber,
        location: location,
        city: city,
        area: area,
        address: address,
        uId: uId,
        byEmail: byEmail);
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

  ///========= otp message =========///
  late String verificationId;

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(PhoneLoadingStates());
    await auth.verifyPhoneNumber(
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
      await auth.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    } catch (error) {
      print(error.toString());
      emit(ErrorOccurred(error.toString()));
    }
  }

  ///======== google =====///
  void signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );
    await auth.signInWithCredential(credential).then((value) {
      createUser(
          uId: "${googleSignInAuthentication?.idToken}",
          email: "${googleSignInAccount?.email}",
          name: "${googleSignInAccount?.displayName}",
          profileImage: "${googleSignInAccount?.photoUrl}",
          address: MyStrings.address,
          area: MyStrings.chooseArea,
          bio: MyStrings.bio,
          city: MyStrings.chooseCity,
          coverImages: MyImages.coverImageHome,
          location: MyStrings.location,
          byEmail: false,
          phoneNumber: MyStrings.phoneNumber);
      emit(GoogleSuccess());
    }).catchError((error) {
      print(error.toString());
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(GoogleFail(error.toString()));
    });
  }

  ///=========== facebook ======///
  FacebookModel? facebookModel;

  void signInWithFacebook() async {
    final LoginResult loginResult = await facebookAuth.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    final userData = await facebookAuth.getUserData();

    auth.signInWithCredential(facebookAuthCredential).then((value) {
      facebookModel = FacebookModel.fromJson(userData);
      createUser(
        uId: "${facebookModel?.id}",
        email: "${facebookModel?.email}",
        name: "${facebookModel?.name}",
        profileImage: "${facebookModel?.facebookPhotoModel?.url}",
        coverImages: MyImages.coverImageHome,
        bio: MyStrings.bio,
        phoneNumber: MyStrings.phoneNumber,
        address: MyStrings.address,
        area: MyStrings.chooseArea,
        city: MyStrings.chooseCity,
        location: MyStrings.location,
        byEmail: false,
      );
      emit(FacebookSuccess());
    }).catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(FacebookFail(error: error.toString()));
    });
  }

  ///============= login ============///
  void userLoginWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    emit(UserLoginLoadingStates());
    auth
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

  void userLoginWithGoogle() async {
    emit(UserLoginLoadingStates());

    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );
    await auth.signInWithCredential(credential).then((value) {
      emit(UserLoginSuccessStates("${googleSignInAuthentication?.idToken}"));
    }).catchError((error) {
      emit(UserLoginErrorStates(error.toString()));
    });
  }

  void userLoginWithFacebook() async {
    emit(UserLoginLoadingStates());
    LoginResult loginResult = await facebookAuth.login();
    OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    auth.signInWithCredential(facebookAuthCredential).then((value) {
      emit(UserLoginSuccessStates(("${facebookModel?.id}")));
    }).catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(UserLoginErrorStates(error.toString()));
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

  ///=======signOut====///
  void signOutFromApp() async {
    await auth.signOut();
    await googleSignIn.signOut();
    await FacebookAuth.i.logOut();
    CacheHelper.removeData(key: 'token');
    emit(SignOutSuccess());
  }
}
