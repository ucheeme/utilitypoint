// To parse this JSON data, do
//
//     final signInResetPasswordRequest = signInResetPasswordRequestFromJson(jsonString);

import 'dart:convert';

SignInResetPasswordRequest signInResetPasswordRequestFromJson(String str) => SignInResetPasswordRequest.fromJson(json.decode(str));

String signInResetPasswordRequestToJson(SignInResetPasswordRequest data) => json.encode(data.toJson());

class SignInResetPasswordRequest {
  String userId;
  String password;
  String confirmPassword;
  String resetCode;

  SignInResetPasswordRequest({
    required this.userId,
    required this.password,
    required this.confirmPassword,
    required this.resetCode,
  });

  factory SignInResetPasswordRequest.fromJson(Map<String, dynamic> json) => SignInResetPasswordRequest(
    userId: json["user_id"],
    password: json["password"],
    confirmPassword: json["confirm_password"],
    resetCode: json["reset_code"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "password": password,
    "confirm_password": confirmPassword,
    "reset_code": resetCode,
  };
}
