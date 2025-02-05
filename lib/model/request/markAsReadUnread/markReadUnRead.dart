// To parse this JSON data, do
//
//     final markAsReadUnReadRequest = markAsReadUnReadRequestFromJson(jsonString);

import 'dart:convert';

import '../../../utils/device_util.dart';

MarkAsReadUnReadRequest markAsReadUnReadRequestFromJson(String str) => MarkAsReadUnReadRequest.fromJson(json.decode(str));

String markAsReadUnReadRequestToJson(MarkAsReadUnReadRequest data) => json.encode(data.toJson());

class MarkAsReadUnReadRequest {
  String userId;
  String userNotificationId;
  String? idDevice=deviceId;

  MarkAsReadUnReadRequest({
    required this.userId,
    required this.userNotificationId,
    this.idDevice
  });

  factory MarkAsReadUnReadRequest.fromJson(Map<String, dynamic> json) => MarkAsReadUnReadRequest(
    userId: json["user_id"],
    userNotificationId: json["user_notification_id"],
    idDevice: json["device_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_notification_id": userNotificationId,
    "device_id": idDevice=deviceId,
  };
}
