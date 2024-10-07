// To parse this JSON data, do
//
//     final buyElectricityRequest = buyElectricityRequestFromJson(jsonString);

import 'dart:convert';

BuyElectricityRequest buyElectricityRequestFromJson(String str) => BuyElectricityRequest.fromJson(json.decode(str));

String buyElectricityRequestToJson(BuyElectricityRequest data) => json.encode(data.toJson());

class BuyElectricityRequest {
  String userId;
  String metreNumber;
  String validationExtraInfo;
  String electricityProductPlanCategoryId;
  String electricityProductPlanId;
  String amount;
  String pin;

  BuyElectricityRequest({
    required this.userId,
    required this.metreNumber,
    required this.validationExtraInfo,
    required this.electricityProductPlanCategoryId,
    required this.electricityProductPlanId,
    required this.amount,
    required this.pin,
  });

  factory BuyElectricityRequest.fromJson(Map<String, dynamic> json) => BuyElectricityRequest(
    userId: json["user_id"],
    metreNumber: json["metre_number"],
    validationExtraInfo: json["validation_extra_info"],
    electricityProductPlanCategoryId: json["electricity_product_plan_category_id"],
    electricityProductPlanId: json["electricity_product_plan_id"],
    amount: json["amount"],
    pin: json["pin"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "metre_number": metreNumber,
    "validation_extra_info": validationExtraInfo,
    "electricity_product_plan_category_id": electricityProductPlanCategoryId,
    "electricity_product_plan_id": electricityProductPlanId,
    "amount": amount,
    "pin": pin,
  };
}
