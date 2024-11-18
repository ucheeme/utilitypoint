// To parse this JSON data, do
//
//     final electricBoughtResponse = electricBoughtResponseFromJson(jsonString);

import 'dart:convert';

ElectricBoughtResponse electricBoughtResponseFromJson(String str) => ElectricBoughtResponse.fromJson(json.decode(str));

String electricBoughtResponseToJson(ElectricBoughtResponse data) => json.encode(data.toJson());

class ElectricBoughtResponse {
  String metreNumber;
  String validationExtraInfo;
  String electricityProductPlanCategoryId;
  String electricityProductPlanId;
  String amount;
  String pin;
  String userId;
  String noOfSlots;
  String walletCategory;
  List<Datum> data;

  ElectricBoughtResponse({
    required this.metreNumber,
    required this.validationExtraInfo,
    required this.electricityProductPlanCategoryId,
    required this.electricityProductPlanId,
    required this.amount,
    required this.pin,
    required this.userId,
    required this.noOfSlots,
    required this.walletCategory,
    required this.data,
  });

  factory ElectricBoughtResponse.fromJson(Map<String, dynamic> json) => ElectricBoughtResponse(
    metreNumber: json["metre_number"],
    validationExtraInfo: json["validation_extra_info"],
    electricityProductPlanCategoryId: json["electricity_product_plan_category_id"],
    electricityProductPlanId: json["electricity_product_plan_id"],
    amount: json["amount"],
    pin: json["pin"],
    userId: json["user_id"],
    noOfSlots: json["no_of_slots"],
    walletCategory: json["wallet_category"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "metre_number": metreNumber,
    "validation_extra_info": validationExtraInfo,
    "electricity_product_plan_category_id": electricityProductPlanCategoryId,
    "electricity_product_plan_id": electricityProductPlanId,
    "amount": amount,
    "pin": pin,
    "user_id": userId,
    "no_of_slots": noOfSlots,
    "wallet_category": walletCategory,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String message;
  String adminMessage;
  int status;

  Datum({
    required this.message,
    required this.adminMessage,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    message: json["message"],
    adminMessage: json["admin_message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "admin_message": adminMessage,
    "status": status,
  };
}
