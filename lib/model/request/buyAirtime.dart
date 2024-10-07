// To parse this JSON data, do
//
//     final buyAirtimeRequest = buyAirtimeRequestFromJson(jsonString);

import 'dart:convert';

BuyAirtimeRequest buyAirtimeRequestFromJson(String str) => BuyAirtimeRequest.fromJson(json.decode(str));

String buyAirtimeRequestToJson(BuyAirtimeRequest data) => json.encode(data.toJson());

class BuyAirtimeRequest {
  String networkId;
  String userId;
  String phoneNumber;
  String productPlanCategoryId;
  String pin;
  String amount;
  String walletCategory;
  int validatephonenetwork;

  BuyAirtimeRequest({
    required this.networkId,
    required this.userId,
    required this.phoneNumber,
    required this.productPlanCategoryId,
    required this.pin,
    required this.amount,
    required this.walletCategory,
    required this.validatephonenetwork,
  });

  factory BuyAirtimeRequest.fromJson(Map<String, dynamic> json) => BuyAirtimeRequest(
    networkId: json["network_id"],
    userId: json["user_id"],
    phoneNumber: json["phone_number"],
    productPlanCategoryId: json["product_plan_category_id"],
    pin: json["pin"],
    amount: json["amount"],
    walletCategory: json["wallet_category"],
    validatephonenetwork: json["validatephonenetwork"],
  );

  Map<String, dynamic> toJson() => {
    "network_id": networkId,
    "user_id": userId,
    "phone_number": phoneNumber,
    "product_plan_category_id": productPlanCategoryId,
    "pin": pin,
    "amount": amount,
    "wallet_category": walletCategory,
    "validatephonenetwork": validatephonenetwork,
  };
}
