import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import 'app_util.dart';

String deviceId = "";
String deviceName = "";
String platformOS = "";
String deviceModel = "";
String deviceOs = "";
class DeviceUtils{
  static initDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      deviceId = "${info.id}23";
      deviceName = info.manufacturer;
      deviceModel = info.model;
      platformOS = "Android";
      deviceOs = "Android";
      AppUtils.debug("platform is Android");
    } else if (Platform.isIOS) {
      IosDeviceInfo info = await deviceInfo.iosInfo;
      deviceId = info.identifierForVendor!;
      deviceName = info.name+"' "+info.utsname.machine;
      deviceModel = info.model;
      deviceOs = "iOS";
      platformOS = info.systemName+" "+info.systemVersion;
    }
  }
  initPackage() async {
    //  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  }
}