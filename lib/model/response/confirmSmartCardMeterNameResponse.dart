// To parse this JSON data, do
//
//     final confirmSmartCardNameResponse = confirmSmartCardNameResponseFromJson(jsonString);

import 'dart:convert';

ConfirmSmartCardMeterNameResponse confirmSmartCardNameResponseFromJson(String str) => ConfirmSmartCardMeterNameResponse.fromJson(json.decode(str));

String confirmSmartCardNameResponseToJson(ConfirmSmartCardMeterNameResponse data) => json.encode(data.toJson());

class ConfirmSmartCardMeterNameResponse {
  String name;
  String address;

  ConfirmSmartCardMeterNameResponse({
    required this.name,
    required this.address,
  });

  factory ConfirmSmartCardMeterNameResponse.fromJson(Map<String, dynamic> json) => ConfirmSmartCardMeterNameResponse(
    name: json["name"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
  };
}
