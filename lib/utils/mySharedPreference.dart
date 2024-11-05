import 'package:shared_preferences/shared_preferences.dart';

import '../model/response/userInfoUpdated.dart';

class MySharedPreference{
  static SharedPreferences ? _preferences;
  static Future init() async =>_preferences=await SharedPreferences.getInstance();
  static Future saveEmail(String email) async {_preferences?.setString('email', email);}
  static Future saveNumOfNotification(String num) async {_preferences?.setString('numOfNotification', num);}
  static Future saveAccessToken(String email) async {_preferences?.setString('token', email);}
  static Future saveUserLoginResponse(String loginResponse) async {_preferences?.setString('login', loginResponse);}

  static String getEmail()  {return _preferences?.getString('email')??"";}
  static String getAccessToken()  {return _preferences?.getString('token')??"";}
  static String getNumOfNotification()  {return _preferences?.getString('numOfNotification')??"0";}


  static Future<bool>getVisitingFlag() async{
    bool alreadyVisited=_preferences?.getBool("alreadyvisited") ?? false;
    return alreadyVisited;
  }

  static Future<UserInfoUpdated?> getUserLogin()async{
    UserInfoUpdated? response =(_preferences?.getString("login")==null)?null:userInfoUpdatedFromJson(_preferences?.getString("login")??"");
    return response;
  }

  static setVisitingFlag() async{return _preferences?.setBool("alreadyvisited", true);}

  static clearSharedPref() async{await _preferences?.remove("alreadyvisited");}

  ///Danger zone
  static deleteAllSharedPref() async{await _preferences?.clear();}
}

