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
extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
final Map<String, String> networkPrefixes = {
  // MTN Nigeria
  '803': 'MTN',
  '806': 'MTN',
  '703': 'MTN',
  '706': 'MTN',
  '813': 'MTN',
  '816': 'MTN',
  '810': 'MTN',
  '814': 'MTN',
  '903': 'MTN',
  '906': 'MTN',
  // Airtel Nigeria
  '802': 'Airtel',
  '808': 'Airtel',
  '701': 'Airtel',
  '708': 'Airtel',
  '812': 'Airtel',
  '701': 'Airtel',
  '901': 'Airtel',
  '907': 'Airtel',
  // Glo Nigeria
  '805': 'Glo',
  '807': 'Glo',
  '811': 'Glo',
  '815': 'Glo',
  '905': 'Glo',
  // 9mobile (formerly Etisalat Nigeria)
  '809': '9mobile',
  '817': '9mobile',
  '818': '9mobile',
  '908': '9mobile',
  '909': '9mobile',
};
