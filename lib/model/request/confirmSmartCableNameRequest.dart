// To parse this JSON data, do
//
//     final confirmSmartCableNameRequest = confirmSmartCableNameRequestFromJson(jsonString);

import 'dart:convert';

ConfirmSmartCableNameRequest confirmSmartCableNameRequestFromJson(String str) => ConfirmSmartCableNameRequest.fromJson(json.decode(str));

String confirmSmartCableNameRequestToJson(ConfirmSmartCableNameRequest data) => json.encode(data.toJson());

class ConfirmSmartCableNameRequest {
  String userId;
  String pin;
  String smartCardNumber;
  String productPlanId;

  ConfirmSmartCableNameRequest({
    required this.userId,
    required this.pin,
    required this.smartCardNumber,
    required this.productPlanId,
  });

  factory ConfirmSmartCableNameRequest.fromJson(Map<String, dynamic> json) => ConfirmSmartCableNameRequest(
    userId: json["user_id"],
    pin: json["pin"],
    smartCardNumber: json["smart_card_number"],
    productPlanId: json["product_plan_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "pin": pin,
    "smart_card_number": smartCardNumber,
    "product_plan_id": productPlanId,
  };
}
