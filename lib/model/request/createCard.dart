// To parse this JSON data, do
//
//     final createCardRequest = createCardRequestFromJson(jsonString);

import 'dart:convert';

import 'package:utilitypoint/utils/device_util.dart';

CreateCardRequest createCardRequestFromJson(String str) => CreateCardRequest.fromJson(json.decode(str));

String createCardRequestToJson(CreateCardRequest data) => json.encode(data.toJson());

class CreateCardRequest {
  String userId;
  String currency;
  String brand;
  String amount;
  String cardCreationCharge;
  String cardType;
  String pin;
  String? idDevice=deviceId;

  CreateCardRequest({
    required this.userId,
    required this.currency,
    required this.brand,
    required this.amount,
    required this.cardCreationCharge,
    required this.cardType,
    required this.pin,
    this.idDevice
  });

  factory CreateCardRequest.fromJson(Map<String, dynamic> json) => CreateCardRequest(
    userId: json["user_id"],
    currency: json["currency"],
    brand: json["brand"],
    amount: json["amount"],
    cardCreationCharge: json["card_creation_charge"],
    cardType: json["card_type"],
    pin: json["pin"],
    idDevice: json["device_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "currency": currency,
    "brand": brand,
    "amount": amount,
    "card_creation_charge":cardCreationCharge,
    "card_type": cardType,
    "pin":pin,
    "device_id":idDevice=deviceId
  };
}
