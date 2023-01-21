import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/business_logic/authentication_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/cubit.dart';
import 'package:social_app/business_logic/home_logic/states.dart';
import 'package:social_app/presentation/screen/authentication/screen/login.dart';
import 'package:social_app/presentation/screen/home/screen/home_screen.dart';
import 'package:social_app/presentation/screen/no_internet/no_internet.dart';
import 'package:social_app/presentation/screen/splash_screen_and_onboarding/screen/onboarding_screen.dart';
import 'package:social_app/presentation/screen/splash_screen_and_onboarding/screen/splash_screen.dart';
import 'package:social_app/util/bloc_observer.dart';
import 'package:social_app/util/helper.dart';
import 'package:social_app/util/sharedpreference.dart';
import 'package:social_app/util/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget widget;
  var onBoarding = CacheHelper.getData(key: 'onBoarding');
  var token = CacheHelper.getData(key: 'token');

  if (onBoarding == null && token == null) {
    widget = const OnBoardingScreen();
  } else if (onBoarding != null && token == null) {
    widget = LoginScreen();
  } else {
    widget = const HomeScreen();
  }
  runApp(
      EasyLocalization(supportedLocales: const [
        Locale('ar', 'EG'),
        Locale('en', 'US'),
      ],
        path: 'assets/translations',
        saveLocale: true,
        child: MyApp(startWidget: widget),)
  );
}

class MyApp extends StatelessWidget {
  Widget startWidget;

  MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AuthCubit()
        ),

        BlocProvider(
            create: (BuildContext context) => LogicCubit()
        ),
      ],
      child: BlocConsumer<LogicCubit, LogicStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp(
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  debugShowCheckedModeBanner: false,
                  theme: lightTheme,
                  home: child,
                );
              },
              child: OfflineBuilder(
                connectivityBuilder: (BuildContext context,
                    ConnectivityResult connectivity,
                    Widget child,) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
                  if (connected) {
                    return SplashScreen(startScreen: startWidget);
                  } else {
                    return const NoInternetScreen();
                  }
                },
                child: const SizedBox(),
              )
          );
        },
      ),
    );
  }
}

