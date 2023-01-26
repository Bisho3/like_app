import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/chat/widget/get_all_user.dart';
import 'package:social_app/presentation/shared_widget/custom_divider.dart';
import 'package:social_app/util/strings.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LogicCubit.get(context).getAllUsers();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    LogicCubit.get(context).users.clear();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LogicCubit cubit = LogicCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(MyStrings.chats),
          ),
          body: ConditionalBuilder(
            condition:cubit.users.isNotEmpty ,
            builder: (context){
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index)=>GetAllUsers(model: cubit.users[index]),
                separatorBuilder:(context,index)=>const CustomMyDivider() ,
                itemCount: cubit.users.length,
              );
            },
            fallback: (context)=> const Center(child: RefreshProgressIndicator()),
          ),
        );
      },
    );
  }
}
