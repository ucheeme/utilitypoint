// To parse this JSON data, do
//
//     final getProductRequest = getProductRequestFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

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
  String? pin;
  String? bvn;
  String? documentCategory;
  File? documentFile;
  GetProductRequest({
     this.networkId,
     this.planCategoryId,
     this.amount,
     this.productSlug,
     this.userId,
     this.dateFrom,
     this.dateTo,
    this.cardId,
    this.documentCategory,
    this.startDate,
    this.endDate,
    this.pageSize,
    this.page,
    this.pin,
    this.bvn,
    this.documentFile
  });

  factory GetProductRequest.fromJson(Map<String, dynamic> json) => GetProductRequest(
    networkId: json["network_id"],
    bvn: json["bvn"],
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
    page: json["page"],
    pin: json["pin"],
    documentFile: json["document_file"],
      documentCategory:json["document_category"]
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
    "page":page,
    "pin":pin,
    "bvn":bvn,
    "document_file":documentFile?.path,
    "document_category":documentCategory
  };
}
