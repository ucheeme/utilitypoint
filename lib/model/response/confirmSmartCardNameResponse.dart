// To parse this JSON data, do
//
//     final confirmSmartCardNameResponse = confirmSmartCardNameResponseFromJson(jsonString);

import 'dart:convert';

ConfirmSmartCardNameResponse confirmSmartCardNameResponseFromJson(String str) => ConfirmSmartCardNameResponse.fromJson(json.decode(str));

String confirmSmartCardNameResponseToJson(ConfirmSmartCardNameResponse data) => json.encode(data.toJson());

class ConfirmSmartCardNameResponse {
  String name;
  String address;

  ConfirmSmartCardNameResponse({
    required this.name,
    required this.address,
  });

  factory ConfirmSmartCardNameResponse.fromJson(Map<String, dynamic> json) => ConfirmSmartCardNameResponse(
    name: json["name"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
  };
}
