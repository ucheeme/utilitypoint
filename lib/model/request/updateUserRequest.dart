// To parse this JSON data, do
//
//     final updateUserDetailRequest = updateUserDetailRequestFromJson(jsonString);

import 'dart:convert';

UpdateUserDetailRequest updateUserDetailRequestFromJson(String str) => UpdateUserDetailRequest.fromJson(json.decode(str));

String updateUserDetailRequestToJson(UpdateUserDetailRequest data) => json.encode(data.toJson());

class UpdateUserDetailRequest {
  String userId;
  String firstName;
  String lastName;
  String otherNames;
  String userName;
  String phoneNumber;

  UpdateUserDetailRequest({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.otherNames,
    required this.userName,
    required this.phoneNumber,
  });

  factory UpdateUserDetailRequest.fromJson(Map<String, dynamic> json) => UpdateUserDetailRequest(
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    otherNames: json["other_names"],
    userName: json["user_name"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "other_names": otherNames,
    "user_name": userName,
    "phone_number": phoneNumber,
  };
}
