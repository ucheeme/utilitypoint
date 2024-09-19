// To parse this JSON data, do
//
//     final twoFactorAuthenticationRequest = twoFactorAuthenticationRequestFromJson(jsonString);

import 'dart:convert';

TwoFactorAuthenticationRequest twoFactorAuthenticationRequestFromJson(String str) => TwoFactorAuthenticationRequest.fromJson(json.decode(str));

String twoFactorAuthenticationRequestToJson(TwoFactorAuthenticationRequest data) => json.encode(data.toJson());

class TwoFactorAuthenticationRequest {
  String userId;
  String twoFactorCode;

  TwoFactorAuthenticationRequest({
    required this.userId,
    required this.twoFactorCode,
  });

  factory TwoFactorAuthenticationRequest.fromJson(Map<String, dynamic> json) => TwoFactorAuthenticationRequest(
    userId: json["user_id"],
    twoFactorCode: json["two_factor_code"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "two_factor_code": twoFactorCode,
  };
}
