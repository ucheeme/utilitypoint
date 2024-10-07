// To parse this JSON data, do
//
//     final getUserIdRequest = getUserIdRequestFromJson(jsonString);

import 'dart:convert';

GetUserIdRequest getUserIdRequestFromJson(String str) => GetUserIdRequest.fromJson(json.decode(str));

String getUserIdRequestToJson(GetUserIdRequest data) => json.encode(data.toJson());

class GetUserIdRequest {
  String userId;

  GetUserIdRequest({
    required this.userId,
  });

  factory GetUserIdRequest.fromJson(Map<String, dynamic> json) => GetUserIdRequest(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}
