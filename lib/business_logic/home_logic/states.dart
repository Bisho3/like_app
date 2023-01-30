import 'package:social_app/business_logic/home_logic/cubit.dart';

abstract class LogicStates {}

class LogicInitialStates extends LogicStates {}

class LogicChangeNavBottomStates extends LogicStates {}

class LogicUploadNewPostStates extends LogicStates {}

///========get users =======///
class GetUserLoadingStates extends LogicStates {}

class GetUserSuccessStates extends LogicStates {}

class GetUserErrorStates extends LogicStates {
  final String error;

  GetUserErrorStates(this.error);
}

///=========== update users ======//
class UpdateUserLoadingStates extends LogicStates {}

class UpdateUserErrorStates extends LogicStates {
  final String error;

  UpdateUserErrorStates(this.error);
}

///==========reset password ======///
class ResetPasswordEditProfileLoading extends LogicStates {}

class ResetPasswordEditProfileSuccess extends LogicStates {}

class ResetPasswordFail extends LogicStates {
  final String error;

  ResetPasswordFail(this.error);
}

///===========change language ======///
class ConvertLanguageLoading extends LogicStates {}

class ConvertToEnglishLanguageSuccess extends LogicStates {}

class ConvertToArabicLanguageSuccess extends LogicStates {}

///========== images =====///

class GetProfileImageSuccess extends LogicStates {}

class GetProfileImageError extends LogicStates {}

class GetCoverImageSuccess extends LogicStates {}

class GetCoverImageError extends LogicStates {}

class UploadProfileImageLoading extends LogicStates {}

class UploadProfileImageError extends LogicStates {}

class UploadCoverImageLoading extends LogicStates {}

class UploadCoverImageError extends LogicStates {}

///===========post===========///

class GetPostImageSuccess extends LogicStates {}

class GetPostImageError extends LogicStates {}

class CreatePostLoading extends LogicStates {}

class CreatePostSuccess extends LogicStates {}

class CreatePostError extends LogicStates {
  final String error;

  CreatePostError(this.error);
}

class RemovePostSuccess extends LogicStates {}

class GetPostLoading extends LogicStates {}

class GetPostSuccess extends LogicStates {}

class GetPostError extends LogicStates {
  final String error;

  GetPostError(this.error);
}

///=========== like post =========///
class LikePostSuccess extends LogicStates {}

class LikePostError extends LogicStates {
  final String error;

  LikePostError(this.error);
}

///========== comments post ====///
class CommentPostSuccess extends LogicStates {}

class CommentPostError extends LogicStates {
  final String error;

  CommentPostError(this.error);
}

///=========== get all users =============///
class GetAllUsersLoading extends LogicStates {}

class GetAllUsersSuccess extends LogicStates {}

class GetAllUsersError extends LogicStates {
  final String error;

  GetAllUsersError(this.error);
}

///========chats =============///
class SendMessageSuccess extends LogicStates {}

class SendMessageError extends LogicStates {
  final String error;

  SendMessageError(this.error);
}

class GetMessageSuccess extends LogicStates {}

///================== isDark===========///
class AppChangeModeState extends LogicStates {}
