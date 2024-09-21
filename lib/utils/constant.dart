import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void statusBarTheme(){
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.light));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
}

EdgeInsets customPadding= EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h);

class AppConstantData{
  AppConstantData();
  bool sessionExpired = false;
  bool requireUpdate = false;
  bool isProduction = true;
  bool isLogin = false;
}

class AppKeys{
  static const devType ='developmentType';
  static const userToken ='token';
  static const userId ='userId';
  static const userImage ='userImage';
  static const walletBalance ='walletBalance';
  static const requireUpdate ='requireUpdate';
  static const sessionExpired ='walletBalance';
}