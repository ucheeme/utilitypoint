// To parse this JSON data, do
//
//     final setUniqueIdentifierRequest = setUniqueIdentifierRequestFromJson(jsonString);

import 'dart:convert';

import '../../utils/device_util.dart';

SetUniqueIdentifierRequest setUniqueIdentifierRequestFromJson(String str) => SetUniqueIdentifierRequest.fromJson(json.decode(str));

String setUniqueIdentifierRequestToJson(SetUniqueIdentifierRequest data) => json.encode(data.toJson());

class SetUniqueIdentifierRequest {
  String userId;
  String userName;
  String phoneNumber;
  String? idDevice =deviceId;

  SetUniqueIdentifierRequest({
    required this.userId,
    required this.userName,
    required this.phoneNumber,
    this.idDevice
  });

  factory SetUniqueIdentifierRequest.fromJson(Map<String, dynamic> json) => SetUniqueIdentifierRequest(
    userId: json["user_id"],
    userName: json["user_name"],
    phoneNumber: json["phone_number"],
    idDevice: json["device_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "phone_number": phoneNumber,
    "device_id": idDevice,
  };
}
