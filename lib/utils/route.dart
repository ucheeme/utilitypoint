import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utilitypoint/utils/pages.dart';

import '../page_not_found.dart';
import '../view/splashScreen/splashScreen.dart';

Route onGenerateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case Pages.initial:return MaterialPageRoute(builder: (context)=>  Splashscreen());
    case Pages.login:
    default:
      return MaterialPageRoute(builder: (context)=> const PageNotFound());
  }
}