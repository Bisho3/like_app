import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/data/model/authentication/create_user.dart';
import 'package:social_app/presentation/screen/chat/widget/message.dart';
import 'package:social_app/presentation/screen/chat/widget/my_message.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/style.dart';

class ChatDetailsScreen extends StatefulWidget {
  final CreateUser userModel;

  const ChatDetailsScreen({Key? key, required this.userModel})
      : super(key: key);

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((event) {
      alertDialogNotification(
        context: context,
        color: LogicCubit.get(context).isDark ?MyColors.whiteColor : HexColor('333739'),
        imageUrl: '${event.notification?.android?.imageUrl}',
        body: '${event.notification?.body}',
        title: '${event.notification?.title}',
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      alertDialogNotification(
        context: context,
        color: LogicCubit.get(context).isDark ?MyColors.whiteColor : HexColor('333739'),
        imageUrl: '${event.notification?.android?.imageUrl}',
        body: '${event.notification?.body}',
        title: '${event.notification?.title}',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        LogicCubit.get(context)
            .getMessage(receiverId: "${widget.userModel.uId}");
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
                          NetworkImage('${widget.userModel.profileImage}'),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      '${widget.userModel.name}',
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
                        itemBuilder: (context, index) {
                          var message = cubit.messages[index];
                          if (cubit.userModel?.uId == message.senderId) {
                            return MyMessage(
                              model: message,
                            );
                          } else {
                            return Message(
                              model: message,
                            );
                          }
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10.h,
                        ),
                        itemCount: LogicCubit.get(context).messages.length,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: MyColors.lightGrey, width: 1),
                          borderRadius: BorderRadius.circular(10.r)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
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
                                  receiverId: "${widget.userModel.uId}");
                              messageController.clear();
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
