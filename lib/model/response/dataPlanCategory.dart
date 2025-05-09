// To parse this JSON data, do
//
//     final dataPlanCategory = dataPlanCategoryFromJson(jsonString);

import 'dart:convert';

List<ProductPlanCategoryItem> dataPlanCategoryFromJson(String str) => List<ProductPlanCategoryItem>.from(json.decode(str).map((x) => ProductPlanCategoryItem.fromJson(x)));

String dataPlanCategoryToJson(List<ProductPlanCategoryItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductPlanCategoryItem {
  String id;
  String productPlanCategoryName;
  String automationId;
  String productId;
  bool isHotSales;
  String visibility;
  String networkId;
  DateTime createdAt;
  DateTime updatedAt;

  ProductPlanCategoryItem({
    required this.id,
    required this.productPlanCategoryName,
    required this.automationId,
    required this.productId,
    required this.isHotSales,
    required this.visibility,
    required this.networkId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductPlanCategoryItem.fromJson(Map<String, dynamic> json) => ProductPlanCategoryItem(
    id: json["id"],
    productPlanCategoryName: json["product_plan_category_name"],
    automationId: json["automation_id"],
    productId: json["product_id"],
    isHotSales: json["is_hot_sales"],
    visibility: json["visibility"],
    networkId: json["network_id"] ?? "",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_plan_category_name": productPlanCategoryName,
    "automation_id": automationId,
    "product_id": productId,
    "is_hot_sales": isHotSales,
    "visibility": visibility,
    "network_id": networkId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
