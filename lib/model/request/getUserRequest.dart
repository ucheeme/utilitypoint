// To parse this JSON data, do
//
//     final getUserIdRequest = getUserIdRequestFromJson(jsonString);

import 'dart:convert';

import '../../utils/device_util.dart';

GetUserIdRequest getUserIdRequestFromJson(String str) => GetUserIdRequest.fromJson(json.decode(str));

String getUserIdRequestToJson(GetUserIdRequest data) => json.encode(data.toJson());

class GetUserIdRequest {
  String userId;
  String? idDevice =deviceId;

  GetUserIdRequest({
    required this.userId,
    this.idDevice
  });

  factory GetUserIdRequest.fromJson(Map<String, dynamic> json) => GetUserIdRequest(
    userId: json["user_id"],
    idDevice: json["device_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "device_id": idDevice,
  };
}
