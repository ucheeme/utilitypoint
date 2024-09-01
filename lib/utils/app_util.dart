import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../model/defaultModel.dart';

class AppUtils{
  static void debug(dynamic msg){
    if (kDebugMode) {
      print(msg);
    }
  }
  static void showSnack(String msg, BuildContext? context){
    CherryToast.error(
        animationType: AnimationType.fromTop,
        title:   Text(msg)
    ).show(context!);
  }
  static void showSuccessSnack(String msg, BuildContext? context){
    CherryToast.success(
        animationType: AnimationType.fromTop,
        title:   Text(msg)
    ).show(context!);
  }
  static void showInfoSnack(String msg, BuildContext? context){
    CherryToast.info(
        animationType: AnimationType.fromTop,
        title:   Text(msg)
    ).show(context!);
  }
  static String currency(BuildContext context) {
    var format = NumberFormat.simpleCurrency(name: "NGN");
    return "NGN";
  }
  static DefaultApiResponse defaultErrorResponse({String msg = "Error occurred"}){
    var returnValue =  DefaultApiResponse(code: 0,data: null,message: "Error occurred",
        error: DefaultErrorApiResponse(id: "00", service: "Unhandlled Error", details:msg, publicMessage:msg));
    returnValue.message = msg;
    print("Developer Error Detail: $msg");
    return returnValue;
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return false;
    }
    else {
      return true;
    }
  }
  bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp =  RegExp(pattern);
    if (value.isEmpty) {
      return false;
    }
    if (value.length != 10 && value.length != 11) {
      return false;
    }
    else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  bool isPasswordValid(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r"[a-z]"))) return false;
    if (!password.contains(RegExp(r"[A-Z]"))) return false;
    if (!password.contains(RegExp(r"[0-9]"))) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }


  static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }


}

bool validateEmail(String value) {
  Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern as String);
  if (!regex.hasMatch(value)) {
    return false;
  }
  else {
    return true;
  }
}
bool validateMobile(String value) {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp =  RegExp(pattern);
  if (value.isEmpty) {
    return false;
  }
  if (value.length < 10) {
    return false;
  }
  // else if (!regExp.hasMatch(value)) {
  //   return false;
  // }
  return true;
}

bool isPasswordValid(String password) {
  if (password.length < 8) return false;
  if (!password.contains(RegExp(r"[a-z]"))) return false;
  if (!password.contains(RegExp(r"[A-Z]"))) return false;
  if (!password.contains(RegExp(r"[0-9]"))) return false;
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
  return true;
}
String getTimeDifference(String timeStamp){
  DateTime currentTime = DateTime.now();
  DateTime elapseTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(timeStamp));
  if (currentTime.difference(elapseTime).inDays > 0)
  {
    return "${currentTime.difference(elapseTime).inDays} day(s) ago";
  }
  if (currentTime.difference(elapseTime).inHours > 0)
  {
    return "${currentTime.difference(elapseTime).inHours} hour(s) ago";
  }
  if (currentTime.difference(elapseTime).inMinutes > 0)
  {
    return "${currentTime.difference(elapseTime).inMinutes} minute(s) ago";
  }
  return "${currentTime.difference(elapseTime).inSeconds} sec(s) ago";
}
