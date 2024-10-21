// To parse this JSON data, do
//
//     final userKycDetails = userKycDetailsFromJson(jsonString);

import 'dart:convert';

UserKycDetails userKycDetailsFromJson(String str) => UserKycDetails.fromJson(json.decode(str));

String userKycDetailsToJson(UserKycDetails data) => json.encode(data.toJson());

class UserKycDetails {
  String id;
  String userId;
  dynamic nin;
  dynamic driversLicense;
  String votersCard;
  dynamic profilePicture;
  dynamic internationalPassport;
  DateTime createdAt;
  DateTime updatedAt;

  UserKycDetails({
    required this.id,
    required this.userId,
    required this.nin,
    required this.driversLicense,
    required this.votersCard,
    required this.profilePicture,
    required this.internationalPassport,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserKycDetails.fromJson(Map<String, dynamic> json) => UserKycDetails(
    id: json["id"],
    userId: json["user_id"],
    nin: json["nin"],
    driversLicense: json["drivers_license"],
    votersCard: json["voters_card"],
    profilePicture: json["profile_picture"],
    internationalPassport: json["international_passport"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
  };
}
