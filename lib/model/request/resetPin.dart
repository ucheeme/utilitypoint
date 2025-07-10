// To parse this JSON data, do
//
//     final resetUserPinRequest = resetUserPinRequestFromJson(jsonString);

import 'dart:convert';

import '../../utils/device_util.dart';

ResetUserPinRequest resetUserPinRequestFromJson(String str) => ResetUserPinRequest.fromJson(json.decode(str));

String resetUserPinRequestToJson(ResetUserPinRequest data) => json.encode(data.toJson());

class ResetUserPinRequest {
  String userId;
  String currentPin;
  String newPin;
  String confirmNewPin;
  String? idDevice;

  ResetUserPinRequest({
    required this.userId,
    required this.currentPin,
    required this.newPin,
    required this.confirmNewPin,
    this.idDevice
  });

  factory ResetUserPinRequest.fromJson(Map<String, dynamic> json) => ResetUserPinRequest(
    userId: json["user_id"],
    currentPin: json["current_pin"],
    newPin: json["new_pin"],
    confirmNewPin: json["confirm_new_pin"],
    idDevice: json["device_id"]
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "current_pin": currentPin,
    "new_pin": newPin,
    "confirm_new_pin": confirmNewPin,
    "device_id": deviceId
  };
}
