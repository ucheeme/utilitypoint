// To parse this JSON data, do
//
//     final loginUserRequest = loginUserRequestFromJson(jsonString);

import 'dart:convert';

LoginUserRequest loginUserRequestFromJson(String str) => LoginUserRequest.fromJson(json.decode(str));

String loginUserRequestToJson(LoginUserRequest data) => json.encode(data.toJson());

class LoginUserRequest {
  String userName;
  String password;
  String deviceName;

  LoginUserRequest({
    required this.userName,
    required this.password,
    required this.deviceName,
  });

  factory LoginUserRequest.fromJson(Map<String, dynamic> json) => LoginUserRequest(
    userName: json["user_name"],
    password: json["password"],
    deviceName: json["device_name"],
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "password": password,
    "device_name": deviceName,
  };
}
