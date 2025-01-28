// To parse this JSON data, do
//
//     final validateBvnOtpResponse = validateBvnOtpResponseFromJson(jsonString);

import 'dart:convert';

ValidateBvnOtpResponse validateBvnOtpResponseFromJson(String str) => ValidateBvnOtpResponse.fromJson(json.decode(str));

String validateBvnOtpResponseToJson(ValidateBvnOtpResponse data) => json.encode(data.toJson());

class ValidateBvnOtpResponse {
  bool verified;
  String pinId;
  String msisdn;
  int attemptsRemaining;

  ValidateBvnOtpResponse({
    required this.verified,
    required this.pinId,
    required this.msisdn,
    required this.attemptsRemaining,
  });

  factory ValidateBvnOtpResponse.fromJson(Map<String, dynamic> json) => ValidateBvnOtpResponse(
    verified: json["verified"],
    pinId: json["pinId"],
    msisdn: json["msisdn"],
    attemptsRemaining: json["attemptsRemaining"],
  );

  Map<String, dynamic> toJson() => {
    "verified": verified,
    "pinId": pinId,
    "msisdn": msisdn,
    "attemptsRemaining": attemptsRemaining,
  };
}
