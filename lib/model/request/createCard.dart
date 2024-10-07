// To parse this JSON data, do
//
//     final createCardRequest = createCardRequestFromJson(jsonString);

import 'dart:convert';

CreateCardRequest createCardRequestFromJson(String str) => CreateCardRequest.fromJson(json.decode(str));

String createCardRequestToJson(CreateCardRequest data) => json.encode(data.toJson());

class CreateCardRequest {
  String userId;
  String currency;
  String brand;
  String amount;
  String cardType;

  CreateCardRequest({
    required this.userId,
    required this.currency,
    required this.brand,
    required this.amount,
    required this.cardType,
  });

  factory CreateCardRequest.fromJson(Map<String, dynamic> json) => CreateCardRequest(
    userId: json["user_id"],
    currency: json["currency"],
    brand: json["brand"],
    amount: json["amount"],
    cardType: json["card_type"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "currency": currency,
    "brand": brand,
    "amount": amount,
    "card_type": cardType,
  };
}
