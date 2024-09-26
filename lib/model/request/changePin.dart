// To parse this JSON data, do
//
//     final changePinRequest = changePinRequestFromJson(jsonString);

import 'dart:convert';

ChangePinRequest changePinRequestFromJson(String str) => ChangePinRequest.fromJson(json.decode(str));

String changePinRequestToJson(ChangePinRequest data) => json.encode(data.toJson());

class ChangePinRequest {
  String userId;
  String currentPin;
  String newPin;
  String confirmNewPin;

  ChangePinRequest({
    required this.userId,
    required this.currentPin,
    required this.newPin,
    required this.confirmNewPin,
  });

  factory ChangePinRequest.fromJson(Map<String, dynamic> json) => ChangePinRequest(
    userId: json["user_id"],
    currentPin: json["current_pin"],
    newPin: json["new_pin"],
    confirmNewPin: json["confirm_new_pin"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "current_pin": currentPin,
    "new_pin": newPin,
    "confirm_new_pin": confirmNewPin,
  };
}
