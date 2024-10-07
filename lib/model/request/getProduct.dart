// To parse this JSON data, do
//
//     final getProductRequest = getProductRequestFromJson(jsonString);

import 'dart:convert';

GetProductRequest getProductRequestFromJson(String str) => GetProductRequest.fromJson(json.decode(str));

String getProductRequestToJson(GetProductRequest data) => json.encode(data.toJson());

class GetProductRequest {
  String? networkId;
  String? planCategoryId;
  String? amount;
  String? productSlug;
  String? userId;
  String? dateFrom;
  String? dateTo;
  String? cardId;
  String? startDate;
  String? endDate;
  String? pageSize;
  String? page;

  GetProductRequest({
     this.networkId,
     this.planCategoryId,
     this.amount,
     this.productSlug,
     this.userId,
     this.dateFrom,
     this.dateTo,
    this.cardId,
    this.startDate,
    this.endDate,
    this.pageSize,
    this.page
  });

  factory GetProductRequest.fromJson(Map<String, dynamic> json) => GetProductRequest(
    networkId: json["network_id"],
    planCategoryId: json["plan_category_id"],
    amount: json["amount"],
    productSlug: json["product_slug"],
    userId: json["user_id"],
    dateFrom: json["date_from"],
    dateTo: json["date_to"],
    cardId: json["card_id"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    pageSize: json["page_size"],
    page: json["page"]
  );

  Map<String, dynamic> toJson() => {
    "network_id": networkId,
    "plan_category_id": planCategoryId,
    "amount": amount,
    "product_slug": productSlug,
    "user_id": userId,
    "date_from": dateFrom,
    "date_to": dateTo,
    "card_id": cardId,
    "start_date":startDate,
    "end_date":endDate,
    "page_size":pageSize,
    "page":page
  };
}
