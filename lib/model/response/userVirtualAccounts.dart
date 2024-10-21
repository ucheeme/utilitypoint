// To parse this JSON data, do
//
//     final userVirtualAccouts = userVirtualAccoutsFromJson(jsonString);

import 'dart:convert';

List<UserVirtualAccouts> userVirtualAccoutsFromJson(String str) => List<UserVirtualAccouts>.from(json.decode(str).map((x) => UserVirtualAccouts.fromJson(x)));

String userVirtualAccoutsToJson(List<UserVirtualAccouts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserVirtualAccouts {
  String id;
  String fundingOptionId;
  String userId;
  String fundingSlug;
  String responseStatus;
  String bankName;
  String bankCode;
  String accountName;
  String accountEmail;
  String accountNumber;
  String accountReference;
  String bvn;
  DateTime createdAt;
  DateTime updatedAt;
  FundingOption fundingOption;

  UserVirtualAccouts({
    required this.id,
    required this.fundingOptionId,
    required this.userId,
    required this.fundingSlug,
    required this.responseStatus,
    required this.bankName,
    required this.bankCode,
    required this.accountName,
    required this.accountEmail,
    required this.accountNumber,
    required this.accountReference,
    required this.bvn,
    required this.createdAt,
    required this.updatedAt,
    required this.fundingOption,
  });

  factory UserVirtualAccouts.fromJson(Map<String, dynamic> json) => UserVirtualAccouts(
    id: json["id"],
    fundingOptionId: json["funding_option_id"],
    userId: json["user_id"],
    fundingSlug: json["funding_slug"],
    responseStatus: json["response_status"],
    bankName: json["bank_name"],
    bankCode: json["bank_code"],
    accountName: json["account_name"],
    accountEmail: json["account_email"],
    accountNumber: json["account_number"],
    accountReference: json["account_reference"],
    bvn: json["bvn"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    fundingOption: FundingOption.fromJson(json["funding_option"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "funding_option_id": fundingOptionId,
    "user_id": userId,
    "funding_slug": fundingSlug,
    "response_status": responseStatus,
    "bank_name": bankName,
    "bank_code": bankCode,
    "account_name": accountName,
    "account_email": accountEmail,
    "account_number": accountNumber,
    "account_reference": accountReference,
    "bvn": bvn,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "funding_option": fundingOption.toJson(),
  };
}

class FundingOption {
  String id;
  String fundingOptionName;

  FundingOption({
    required this.id,
    required this.fundingOptionName,
  });

  factory FundingOption.fromJson(Map<String, dynamic> json) => FundingOption(
    id: json["id"],
    fundingOptionName: json["funding_option_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "funding_option_name": fundingOptionName,
  };
}
