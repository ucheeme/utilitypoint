// To parse this JSON data, do
//
//     final usersKycStatusResponse = usersKycStatusResponseFromJson(jsonString);

import 'dart:convert';

UsersKycStatusResponse usersKycStatusResponseFromJson(String str) => UsersKycStatusResponse.fromJson(json.decode(str));

String usersKycStatusResponseToJson(UsersKycStatusResponse data) => json.encode(data.toJson());

class UsersKycStatusResponse {
  int verificationStatus;
  dynamic nin;
  dynamic driversLicense;
  dynamic votersCard;
  dynamic profilePicture;
  dynamic internationalPassport;

  UsersKycStatusResponse({
    required this.verificationStatus,
    required this.nin,
    required this.driversLicense,
    required this.votersCard,
    required this.profilePicture,
    required this.internationalPassport,
  });

  factory UsersKycStatusResponse.fromJson(Map<String, dynamic> json) => UsersKycStatusResponse(
    verificationStatus: json["verification_status"],
    nin: json["nin"],
    driversLicense: json["drivers_license"],
    votersCard: json["voters_card"],
    profilePicture: json["profile_picture"],
    internationalPassport: json["international_passport"],
  );

  Map<String, dynamic> toJson() => {
    "verification_status": verificationStatus,
    "nin": nin,
    "drivers_license": driversLicense,
    "voters_card": votersCard,
    "profile_picture": profilePicture,
    "international_passport": internationalPassport,
  };
}
