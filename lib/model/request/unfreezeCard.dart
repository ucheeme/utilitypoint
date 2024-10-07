// To parse this JSON data, do
//
//     final unfreezeCard = unfreezeCardFromJson(jsonString);

import 'dart:convert';

FreezeUnfreezeCard unfreezeCardFromJson(String str) => FreezeUnfreezeCard.fromJson(json.decode(str));

String unfreezeCardToJson(FreezeUnfreezeCard data) => json.encode(data.toJson());

class FreezeUnfreezeCard {
  String userId;
  String cardId;

  FreezeUnfreezeCard({
    required this.userId,
    required this.cardId,
  });

  factory FreezeUnfreezeCard.fromJson(Map<String, dynamic> json) => FreezeUnfreezeCard(
    userId: json["user_id"],
    cardId: json["card_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "card_id": cardId,
  };
}
