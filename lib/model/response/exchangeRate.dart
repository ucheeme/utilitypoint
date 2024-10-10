// To parse this JSON data, do
//
//     final fetchCurrenctConversionRate = fetchCurrenctConversionRateFromJson(jsonString);

import 'dart:convert';

FetchCurrencyConversionRate fetchCurrenctConversionRateFromJson(String str) => FetchCurrencyConversionRate.fromJson(json.decode(str));

String fetchCurrenctConversionRateToJson(FetchCurrencyConversionRate data) => json.encode(data.toJson());

class FetchCurrencyConversionRate {
  int id;
  String nairaRate;
  String currency;
  DateTime createdAt;
  DateTime updatedAt;

  FetchCurrencyConversionRate({
    required this.id,
    required this.nairaRate,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FetchCurrencyConversionRate.fromJson(Map<String, dynamic> json) => FetchCurrencyConversionRate(
    id: json["id"],
    nairaRate: json["naira_rate"],
    currency: json["currency"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "naira_rate": nairaRate,
    "currency": currency,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
