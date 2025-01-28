// To parse this JSON data, do
//
//     final bvnFinalVerified = bvnFinalVerifiedFromJson(jsonString);

import 'dart:convert';

BvnFinalVerified bvnFinalVerifiedFromJson(String str) => BvnFinalVerified.fromJson(json.decode(str));

String bvnFinalVerifiedToJson(BvnFinalVerified data) => json.encode(data.toJson());

class BvnFinalVerified {
  bool verified;
  String pinId;
  String msisdn;
  int attemptsRemaining;

  BvnFinalVerified({
    required this.verified,
    required this.pinId,
    required this.msisdn,
    required this.attemptsRemaining,
  });

  factory BvnFinalVerified.fromJson(Map<String, dynamic> json) => BvnFinalVerified(
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
