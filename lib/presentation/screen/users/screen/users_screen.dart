import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/users/widget/GetAllUsers.dart';
import 'package:social_app/presentation/shared_widget/custom_divider.dart';
import 'package:social_app/util/adaptive/adaptive_indicator.dart';
import 'package:social_app/util/constant.dart';
import 'package:social_app/util/strings.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit,LogicStates>(
      listener: (context,state){},
      builder: (context,state){
        LogicCubit cubit =LogicCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(MyStrings.users),
          ),
          body:  ConditionalBuilder(
            condition:cubit.users.isNotEmpty ,
            builder: (context){
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index)=>GetAllUser(model: cubit.users[index]),
                separatorBuilder:(context,index)=>const CustomMyDivider() ,
                itemCount: cubit.users.length,
              );
            },
            fallback: (context)=>Center(child: AdaptiveIndicator(
              os: getOs(),
            )),
          ),
        );
      },
    );
  }
}
