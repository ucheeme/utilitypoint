// To parse this JSON data, do
//
//     final buyAirtimeRequest = buyAirtimeRequestFromJson(jsonString);

import 'dart:convert';

BuyAirtimeDataRequest buyAirtimeRequestFromJson(String str) => BuyAirtimeDataRequest.fromJson(json.decode(str));

String buyAirtimeRequestToJson(BuyAirtimeDataRequest data) => json.encode(data.toJson());

class BuyAirtimeDataRequest {
  String networkId;
  String userId;
  String phoneNumber;
  String productPlanCategoryId;
  String? productPlanId;
  String pin;
  String amount;
  String walletCategory;
  int validatephonenetwork;

  BuyAirtimeDataRequest({
    required this.networkId,
    required this.userId,
    required this.phoneNumber,
    required this.productPlanCategoryId,
    required this.pin,
    required this.amount,
    this.productPlanId,
    required this.walletCategory,
    required this.validatephonenetwork,
  });

  factory BuyAirtimeDataRequest.fromJson(Map<String, dynamic> json) => BuyAirtimeDataRequest(
    networkId: json["network_id"],
    userId: json["user_id"],
    phoneNumber: json["phone_number"],
    productPlanCategoryId: json["product_plan_category_id"],
    productPlanId: json["product_plan_id"],
    pin: json["pin"],
    amount: json["amount"],
    walletCategory: json["wallet_category"],
    validatephonenetwork: json["validatephonenetwork"],
  );

  Map<String, dynamic> toJson() => {
    "network_id": networkId,
    "user_id": userId,
    "phone_number": phoneNumber,
    "product_plan_id":productPlanId,
    "product_plan_category_id": productPlanCategoryId,
    "pin": pin,
    "amount": amount,
    "wallet_category": walletCategory,
    "validatephonenetwork": validatephonenetwork,
  };
}
