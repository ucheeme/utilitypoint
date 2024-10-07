import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:utilitypoint/services/provider/providerWidget.dart';
import 'package:utilitypoint/utils/app_color_constant.dart';
import 'package:utilitypoint/utils/constant.dart';
import 'package:utilitypoint/utils/device_util.dart';
import 'package:utilitypoint/utils/mySharedPreference.dart';
import 'package:utilitypoint/utils/pages.dart';
import 'package:utilitypoint/utils/route.dart';
import 'package:utilitypoint/view/bottomNav.dart';
import 'package:utilitypoint/view/menuOption/cards/cardScreen.dart';
import 'package:utilitypoint/view/menuOption/contactUs.dart';
import 'package:utilitypoint/view/menuOption/profile.dart';
import 'package:utilitypoint/view/menuOption/settings.dart';
import 'package:utilitypoint/view/onboarding_screen/SignUpScreen.dart';
import 'package:utilitypoint/view/onboarding_screen/forgotpassword_screen.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/twoFactorAuthentication.dart';
import 'package:utilitypoint/view/onboarding_screen/signUp/accountCreated.dart';
import 'package:utilitypoint/view/onboarding_screen/signUp/personal_information.dart';
import 'package:utilitypoint/view/onboarding_screen/signUp/set_transaction_pin.dart';
import 'package:utilitypoint/view/onboarding_screen/signUp/verifyemail.dart';
import 'package:utilitypoint/view/splashScreen/splashScreen.dart';
import 'package:utilitypoint/view/transactionHistory/transaction.dart';

import 'flavour/flavour.dart';
import 'flavour/locator.dart';

void mainCommon(AppFlavorConfig config) async{
  WidgetsFlutterBinding.ensureInitialized();
  statusBarTheme();
  await MySharedPreference.init();
  DeviceUtils.initDeviceInfo();
  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.library == 'image resource service') {
      return;
    }
  };
  setUpLocator(config);
  runApp(MultiProvider(providers:ProviderWidget.blocProviders(),
      child: const MyApp()));
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
var sessionExpired = false;
var requireUpdate = false;
const isProduction = true;
String userToken="";

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context,child)=>GetMaterialApp(
        title: 'UtilityPoint',
        getPages: [
         GetPage(name: Pages.initial, page:()=> Splashscreen(),curve: Curves.easeIn,),
         GetPage(name: Pages.signup, page:()=> SignUpCreateAccountScreen(),curve: Curves.easeIn,),
         GetPage(name: Pages.otpVerification,page: ()=>VerifyEmail(),curve: Curves.easeIn,),
         GetPage(name: Pages.personalInformation, page:()=> PersonalInformation(),curve: Curves.easeIn),
         GetPage(name: Pages.transactionPin, page:()=> SetTransactionPin(),curve: Curves.easeIn),
         GetPage(name: Pages.accountCreated, page:()=> WelcomeScreen(),curve: Curves.easeIn),
         GetPage(name: Pages.login, page:()=> SignInPage(),curve: Curves.easeIn),
         GetPage(name: Pages.forgotPassword, page:()=> ForgotpasswordScreen(),curve: Curves.easeIn),
         GetPage(name: Pages.twoFactorAuthentication, page:()=> Twofactorauthentication(),curve: Curves.easeIn),
        // GetPage(name: Pages.bottomNav, page:()=> MyBottomNav(),curve: Curves.easeIn),
         GetPage(name: Pages.bottomNav, page:()=> CurvedBottomNave(),curve: Curves.easeIn),
          GetPage(name: Pages.myCards, page: ()=>Cardscreen(),curve: Curves.easeIn),
          GetPage(name: Pages.myProfile, page: ()=>ProfileScreen(),curve: Curves.easeIn),
          GetPage(name: Pages.transactionHistory, page: ()=>TransactionScreen(),curve: Curves.easeIn),
          GetPage(name: Pages.settings, page: ()=>SettingsScreens(),curve: Curves.easeIn),
          GetPage(name: Pages.contactUs, page: ()=>ContactusScreen(),curve: Curves.easeIn),
        ],
        initialRoute: Pages.initial,
        // onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColor.primary100,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        builder: (context, widget) {
          return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: widget!);
        },
      ),
    );
  }
}


