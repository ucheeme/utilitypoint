// To parse this JSON data, do
//
//     final dataPlanResponse = dataPlanResponseFromJson(jsonString);

import 'dart:convert';

List<DataPlanResponse> dataPlanResponseFromJson(String str) => List<DataPlanResponse>.from(json.decode(str).map((x) => DataPlanResponse.fromJson(x)));

String dataPlanResponseToJson(List<DataPlanResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataPlanResponse {
  String productPlanId;
  String amount;
  String sellingPrice;
  String productPlanName;
  String dataSizeInMb;
  String validityInDays;
  String automationId;

  DataPlanResponse({
    required this.productPlanId,
    required this.amount,
    required this.sellingPrice,
    required this.productPlanName,
    required this.dataSizeInMb,
    required this.validityInDays,
    required this.automationId,
  });

  factory DataPlanResponse.fromJson(Map<String, dynamic> json) => DataPlanResponse(
    productPlanId: json["product_plan_id"],
    amount: json["amount"],
    sellingPrice: json["selling_price"],
    productPlanName: json["product_plan_name"],
    dataSizeInMb: json["data_size_in_mb"],
    validityInDays: json["validity_in_days"],
    automationId: json["automation_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_plan_id": productPlanId,
    "amount": amount,
    "selling_price": sellingPrice,
    "product_plan_name": productPlanName,
    "data_size_in_mb": dataSizeInMb,
    "validity_in_days": validityInDays,
    "automation_id": automationId,
  };
}
