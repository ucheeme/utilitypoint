// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  String id;
  String slug;
  String productName;
  String visibility;
  String activeStatus;
  String firstDownlineCreditingFeature;
  String setFirstDownlineCreditingFlatRate;
  String setFirstDownlineCreditingPercentageRate;
  String setFirstDownlineCreditingCap;
  DateTime createdAt;
  DateTime updatedAt;

  Products({
    required this.id,
    required this.slug,
    required this.productName,
    required this.visibility,
    required this.activeStatus,
    required this.firstDownlineCreditingFeature,
    required this.setFirstDownlineCreditingFlatRate,
    required this.setFirstDownlineCreditingPercentageRate,
    required this.setFirstDownlineCreditingCap,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json["id"],
    slug: json["slug"],
    productName: json["product_name"],
    visibility: json["visibility"],
    activeStatus: json["active_status"],
    firstDownlineCreditingFeature: json["first_downline_crediting_feature"],
    setFirstDownlineCreditingFlatRate: json["set_first_downline_crediting_flat_rate"],
    setFirstDownlineCreditingPercentageRate: json["set_first_downline_crediting_percentage_rate"],
    setFirstDownlineCreditingCap: json["set_first_downline_crediting_cap"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "product_name": productName,
    "visibility": visibility,
    "active_status": activeStatus,
    "first_downline_crediting_feature": firstDownlineCreditingFeature,
    "set_first_downline_crediting_flat_rate": setFirstDownlineCreditingFlatRate,
    "set_first_downline_crediting_percentage_rate": setFirstDownlineCreditingPercentageRate,
    "set_first_downline_crediting_cap": setFirstDownlineCreditingCap,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
