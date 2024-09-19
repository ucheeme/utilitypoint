import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference{
  static SharedPreferences ? _preferences;
  static Future init() async =>_preferences=await SharedPreferences.getInstance();
  static Future saveEmail(String email) async {_preferences?.setString('email', email);}
  static String getEmail()  {return _preferences?.getString('email')??"";}


  static Future<bool>getVisitingFlag() async{
    bool alreadyVisited=_preferences?.getBool("alreadyvisited") ?? false;
    return alreadyVisited;
  }
  static setVisitingFlag() async{return _preferences?.setBool("alreadyvisited", true);}

  static clearSharedPref() async{await _preferences?.remove("alreadyvisited");}

  ///Danger zone
  static deleteAllSharedPref() async{await _preferences?.clear();}
}

