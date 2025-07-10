import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:utilitypoint/services/provider/providerWidget.dart';
import 'package:utilitypoint/utils/app_color_constant.dart';
import 'package:utilitypoint/utils/app_util.dart';
import 'package:utilitypoint/utils/constant.dart';
import 'package:utilitypoint/utils/device_util.dart';
import 'package:utilitypoint/utils/mySharedPreference.dart';
import 'package:utilitypoint/utils/pages.dart';
import 'package:utilitypoint/utils/route.dart';
import 'package:utilitypoint/view/bottomNav.dart';
import 'package:utilitypoint/view/menuOption/cards/cardScreen.dart';
import 'package:utilitypoint/view/menuOption/contactUs.dart';
import 'package:utilitypoint/view/menuOption/notifications.dart';
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

import 'firebase_options.dart';
import 'flavour/flavour.dart';
import 'flavour/locator.dart';
bool isNewAccount =false;
String isCreateAccountFirstStep ="isCreateAccountFirstStep";
String isCreateAccountSecondStep ="isCreateAccountSecondStep";
String isCreateAccountThirdStep ="isCreateAccountThirdStep";
String isCreateAccountFourthStep ="isCreateAccountFourthStep";
String isUseBiometeric ="isUseBiometric";
String isUserName ="isUserName";
String isUserPassword ="isUserPassword";
ThemeMode themeMode = ThemeMode.system;
void mainCommon(AppFlavorConfig config) async{
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.contacts.request();
  try {

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
    // await FirebaseService().initNotifications();

  }catch(e){
    AppUtils.debug("Failed to initialize Firebase: $e");
  }
  statusBarTheme();
  await MySharedPreference.init();
  await initRemoteConfig();
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
  bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diagonal = sqrt((size.width * size.width) + (size.height * size.height));
    return diagonal > 1100; // typical tablet threshold (in logical pixels)
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_,constraints) {
        return OrientationBuilder(builder: (_,builder){
          final windowSize = WidgetsBinding.instance.window.physicalSize /
              WidgetsBinding.instance.window.devicePixelRatio;

          final width = windowSize.width;
          final height = windowSize.height;
          final diagonal = sqrt(width * width + height * height);
          print("Width: $width, Height: $height, Diagonal: $diagonal");
          final isTabletDevice = diagonal.toPrecision(0) > 1100.0;
          print(isTabletDevice);
          return  ScreenUtilInit(
            designSize: isTabletDevice ?  Size(800, 1280) :  Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            useInheritedMediaQuery: true,
            builder: (context,child)=>GetMaterialApp(
              // navigatorObservers: [observer],
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
                GetPage(name: Pages.notification, page:()=> NotificationsScreen(),curve: Curves.easeIn),
                GetPage(name: Pages.bottomNav, page:()=> MyBottomNav(),curve: Curves.easeIn),
                GetPage(name: Pages.myCards, page: ()=>Cardscreen(),curve: Curves.easeIn),
                GetPage(name: Pages.myProfile, page: ()=>ProfileScreen(),curve: Curves.easeIn),
                GetPage(name: Pages.transactionHistory, page: ()=>TransactionScreen(),curve: Curves.easeIn),
                GetPage(name: Pages.settings, page: ()=>SettingsScreens(),curve: Curves.easeIn),
                GetPage(name: Pages.contactUs, page: ()=>ContactusScreen(),curve: Curves.easeIn),
              ],
              initialRoute: Pages.initial,
              debugShowCheckedModeBanner: false,
              builder: (context, widget) {
                return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: widget!);
              },
            ),
          );
        });
      },
    );
  }
}


