// To parse this JSON data, do
//
//     final userInfoUpdated = userInfoUpdatedFromJson(jsonString);

import 'dart:convert';

UserInfoUpdated userInfoUpdatedFromJson(String str) => UserInfoUpdated.fromJson(json.decode(str));

String userInfoUpdatedToJson(UserInfoUpdated data) => json.encode(data.toJson());

class UserInfoUpdated {
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

  UserInfoUpdated({
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

  factory UserInfoUpdated.fromJson(Map<String, dynamic> json) => UserInfoUpdated(
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
