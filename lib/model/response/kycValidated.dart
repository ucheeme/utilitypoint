// To parse this JSON data, do
//
//     final kycVerificationResponse = kycVerificationResponseFromJson(jsonString);

import 'dart:convert';

KycVerificationResponse kycVerificationResponseFromJson(String str) => KycVerificationResponse.fromJson(json.decode(str));

String kycVerificationResponseToJson(KycVerificationResponse data) => json.encode(data.toJson());

class KycVerificationResponse {
  String imageUrl;
  String documentCategory;

  KycVerificationResponse({
    required this.imageUrl,
    required this.documentCategory,
  });

  factory KycVerificationResponse.fromJson(Map<String, dynamic> json) => KycVerificationResponse(
    imageUrl: json["image_url"],
    documentCategory: json["document_category"],
  );

  Map<String, dynamic> toJson() => {
    "image_url": imageUrl,
    "document_category": documentCategory,
  };
}
