// To parse this JSON data, do
//
//     final changePinRequest = changePinRequestFromJson(jsonString);

import 'dart:convert';

import '../../utils/device_util.dart';

ChangePinRequest changePinRequestFromJson(String str) => ChangePinRequest.fromJson(json.decode(str));

String changePinRequestToJson(ChangePinRequest data) => json.encode(data.toJson());

class ChangePinRequest {
  String userId;
  String currentPin;
  String newPin;
  String confirmNewPin;
  String? idDevice = deviceId;

  ChangePinRequest({
    required this.userId,
    required this.currentPin,
    required this.newPin,
    required this.confirmNewPin,
    this.idDevice
  });

  factory ChangePinRequest.fromJson(Map<String, dynamic> json) => ChangePinRequest(
    userId: json["user_id"],
    currentPin: json["current_pin"],
    newPin: json["new_pin"],
    confirmNewPin: json["confirm_new_pin"],
    idDevice: json["id_device"]
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "current_pin": currentPin,
    "new_pin": newPin,
    "confirm_new_pin": confirmNewPin,
    "id_device": idDevice
  };
}
