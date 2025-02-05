// To parse this JSON data, do
//
//     final generateBankAccountRequest = generateBankAccountRequestFromJson(jsonString);

import 'dart:convert';

import '../../utils/device_util.dart';

GenerateBankAccountRequest generateBankAccountRequestFromJson(String str) => GenerateBankAccountRequest.fromJson(json.decode(str));

String generateBankAccountRequestToJson(GenerateBankAccountRequest data) => json.encode(data.toJson());

class GenerateBankAccountRequest {
  String userId;
  String bankCode;
  String pin;
  String fundingOptionId;
  String? idDevice=deviceId;

  GenerateBankAccountRequest({
    required this.userId,
    required this.bankCode,
    required this.pin,
    required this.fundingOptionId,
    this.idDevice
  });

  factory GenerateBankAccountRequest.fromJson(Map<String, dynamic> json) => GenerateBankAccountRequest(
    userId: json["user_id"],
    bankCode: json["bank_code"],
    pin: json["pin"],
    fundingOptionId: json["funding_option_id"],
    idDevice: json["device_id"]
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "bank_code": bankCode,
    "pin": pin,
    "funding_option_id": fundingOptionId,
    "device_id":idDevice=deviceId
  };
}
