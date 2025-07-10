// To parse this JSON data, do
//
//     final createAccountRequest = createAccountRequestFromJson(jsonString);

import 'dart:convert';

import 'package:utilitypoint/utils/device_util.dart';

CreateAccountRequest createAccountRequestFromJson(String str) => CreateAccountRequest.fromJson(json.decode(str));

String createAccountRequestToJson(CreateAccountRequest data) => json.encode(data.toJson());

class CreateAccountRequest {
  String email;
  String password;
  String passwordConfirmation;
  String? deviceID;

  CreateAccountRequest({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    this.deviceID
  });

  factory CreateAccountRequest.fromJson(Map<String, dynamic> json) => CreateAccountRequest(
    email: json["email"],
    password: json["password"],
    passwordConfirmation: json["password_confirmation"],
    deviceID: json["device_id"]
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "password_confirmation": passwordConfirmation,
    "device_id":deviceID=deviceId
  };
}
