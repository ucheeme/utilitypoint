import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:utilitypoint/utils/constant.dart';

class GlobalData {
  // Create a singleton instance
  static final GlobalData _instance = GlobalData._internal();

  // Flutter secure storage instance
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Private constructor
  GlobalData._internal();

  // Factory method to access the instance
  factory GlobalData() {
    return _instance;
  }

  // Methods to store and retrieve token securely
  Future<void> setToken(String token) async {
    await _secureStorage.write(key:  AppKeys.userToken, value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key:  AppKeys.userToken);
  }

  // Methods for userId
  Future<void> setUserId(String userId) async {
    await _secureStorage.write(key: AppKeys.userId, value: userId);
  }

  Future<String?> getUserId() async {
    return await _secureStorage.read(key:  AppKeys.userId);
  }

  // Methods for userImage
  Future<void> setUserImage(String userImage) async {
    await _secureStorage.write(key:  AppKeys.userImage, value: userImage);
  }

  Future<String?> getUserImage() async {
    return await _secureStorage.read(key:  AppKeys.userImage);
  }

  Future<void> setDevelopmentType(bool value) async {
    await _secureStorage.write(key:  AppKeys.devType,value: value.toString());
  }

  Future<String?> getDevelopmentType() async {
    return await _secureStorage.read(key:  AppKeys.devType);
  }

  // Methods for walletBalance
  Future<void> setWalletBalance(double walletBalance) async {
    await _secureStorage.write(key:  AppKeys.walletBalance, value: walletBalance.toString());
  }

  Future<double?> getWalletBalance() async {
    String? balance = await _secureStorage.read(key:  AppKeys.walletBalance);
    return balance != null ? double.tryParse(balance) : null;
  }

  // Methods for session
  Future<void> setSessionDuration() async {
    await _secureStorage.read(key: AppKeys.sessionExpired,);
  }

  Future<void> getSessionDuration(bool value) async {
    await _secureStorage.write(key: AppKeys.sessionExpired, value: value.toString());
  }

  // Clear all stored data
  Future<void> clearData() async {
    await _secureStorage.deleteAll();
  }
}
