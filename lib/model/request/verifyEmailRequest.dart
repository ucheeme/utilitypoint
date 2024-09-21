// To parse this JSON data, do
//
//     final verifiedEmailRequest = verifiedEmailRequestFromJson(jsonString);

import 'dart:convert';

VerifiedEmailRequest verifiedEmailRequestFromJson(String str) => VerifiedEmailRequest.fromJson(json.decode(str));

String verifiedEmailRequestToJson(VerifiedEmailRequest data) => json.encode(data.toJson());

class VerifiedEmailRequest {
  String? userId;
  String? otp;

  VerifiedEmailRequest({
     this.userId,
     this.otp,
  });

  factory VerifiedEmailRequest.fromJson(Map<String, dynamic> json) => VerifiedEmailRequest(
    userId: json["user_id"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "otp": otp,
  };
}
