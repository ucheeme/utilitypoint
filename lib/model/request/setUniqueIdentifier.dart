// To parse this JSON data, do
//
//     final setUniqueIdentifierRequest = setUniqueIdentifierRequestFromJson(jsonString);

import 'dart:convert';

SetUniqueIdentifierRequest setUniqueIdentifierRequestFromJson(String str) => SetUniqueIdentifierRequest.fromJson(json.decode(str));

String setUniqueIdentifierRequestToJson(SetUniqueIdentifierRequest data) => json.encode(data.toJson());

class SetUniqueIdentifierRequest {
  String userId;
  String userName;
  String phoneNumber;

  SetUniqueIdentifierRequest({
    required this.userId,
    required this.userName,
    required this.phoneNumber,
  });

  factory SetUniqueIdentifierRequest.fromJson(Map<String, dynamic> json) => SetUniqueIdentifierRequest(
    userId: json["user_id"],
    userName: json["user_name"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "phone_number": phoneNumber,
  };
}
