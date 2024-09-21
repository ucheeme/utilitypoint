// To parse this JSON data, do
//
//     final setTransactionPin = setTransactionPinFromJson(jsonString);

import 'dart:convert';

SetTransactionPinRequest setTransactionPinFromJson(String str) => SetTransactionPinRequest.fromJson(json.decode(str));

String setTransactionPinToJson(SetTransactionPinRequest data) => json.encode(data.toJson());

class SetTransactionPinRequest {
  String userId;
  String pin;
  String confirmPin;

  SetTransactionPinRequest({
    required this.userId,
    required this.pin,
    required this.confirmPin,
  });

  factory SetTransactionPinRequest.fromJson(Map<String, dynamic> json) => SetTransactionPinRequest(
    userId: json["user_id"],
    pin: json["pin"],
    confirmPin: json["confirm_pin"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "pin": pin,
    "confirm_pin": confirmPin,
  };
}
