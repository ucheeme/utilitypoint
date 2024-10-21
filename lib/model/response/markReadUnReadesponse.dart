// To parse this JSON data, do
//
//     final MarkAsReadUnReadResponse = MarkAsReadUnReadResponseFromJson(jsonString);

import 'dart:convert';

MarkAsReadUnReadResponse markAsReadUnReadResponseFromJson(String str) => MarkAsReadUnReadResponse.fromJson(json.decode(str));

String markAsReadUnReadResponseToJson(MarkAsReadUnReadResponse data) => json.encode(data.toJson());

class MarkAsReadUnReadResponse {
  String userId;
  String userNotificationId;

  MarkAsReadUnReadResponse({
    required this.userId,
    required this.userNotificationId,
  });

  factory MarkAsReadUnReadResponse.fromJson(Map<String, dynamic> json) => MarkAsReadUnReadResponse(
    userId: json["user_id"],
    userNotificationId: json["user_notification_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_notification_id": userNotificationId,
  };
}
