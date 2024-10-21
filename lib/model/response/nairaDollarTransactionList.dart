// To parse this JSON data, do
//
//     final nairaTransactionList = nairaTransactionListFromJson(jsonString);

import 'dart:convert';

List<NairaTransactionList> nairaTransactionListFromJson(String str) => List<NairaTransactionList>.from(json.decode(str).map((x) => NairaTransactionList.fromJson(x)));

String nairaTransactionListToJson(List<NairaTransactionList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NairaTransactionList {
  String id;
  String userId;
  dynamic transactionId;
  String actionBy;
  String transactionCategory;
  String balanceBefore;
  String balanceAfter;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  NairaTransactionList({
    required this.id,
    required this.userId,
    required this.transactionId,
    required this.actionBy,
    required this.transactionCategory,
    required this.balanceBefore,
    required this.balanceAfter,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NairaTransactionList.fromJson(Map<String, dynamic> json) => NairaTransactionList(
    id: json["id"],
    userId: json["user_id"],
    transactionId: json["transaction_id"],
    actionBy: json["action_by"],
    transactionCategory: json["transaction_category"],
    balanceBefore: json["balance_before"],
    balanceAfter: json["balance_after"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "transaction_id": transactionId,
    "action_by": actionBy,
    "transaction_category": transactionCategory,
    "balance_before": balanceBefore,
    "balance_after": balanceAfter,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
