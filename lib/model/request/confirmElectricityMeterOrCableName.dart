// To parse this JSON data, do
//
//     final confirmMeterOrCableNameRequest = confirmMeterOrCableNameRequestFromJson(jsonString);

import 'dart:convert';

import 'package:utilitypoint/utils/device_util.dart';

ConfirmMeterOrCableNameRequest confirmMeterOrCableNameRequestFromJson(String str) => ConfirmMeterOrCableNameRequest.fromJson(json.decode(str));

String confirmMeterOrCableNameRequestToJson(ConfirmMeterOrCableNameRequest data) => json.encode(data.toJson());

class ConfirmMeterOrCableNameRequest {
  String userId;
  String pin;
  String? smartCardNumber;
  String? metreNumber;
  String productPlanId;
  String? iDevice = deviceId;

  ConfirmMeterOrCableNameRequest({
    required this.userId,
    required this.pin,
     this.smartCardNumber,
     this.metreNumber,
    required this.productPlanId,
    this.iDevice
  });

  factory ConfirmMeterOrCableNameRequest.fromJson(Map<String, dynamic> json) => ConfirmMeterOrCableNameRequest(
    userId: json["user_id"],
    pin: json["pin"],
    smartCardNumber: json["smart_card_number"],
    metreNumber: json["metre_number"],
    productPlanId: json["product_plan_id"],
    iDevice: json["device_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "pin": pin,
    "smart_card_number": smartCardNumber,
    "metre_number": metreNumber,
    "product_plan_id": productPlanId,
    "device_id": iDevice=deviceId
  };
}
