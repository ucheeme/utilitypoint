// To parse this JSON data, do
//
//     final changeUserPasswordRequest = changeUserPasswordRequestFromJson(jsonString);

import 'dart:convert';

import '../../utils/device_util.dart';

ChangeUserPasswordRequest changeUserPasswordRequestFromJson(String str) => ChangeUserPasswordRequest.fromJson(json.decode(str));

String changeUserPasswordRequestToJson(ChangeUserPasswordRequest data) => json.encode(data.toJson());

class ChangeUserPasswordRequest {
  String userId;
  String currentPassword;
  String newPassword;
  String confirmNewPassword;
  String? idDevice=deviceId;

  ChangeUserPasswordRequest({
    required this.userId,
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
    this.idDevice
  });

  factory ChangeUserPasswordRequest.fromJson(Map<String, dynamic> json) => ChangeUserPasswordRequest(
    userId: json["user_id"],
    currentPassword: json["current_password"],
    newPassword: json["new_password"],
    confirmNewPassword: json["confirm_new_password"],
    idDevice: json["device_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "current_password": currentPassword,
    "new_password": newPassword,
    "confirm_new_password": confirmNewPassword,
    "device_id": idDevice=deviceId,
  };
}
