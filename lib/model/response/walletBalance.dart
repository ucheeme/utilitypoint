// To parse this JSON data, do
//
//     final walletBalanceResponse = walletBalanceResponseFromJson(jsonString);

import 'dart:convert';

WalletBalanceResponse walletBalanceResponseFromJson(String str) => WalletBalanceResponse.fromJson(json.decode(str));

String walletBalanceResponseToJson(WalletBalanceResponse data) => json.encode(data.toJson());

class WalletBalanceResponse {
  String nairaWallet;
  String dollarWallet;

  WalletBalanceResponse({
    required this.nairaWallet,
    required this.dollarWallet,
  });

  factory WalletBalanceResponse.fromJson(Map<String, dynamic> json) => WalletBalanceResponse(
    nairaWallet: json["naira_wallet"],
    dollarWallet: json["dollar_wallet"],
  );

  Map<String, dynamic> toJson() => {
    "naira_wallet": nairaWallet,
    "dollar_wallet": dollarWallet,
  };
}
