
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app_util.dart';

var version = "";
String? fcmToken = "";
String deviceId = "";
String deviceName = "";
String platformOS = "";
String deviceModel = "";
String deviceOs = "";
bool requireUpdate = false;
String storeUrl = "";
String appId = "";
bool isStaging = false;
String updateMessage = "A new update is available, update your app now to proceed";


initRemoteConfig() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  // final remoteConfig = FirebaseRemoteConfig.instance;
  // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  // await remoteConfig.setConfigSettings(RemoteConfigSettings(
  //   fetchTimeout: const Duration(minutes: 1),
  //   minimumFetchInterval: const Duration(seconds: 10),
  // ));
  // String version = packageInfo.version;
  // AppUtils.debug("version: $version");
  // AppUtils.debug("buildNumber: $packageInfo");
  // await remoteConfig.setDefaults({
  //   "iOS_version": version,
  //   "android_version": version,
  //   "androidId": "",
  //   "appleId": "",
  //   "isForceUpdate": "",
  //   "updateMessage": "There is a new update available",
  //   "requiresUpdate": false,
  // }
  // );
  // try {
  //   await remoteConfig.fetchAndActivate();
  // } catch (e) {
  //   AppUtils.debug("firebase exception: $e");
  // }
  // bool updateIsRequired = remoteConfig.getBool("requiresUpdate");
  // print("remote config last fetch time: ${remoteConfig.lastFetchTime}");
  // print("remote config last fetch time: ${remoteConfig.getAll()}");
  // print("remote config update is required: $updateIsRequired}");
  //
  // if (!updateIsRequired) {
  //   requireUpdate = false;
  // }


  if (Platform.isAndroid) {
    AndroidDeviceInfo info = await deviceInfo.androidInfo;
    String udid = await FlutterUdid.udid;
    if (udid.isNotEmpty || udid != null) {
      AppUtils.debug("device udid for android ID: ${udid}");
      deviceId = udid;
    } else {
      deviceId = info.id;
      AppUtils.debug("udid is null device Info USED instead: ${info.id}");
    }
    deviceName = info.manufacturer;
    deviceModel = info.model;
    platformOS = "Android";
    deviceOs = "Android";
    AppUtils.debug("platform is Android");
    // var remoteVersion = remoteConfig.getString("android_version");
    // storeUrl = remoteConfig.getString("android_url");
    // updateMessage = remoteConfig.getString("updateMessage");
    // AppUtils.debug("platform is iOS");
    // AppUtils.debug("version: $version");
    // AppUtils.debug("remoteVersion: $remoteVersion");
    // appId = remoteConfig.getString("androidId");
    // AppUtils.debug("appId: $appId");
    // if (remoteVersion != version && updateIsRequired) {
    //   AppUtils.debug("remote version is higher");
    //   requireUpdate = true;
    // }
  }
  if (Platform.isIOS) {
    IosDeviceInfo info = await deviceInfo.iosInfo;
    String udid = await FlutterUdid.udid;
    if (udid.isNotEmpty || udid != null) {
      AppUtils.debug("device udid for android ID: ${udid}");
      deviceId = udid;
    } else {
      deviceId = info.identifierForVendor!;
    //  AppUtils.debug("udid is null device Info USED instead: ${info.id}");
    }

    AppUtils.debug("device Info: ${info}");

    AppUtils.debug("device ID: ${info.identifierForVendor}");
    // Di5XDGYF@gw    1400371829
    ///
    deviceName = "${info.name}' ${info.utsname.machine}";
    deviceModel = info.model;
    platformOS = "${info.systemName} ${info.systemVersion}";
    deviceOs = "I0S";
    // var remoteVersion = remoteConfig.getString("iOS_version");
    // storeUrl = remoteConfig.getString("ios_url");
    // appId = remoteConfig.getString("appleId");
    // updateMessage = remoteConfig.getString("updateMessage");
    // AppUtils.debug("platform is iOS");
    // AppUtils.debug("version: $version");
    // AppUtils.debug("remoteVersion: $remoteVersion");
    // if (remoteVersion.trim() != version.trim() && updateIsRequired) {
    //   AppUtils.debug("remote version is higher");
    //   requireUpdate = true;
    // }
  }


  if (Platform.isLinux) {
    LinuxDeviceInfo info = await deviceInfo.linuxInfo;
    AppUtils.debug("device_info ${info.toMap()}");
  }
  if (Platform.isMacOS) {
    MacOsDeviceInfo info = await deviceInfo.macOsInfo;
    AppUtils.debug("device_info ${info.toMap()}");
  }
  if (Platform.isWindows) {
    WindowsDeviceInfo info = await deviceInfo.windowsInfo;
    AppUtils.debug("device_info ${info.toMap()}");
  }
}