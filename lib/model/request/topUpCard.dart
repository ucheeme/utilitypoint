// To parse this JSON data, do
//
//     final topUpCardRequest = topUpCardRequestFromJson(jsonString);

import 'dart:convert';

TopUpCardRequest topUpCardRequestFromJson(String str) => TopUpCardRequest.fromJson(json.decode(str));

String topUpCardRequestToJson(TopUpCardRequest data) => json.encode(data.toJson());

class TopUpCardRequest {
  String userId;
  String cardId;
  double amount;

  TopUpCardRequest({
    required this.userId,
    required this.cardId,
    required this.amount,
  });

  factory TopUpCardRequest.fromJson(Map<String, dynamic> json) => TopUpCardRequest(
    userId: json["user_id"],
    cardId: json["card_id"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "card_id": cardId,
    "amount": amount,
  };
}
