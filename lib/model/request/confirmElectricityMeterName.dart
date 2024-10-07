// To parse this JSON data, do
//
//     final confirmElectricityMeterNameRequest = confirmElectricityMeterNameRequestFromJson(jsonString);

import 'dart:convert';

ConfirmElectricityMeterNameRequest confirmElectricityMeterNameRequestFromJson(String str) => ConfirmElectricityMeterNameRequest.fromJson(json.decode(str));

String confirmElectricityMeterNameRequestToJson(ConfirmElectricityMeterNameRequest data) => json.encode(data.toJson());

class ConfirmElectricityMeterNameRequest {
  String userId;
  String pin;
  String metreNumber;
  String productPlanId;

  ConfirmElectricityMeterNameRequest({
    required this.userId,
    required this.pin,
    required this.metreNumber,
    required this.productPlanId,
  });

  factory ConfirmElectricityMeterNameRequest.fromJson(Map<String, dynamic> json) => ConfirmElectricityMeterNameRequest(
    userId: json["user_id"],
    pin: json["pin"],
    metreNumber: json["metre_number"],
    productPlanId: json["product_plan_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "pin": pin,
    "metre_number": metreNumber,
    "product_plan_id": productPlanId,
  };
}
