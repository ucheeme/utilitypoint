// To parse this JSON data, do
//
//     final electricBoughtResponse = electricBoughtResponseFromJson(jsonString);

import 'dart:convert';

ElectricBoughtResponse electricBoughtResponseFromJson(String str) => ElectricBoughtResponse.fromJson(json.decode(str));

String electricBoughtResponseToJson(ElectricBoughtResponse data) => json.encode(data.toJson());

class ElectricBoughtResponse {
  The1 the1;

  ElectricBoughtResponse({
    required this.the1,
  });

  factory ElectricBoughtResponse.fromJson(Map<String, dynamic> json) => ElectricBoughtResponse(
    the1: The1.fromJson(json["1"]),
  );

  Map<String, dynamic> toJson() => {
    "1": the1.toJson(),
  };
}

class The1 {
  String message;
  String adminMessage;
  int status;

  The1({
    required this.message,
    required this.adminMessage,
    required this.status,
  });

  factory The1.fromJson(Map<String, dynamic> json) => The1(
    message: json["message"],
    adminMessage: json["admin_message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "admin_message": adminMessage,
    "status": status,
  };
}
