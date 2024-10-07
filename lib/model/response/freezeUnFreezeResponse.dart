// To parse this JSON data, do
//
//     final freezeCardSuccess = freezeCardSuccessFromJson(jsonString);

import 'dart:convert';

FreezeCardSuccess freezeCardSuccessFromJson(String str) => FreezeCardSuccess.fromJson(json.decode(str));

String freezeCardSuccessToJson(FreezeCardSuccess data) => json.encode(data.toJson());

class FreezeCardSuccess {
  Details details;

  FreezeCardSuccess({
    required this.details,
  });

  factory FreezeCardSuccess.fromJson(Map<String, dynamic> json) => FreezeCardSuccess(
    details: Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "details": details.toJson(),
  };
}

class Details {
  String transId;
  String ref;
  Customer customer;
  Card card;
  String currency;
  String action;
  DateTime createdAt;

  Details({
    required this.transId,
    required this.ref,
    required this.customer,
    required this.card,
    required this.currency,
    required this.action,
    required this.createdAt,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    transId: json["trans_id"],
    ref: json["ref"],
    customer: Customer.fromJson(json["customer"]),
    card: Card.fromJson(json["card"]),
    currency: json["currency"],
    action: json["action"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "trans_id": transId,
    "ref": ref,
    "customer": customer.toJson(),
    "card": card.toJson(),
    "currency": currency,
    "action": action,
    "created_at": createdAt.toIso8601String(),
  };
}

class Card {
  String id;
  String firstSix;
  String lastFour;
  int prevBalance;
  int balance;

  Card({
    required this.id,
    required this.firstSix,
    required this.lastFour,
    required this.prevBalance,
    required this.balance,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    id: json["id"],
    firstSix: json["first_six"],
    lastFour: json["last_four"],
    prevBalance: json["prev_balance"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_six": firstSix,
    "last_four": lastFour,
    "prev_balance": prevBalance,
    "balance": balance,
  };
}

class Customer {
  String id;

  Customer({
    required this.id,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
