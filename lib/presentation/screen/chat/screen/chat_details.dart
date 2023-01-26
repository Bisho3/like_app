import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/data/model/authentication/create_user.dart';
import 'package:social_app/presentation/screen/chat/widget/message.dart';
import 'package:social_app/presentation/screen/chat/widget/my_message.dart';
import 'package:social_app/util/style.dart';

class ChatDetailsScreen extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();
  final CreateUser userModel;

  ChatDetailsScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        LogicCubit.get(context).getMessage(receiverId: "${userModel.uId}");
        return BlocConsumer<LogicCubit, LogicStates>(
          listener: (context, state) {},
          builder: (context, state) {
            LogicCubit cubit = LogicCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage:
                          NetworkImage('${userModel.profileImage}'),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      '${userModel.name}',
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
              body: Padding(
                padding: EdgeInsets.all(20.h),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context,index){
                          var message = cubit.messages[index];
                          if(cubit.userModel?.uId == message.senderId){
                            return MyMessage(model: message,);
                          }else{
                            return Message(model: message,);
                          }
                        },
                        separatorBuilder:(context,index)=> SizedBox(
                          height: 10.h,
                        ),
                        itemCount: LogicCubit.get(context).messages.length,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: MyColors.lightGrey, width: 1),
                          borderRadius: BorderRadius.circular(10.r)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                //hint
                              ),
                            ),
                          ),
                          MaterialButton(
                            color: MyColors.primaryColor,
                            minWidth: 1.0,
                            height: 50.h,
                            onPressed: () {
                              cubit.sendMessage(
                                  text: messageController.text,
                                  dateTime: DateTime.now().toString(),
                                  receiverId: "${userModel.uId}");
                            },
                            child: Icon(
                              Icons.send,
                              size: 18.h,
                              color: MyColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
