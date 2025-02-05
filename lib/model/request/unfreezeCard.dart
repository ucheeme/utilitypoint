// To parse this JSON data, do
//
//     final unfreezeCard = unfreezeCardFromJson(jsonString);

import 'dart:convert';

import '../../utils/device_util.dart';

FreezeUnfreezeCard unfreezeCardFromJson(String str) => FreezeUnfreezeCard.fromJson(json.decode(str));

String unfreezeCardToJson(FreezeUnfreezeCard data) => json.encode(data.toJson());

class FreezeUnfreezeCard {
  String userId;
  String cardId;
  String pin;
  String? idDevice = deviceId;

  FreezeUnfreezeCard({
    required this.userId,
    required this.cardId,
    required this.pin,
    this.idDevice
  });

  factory FreezeUnfreezeCard.fromJson(Map<String, dynamic> json) => FreezeUnfreezeCard(
    userId: json["user_id"],
    cardId: json["card_id"],
    pin: json["pin"],
    idDevice: json["device_id"]
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "card_id": cardId,
    "pin":pin,
    "device_id": idDevice=deviceId
  };
}
