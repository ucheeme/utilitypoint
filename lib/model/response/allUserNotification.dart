// To parse this JSON data, do
//
//     final allUserNotification = allUserNotificationFromJson(jsonString);

import 'dart:convert';


AllUserNotification allUserNotificationFromJson(String str) => AllUserNotification.fromJson(json.decode(str));

String allUserNotificationToJson(AllUserNotification data) => json.encode(data.toJson());

class AllUserNotification {
  int? unreadCount;
  int? readCount;
  List<NotificationList>? data;

  AllUserNotification({
     this.unreadCount,
     this.readCount,
     this.data,
  });

  factory AllUserNotification.fromJson(Map<String, dynamic> json) => AllUserNotification(
    unreadCount: json["unread_count"],
    readCount: json["read_count"],
    data: json["data"]==null?[]: List<NotificationList>.from(json["data"].map((x) => NotificationList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "unread_count": unreadCount,
    "read_count": readCount,
    "data":data==null?[]: List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NotificationList {
  String id;
  String userIds;
  String title;
  String content;
  int readStatus;
  dynamic imagePath;
  DateTime createdAt;
  DateTime updatedAt;

  NotificationList({
    required this.id,
    required this.userIds,
    required this.title,
    required this.content,
    required this.readStatus,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
    id: json["id"],
    userIds:json["user_ids"]??"",
    title: json["title"]??"",
    content: json["content"],
    readStatus: json["read_status"],
    imagePath: json["image_path"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_ids": userIds,
    "title": title,
    "content": content,
    "read_status": readStatus,
    "image_path": imagePath,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}





