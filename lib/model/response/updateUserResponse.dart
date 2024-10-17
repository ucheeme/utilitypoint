// To parse this JSON data, do
//
//     final updateUserDetailResponse = updateUserDetailResponseFromJson(jsonString);

import 'dart:convert';

UpdateUserDetailResponse updateUserDetailResponseFromJson(String str) => UpdateUserDetailResponse.fromJson(json.decode(str));

String updateUserDetailResponseToJson(UpdateUserDetailResponse data) => json.encode(data.toJson());

class UpdateUserDetailResponse {
  String id;
  String firstName;
  String lastName;
  String userName;
  String email;
  String dollarWallet;
  String nairaWallet;
  DateTime createdAt;
  DateTime updatedAt;
  String token;

  UpdateUserDetailResponse({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.dollarWallet,
    required this.nairaWallet,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
  });

  factory UpdateUserDetailResponse.fromJson(Map<String, dynamic> json) => UpdateUserDetailResponse(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    userName: json["user_name"],
    email: json["email"],
    dollarWallet: json["dollar_wallet"],
    nairaWallet: json["naira_wallet"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "user_name": userName,
    "email": email,
    "dollar_wallet": dollarWallet,
    "naira_wallet": nairaWallet,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "token": token,
  };
}
