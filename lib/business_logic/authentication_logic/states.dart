abstract class AuthStates {}

class AuthInitialStates extends AuthStates {}

class ShowAndHideLoginPassword extends AuthStates {}

class ShowAndHideRegisterPassword extends AuthStates {}

class ShowAndHideRegisterConfirmPassword extends AuthStates {}

class UserRegisterLoadingStates extends AuthStates {}

class UserRegisterSuccessStates extends AuthStates {}

class UserRegisterErrorStates extends AuthStates {
  final String error;

  UserRegisterErrorStates(this.error);
}

class CreateUserSuccessStates extends AuthStates {}

class CreateUserErrorStates extends AuthStates {
  final String error;

  CreateUserErrorStates(this.error);
}

class UserLoginLoadingStates extends AuthStates {}

class UserLoginSuccessStates extends AuthStates {
  final String uId;

  UserLoginSuccessStates(this.uId);
}

class UserLoginErrorStates extends AuthStates {
  final String error;

  UserLoginErrorStates(this.error);
}

///========== otp message======///
class PhoneLoadingStates extends AuthStates {}

class ErrorOccurred extends AuthStates {
  final String error;

  ErrorOccurred(this.error);
}

class PhoneOTPVerified extends AuthStates {}

class PhoneNumberSubmit extends AuthStates {}

///===============google=============///
class GoogleSuccess extends AuthStates {}

class GoogleFail extends AuthStates{
  final String error;

  GoogleFail(this.error);
}
///==================facebook==========///
class FacebookSuccess extends AuthStates {}

class FacebookFail extends AuthStates {
  final String error;

  FacebookFail({required this.error});
}


///========signOutFromApp =====///
class SignOutSuccess extends AuthStates {}
///==========reset password ======///
class ResetPasswordLoading extends AuthStates{}

class ResetPasswordSuccess extends AuthStates{}

class ResetPasswordFail extends AuthStates{
  final String error;

  ResetPasswordFail(this.error);
}