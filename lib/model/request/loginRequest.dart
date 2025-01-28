// To parse this JSON data, do
//
//     final loginUserRequest = loginUserRequestFromJson(jsonString);

import 'dart:convert';

LoginUserRequest loginUserRequestFromJson(String str) => LoginUserRequest.fromJson(json.decode(str));

String loginUserRequestToJson(LoginUserRequest data) => json.encode(data.toJson());

class LoginUserRequest {
  String userName;
  String password;
  String deviceId;

  LoginUserRequest({
    required this.userName,
    required this.password,
    required this.deviceId,
  });

  factory LoginUserRequest.fromJson(Map<String, dynamic> json) => LoginUserRequest(
    userName: json["user_name"],
    password: json["password"],
    deviceId: json["device_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "password": password,
    "device_id": deviceId,
  };
}
