// To parse this JSON data, do
//
//     final markAsReadUnReadRequest = markAsReadUnReadRequestFromJson(jsonString);

import 'dart:convert';

MarkAsReadUnReadRequest markAsReadUnReadRequestFromJson(String str) => MarkAsReadUnReadRequest.fromJson(json.decode(str));

String markAsReadUnReadRequestToJson(MarkAsReadUnReadRequest data) => json.encode(data.toJson());

class MarkAsReadUnReadRequest {
  String userId;
  String userNotificationId;

  MarkAsReadUnReadRequest({
    required this.userId,
    required this.userNotificationId,
  });

  factory MarkAsReadUnReadRequest.fromJson(Map<String, dynamic> json) => MarkAsReadUnReadRequest(
    userId: json["user_id"],
    userNotificationId: json["user_notification_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_notification_id": userNotificationId,
  };
}
