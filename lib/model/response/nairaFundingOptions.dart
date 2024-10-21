// To parse this JSON data, do
//
//     final nairaFundingOptions = nairaFundingOptionsFromJson(jsonString);

import 'dart:convert';

List<NairaFundingOptions> nairaFundingOptionsFromJson(String str) => List<NairaFundingOptions>.from(json.decode(str).map((x) => NairaFundingOptions.fromJson(x)));

String nairaFundingOptionsToJson(List<NairaFundingOptions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NairaFundingOptions {
  String id;
  String isCurrentOption;
  String fundingOptionName;
  String slug;
  String apiPublicKey;
  String apiSecretKey;
  String activationStatus;
  DateTime createdAt;
  DateTime updatedAt;
  List<BankCode> bankCodes;

  NairaFundingOptions({
    required this.id,
    required this.isCurrentOption,
    required this.fundingOptionName,
    required this.slug,
    required this.apiPublicKey,
    required this.apiSecretKey,
    required this.activationStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.bankCodes,
  });

  factory NairaFundingOptions.fromJson(Map<String, dynamic> json) => NairaFundingOptions(
    id: json["id"],
    isCurrentOption: json["is_current_option"],
    fundingOptionName: json["funding_option_name"],
    slug: json["slug"],
    apiPublicKey: json["api_public_key"],
    apiSecretKey: json["api_secret_key"],
    activationStatus: json["activation_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    bankCodes: List<BankCode>.from(json["bank_codes"].map((x) => BankCode.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_current_option": isCurrentOption,
    "funding_option_name": fundingOptionName,
    "slug": slug,
    "api_public_key": apiPublicKey,
    "api_secret_key": apiSecretKey,
    "activation_status": activationStatus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "bank_codes": List<dynamic>.from(bankCodes.map((x) => x.toJson())),
  };
}

class BankCode {
  String id;
  String fundingOptionId;
  String bankCode;
  String bankCharges;
  String bankName;
  DateTime createdAt;
  DateTime updatedAt;

  BankCode({
    required this.id,
    required this.fundingOptionId,
    required this.bankCode,
    required this.bankCharges,
    required this.bankName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BankCode.fromJson(Map<String, dynamic> json) => BankCode(
    id: json["id"],
    fundingOptionId: json["funding_option_id"],
    bankCode: json["bank_code"],
    bankCharges: json["bank_charges"],
    bankName: json["bank_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "funding_option_id": fundingOptionId,
    "bank_code": bankCode,
    "bank_charges": bankCharges,
    "bank_name": bankName,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
