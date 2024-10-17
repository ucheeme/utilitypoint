// To parse this JSON data, do
//
//     final dataPlanResponse = dataPlanResponseFromJson(jsonString);

import 'dart:convert';

List<ProductPlanItemResponse> dataPlanResponseFromJson(String str) => List<ProductPlanItemResponse>.from(json.decode(str).map((x) => ProductPlanItemResponse.fromJson(x)));

String dataPlanResponseToJson(List<ProductPlanItemResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductPlanItemResponse {
  String productPlanId;
  String amount;
  int sellingPrice;
  String productPlanName;
  String dataSizeInMb;
  String validityInDays;
  String automationId;

  ProductPlanItemResponse({
    required this.productPlanId,
    required this.amount,
    required this.sellingPrice,
    required this.productPlanName,
    required this.dataSizeInMb,
    required this.validityInDays,
    required this.automationId,
  });

  factory ProductPlanItemResponse.fromJson(Map<String, dynamic> json) => ProductPlanItemResponse(
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
