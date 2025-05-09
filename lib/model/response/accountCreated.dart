// To parse this JSON data, do
//
//     final accountCreated = accountCreatedFromJson(jsonString);

import 'dart:convert';

AccountCreatedResponse accountCreatedFromJson(String str) => AccountCreatedResponse.fromJson(json.decode(str));

String accountCreatedToJson(AccountCreatedResponse data) => json.encode(data.toJson());

class AccountCreatedResponse {
  String id;
  dynamic firstName;
  dynamic lastName;
  dynamic userName;
  String email;
  dynamic dollarWallet;
  dynamic nairaWallet;
  DateTime createdAt;
  DateTime updatedAt;
  String token;

  AccountCreatedResponse({
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

  factory AccountCreatedResponse.fromJson(Map<String, dynamic> json) => AccountCreatedResponse(
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
