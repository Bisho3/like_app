import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/authentication_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/authentication/screen/login.dart';
import 'package:social_app/presentation/screen/splash_screen_and_onboarding/screen/splash_screen.dart';
import 'package:social_app/presentation/shared_widget/custom_material_button.dart';
import 'package:social_app/util/helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogicCubit, LogicStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('home page'),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            context.setLocale(Locale("ar", "EG"));
                          });
                        },
                        child: Text('Arabic'),
                      )),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          context.setLocale(Locale("en", "US"));
                        });
                      },
                      child: Text('English'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomMaterialButton(
                function: () async{
                  await AuthCubit.get(context).signOutGoogle();
                  navigatorAndRemove(context, LoginScreen());
                },
                text: 'sijkjh',
              ),

            ],
          ),
        );
      },
    );
  }
}
