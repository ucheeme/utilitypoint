import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utilitypoint/utils/pages.dart';
import 'package:utilitypoint/view/onboarding_screen/signUp/accountCreated.dart';
import 'package:utilitypoint/view/onboarding_screen/signUp/personal_information.dart';
import 'package:utilitypoint/view/onboarding_screen/signUp/verifyemail.dart';

import '../page_not_found.dart';
import '../view/onboarding_screen/signUp/set_transaction_pin.dart';
import '../view/splashScreen/splashScreen.dart';

// Route onGenerateRoute(RouteSettings routeSettings){
//   switch(routeSettings.name){
//     case Pages.initial:return MaterialPageRoute(builder: (context)=>  Splashscreen(),);
//     case Pages.otpVerification:return MaterialPageRoute(builder: (context)=>VerifyEmail());
//     case Pages.personalInformation: return MaterialPageRoute(builder: (context)=>PersonalInformation());
//     case Pages.transactionPin: return MaterialPageRoute(builder: (context)=>SetTransactionPin());
//     case Pages.accountCreated: return MaterialPageRoute(builder: (context)=>WelcomeScreen());
//     case Pages.login: return MaterialPageRoute(builder: (context)=> const PageNotFound());
//     default:
//       return MaterialPageRoute(builder: (context)=> const PageNotFound());
//   }
// }