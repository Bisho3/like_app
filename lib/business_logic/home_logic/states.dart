abstract class LogicStates{}

class LogicInitialStates extends LogicStates {}

class LogicChangeNavBottomStates extends LogicStates{}

class LogicUploadNewPostStates extends LogicStates{}

class GetUserLoadingStates extends LogicStates{}

class GetUserSuccessStates extends LogicStates{}

class GetUserErrorStates extends LogicStates{
  final String error;

  GetUserErrorStates(this.error);
}
