// To parse this JSON data, do
//
//     final createVirtualAccountNumberSuccess = createVirtualAccountNumberSuccessFromJson(jsonString);

import 'dart:convert';

CreateVirtualAccountNumberSuccess createVirtualAccountNumberSuccessFromJson(String str) => CreateVirtualAccountNumberSuccess.fromJson(json.decode(str));

String createVirtualAccountNumberSuccessToJson(CreateVirtualAccountNumberSuccess data) => json.encode(data.toJson());

class CreateVirtualAccountNumberSuccess {
  bool success;
  String status;
  String message;
  Data data;

  CreateVirtualAccountNumberSuccess({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateVirtualAccountNumberSuccess.fromJson(Map<String, dynamic> json) => CreateVirtualAccountNumberSuccess(
    success: json["success"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String bankName;
  String accountName;
  String accountEmail;
  String accountNumber;
  String accountReference;
  int virtualAccountBankId;

  Data({
    required this.bankName,
    required this.accountName,
    required this.accountEmail,
    required this.accountNumber,
    required this.accountReference,
    required this.virtualAccountBankId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bankName: json["bank_name"],
    accountName: json["account_name"],
    accountEmail: json["account_email"],
    accountNumber: json["account_number"],
    accountReference: json["account_reference"],
    virtualAccountBankId: json["virtual_account_bank_id"],
  );

  Map<String, dynamic> toJson() => {
    "bank_name": bankName,
    "account_name": accountName,
    "account_email": accountEmail,
    "account_number": accountNumber,
    "account_reference": accountReference,
    "virtual_account_bank_id": virtualAccountBankId,
  };
}
