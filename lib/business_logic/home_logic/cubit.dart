import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/home_logic/states.dart';

class LogicCubit extends Cubit<LogicStates>{
  LogicCubit() : super(LogicInitialStates());
  static LogicCubit get(context) => BlocProvider.of(context);

}