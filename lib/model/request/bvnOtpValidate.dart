// To parse this JSON data, do
//
//     final validateBvnOtpRequest = validateBvnOtpRequestFromJson(jsonString);

import 'dart:convert';

ValidateBvnOtpRequest validateBvnOtpRequestFromJson(String str) => ValidateBvnOtpRequest.fromJson(json.decode(str));

String validateBvnOtpRequestToJson(ValidateBvnOtpRequest data) => json.encode(data.toJson());

class ValidateBvnOtpRequest {
  String userId;
  String pinId;
  String otp;

  ValidateBvnOtpRequest({
    required this.userId,
    required this.pinId,
    required this.otp,
  });

  factory ValidateBvnOtpRequest.fromJson(Map<String, dynamic> json) => ValidateBvnOtpRequest(
    userId: json["user_id"],
    pinId: json["pin_id"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "pin_id": pinId,
    "otp": otp,
  };
}
