import 'package:social_app/util/sharedpreference.dart';

class AppConstant{
  static  String uId = "${CacheHelper.getData(key: 'token')}";
}
// await AuthCubit.get(context).signOutFromApp();
// navigatorAndRemove(context, LoginScreen());

