// To parse this JSON data, do
//
//     final logOutRequest = logOutRequestFromJson(jsonString);

import 'dart:convert';

LogOutRequest logOutRequestFromJson(String str) => LogOutRequest.fromJson(json.decode(str));

String logOutRequestToJson(LogOutRequest data) => json.encode(data.toJson());

class LogOutRequest {
  String userId;

  LogOutRequest({
    required this.userId,
  });

  factory LogOutRequest.fromJson(Map<String, dynamic> json) => LogOutRequest(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}
