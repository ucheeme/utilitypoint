// To parse this JSON data, do
//
//     final buyCableSubscriptionRequest = buyCableSubscriptionRequestFromJson(jsonString);

import 'dart:convert';

import '../../utils/device_util.dart';

BuyCableSubscriptionRequest buyCableSubscriptionRequestFromJson(String str) => BuyCableSubscriptionRequest.fromJson(json.decode(str));

String buyCableSubscriptionRequestToJson(BuyCableSubscriptionRequest data) => json.encode(data.toJson());

class BuyCableSubscriptionRequest {
  String userId;
  String smartCardNumber;
  String validationCustomerName;
  String cableProductPlanCategoryId;
  String cableProductPlanId;
  String pin;
  String? idDevice=deviceId;

  BuyCableSubscriptionRequest({
    required this.userId,
    required this.smartCardNumber,
    required this.validationCustomerName,
    required this.cableProductPlanCategoryId,
    required this.cableProductPlanId,
    required this.pin,
    this.idDevice
  });

  factory BuyCableSubscriptionRequest.fromJson(Map<String, dynamic> json) => BuyCableSubscriptionRequest(
    userId: json["user_id"],
    smartCardNumber: json["smart_card_number"],
    validationCustomerName: json["validation_customer_name"],
    cableProductPlanCategoryId: json["cable_product_plan_category_id"],
    cableProductPlanId: json["cable_product_plan_id"],
    pin: json["pin"],
    idDevice: json["device_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "smart_card_number": smartCardNumber,
    "validation_customer_name": validationCustomerName,
    "cable_product_plan_category_id": cableProductPlanCategoryId,
    "cable_product_plan_id": cableProductPlanId,
    "pin": pin,
    "device_id": idDevice=deviceId,
  };
}
