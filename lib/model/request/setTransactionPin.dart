// To parse this JSON data, do
//
//     final setTransactionPin = setTransactionPinFromJson(jsonString);

import 'dart:convert';

import '../../utils/device_util.dart';

SetTransactionPinRequest setTransactionPinFromJson(String str) => SetTransactionPinRequest.fromJson(json.decode(str));

String setTransactionPinToJson(SetTransactionPinRequest data) => json.encode(data.toJson());

class SetTransactionPinRequest {
  String userId;
  String pin;
  String confirmPin;
  String? deviceIds;

  SetTransactionPinRequest({
    required this.userId,
    required this.pin,
    required this.confirmPin,
     this.deviceIds,
  });

  factory SetTransactionPinRequest.fromJson(Map<String, dynamic> json) => SetTransactionPinRequest(
    userId: json["user_id"],
    pin: json["pin"],
    confirmPin: json["confirm_pin"],
    deviceIds: json["device_id"]
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "pin": pin,
    "confirm_pin": confirmPin,
    "device_id": deviceIds=deviceId,
  };
}
