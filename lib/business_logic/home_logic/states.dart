abstract class LogicStates{}

class LogicInitialStates extends LogicStates {}

class LogicChangeNavBottomStates extends LogicStates{}

class LogicUploadNewPostStates extends LogicStates{}
///========get users =======///
class GetUserLoadingStates extends LogicStates{}

class GetUserSuccessStates extends LogicStates{}

class GetUserErrorStates extends LogicStates{
  final String error;

  GetUserErrorStates(this.error);
}
///=========== update users ======//
class UpdateUserLoadingStates extends LogicStates{}

class UpdateUserErrorStates extends LogicStates{
  final String error;

  UpdateUserErrorStates(this.error);
}
///==========reset password ======///
class ResetPasswordEditProfileLoading extends LogicStates{}

class ResetPasswordEditProfileSuccess extends LogicStates{}

class ResetPasswordFail extends LogicStates{
  final String error;

  ResetPasswordFail(this.error);
}
///===========change language ======///
class ConvertLanguageLoading extends LogicStates{}
class ConvertToArabicLanguageSuccess extends LogicStates{}
class ConvertToEnglishLanguageSuccess extends LogicStates{}
///========== images =====///

class GetProfileImageSuccess extends LogicStates{}
class GetProfileImageError extends LogicStates{}

class GetCoverImageSuccess extends LogicStates{}
class GetCoverImageError extends LogicStates{}

class UploadProfileImageLoading extends LogicStates{}
class UploadProfileImageError extends LogicStates{}
class UploadCoverImageLoading extends LogicStates{}
class UploadCoverImageError extends LogicStates{}