// To parse this JSON data, do
//
//     final generateEmailOtpRequest = generateEmailOtpRequestFromJson(jsonString);

import 'dart:convert';

GenerateEmailOtpRequest generateEmailOtpRequestFromJson(String str) => GenerateEmailOtpRequest.fromJson(json.decode(str));

String generateEmailOtpRequestToJson(GenerateEmailOtpRequest data) => json.encode(data.toJson());

class GenerateEmailOtpRequest {
  String userId;
  String deviceId;

  GenerateEmailOtpRequest({
    required this.userId,
    required this.deviceId,
  });

  factory GenerateEmailOtpRequest.fromJson(Map<String, dynamic> json) => GenerateEmailOtpRequest(
    userId: json["user_id"],
    deviceId: json["device_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "device_id": deviceId,
  };
}
