// To parse this JSON data, do
//
//     final userKycResponse = userKycResponseFromJson(jsonString);

import 'dart:convert';

UserKycResponse userKycResponseFromJson(String str) => UserKycResponse.fromJson(json.decode(str));

String userKycResponseToJson(UserKycResponse data) => json.encode(data.toJson());

class UserKycResponse {
  String id;
  String userId;
  String? nin;
  String? driversLicense;
  String? votersCard;
  String? profilePicture;
  String? internationalPassport;
  DateTime createdAt;
  DateTime updatedAt;
  int? verificationStatus;
  UserKycResponse({
    required this.id,
    required this.userId,
    required this.nin,
    required this.driversLicense,
    required this.votersCard,
    required this.profilePicture,
    required this.internationalPassport,
    required this.createdAt,
    required this.updatedAt,
    this.verificationStatus
  });

  factory UserKycResponse.fromJson(Map<String, dynamic> json) => UserKycResponse(
    id: json["id"],
    userId: json["user_id"],
    nin: json["nin"]??"",
    driversLicense: json["drivers_license"]??"",
    votersCard: json["voters_card"]??"",
    profilePicture: json["profile_picture"]??"",
    internationalPassport: json["international_passport"]??"",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    verificationStatus: json["verification_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "nin": nin,
    "drivers_license": driversLicense,
    "voters_card": votersCard,
    "profile_picture": profilePicture,
    "international_passport": internationalPassport,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "verification_status":verificationStatus
  };
}
