// To parse this JSON data, do
//
//     final convertNairaToDollar = convertNairaToDollarFromJson(jsonString);

import 'dart:convert';

ConvertNairaToDollarRequest convertNairaToDollarFromJson(String str) => ConvertNairaToDollarRequest.fromJson(json.decode(str));

String convertNairaToDollarToJson(ConvertNairaToDollarRequest data) => json.encode(data.toJson());

class ConvertNairaToDollarRequest {
  String userId;
  String amountInDollar;
  String totalChargeFee;
  String pin;

  ConvertNairaToDollarRequest({
    required this.userId,
    required this.amountInDollar,
    required this.totalChargeFee,
    required this.pin,
  });

  factory ConvertNairaToDollarRequest.fromJson(Map<String, dynamic> json) => ConvertNairaToDollarRequest(
    userId: json["user_id"],
    amountInDollar: json["amount_in_dollar"],
    totalChargeFee: json["total_charge_fee"],
    pin: json["pin"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "amount_in_dollar": amountInDollar,
    "total_charge_fee":totalChargeFee,
    "pin": pin,
  };
}
