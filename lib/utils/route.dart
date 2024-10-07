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
Route createFlipRoute(Widget nextPage) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => nextPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Define a rotation effect based on the animation value
      const begin = 1.0;
      const end = 0.0;
      const curve = Curves.easeInOut;

    //  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var tween = Tween(begin: begin, end: end);
      var rotationAnimation = animation.drive(tween);

      return AnimatedBuilder(
        animation: rotationAnimation,
        child: child,
        builder: (context, child) {
          // Apply a 3D rotation along the Y-axis
          final angle = rotationAnimation.value * -3.14;
          return Transform(
            transform: Matrix4.rotationY(angle),
            alignment: Alignment.center,
            child: child,
          );
        },
      );
    },
  );
}
