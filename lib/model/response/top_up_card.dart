// To parse this JSON data, do
//
//     final topUpCardSuccessful = topUpCardSuccessfulFromJson(jsonString);

import 'dart:convert';

TopUpCardSuccessful topUpCardSuccessfulFromJson(String str) => TopUpCardSuccessful.fromJson(json.decode(str));

String topUpCardSuccessfulToJson(TopUpCardSuccessful data) => json.encode(data.toJson());

class TopUpCardSuccessful {
  Details details;

  TopUpCardSuccessful({
    required this.details,
  });

  factory TopUpCardSuccessful.fromJson(Map<String, dynamic> json) => TopUpCardSuccessful(
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
  double prevBalance;
  double balance;
  String refId;
  String action;
  DateTime createdAt;

  Details({
    required this.transId,
    required this.ref,
    required this.customer,
    required this.card,
    required this.currency,
    required this.prevBalance,
    required this.balance,
    required this.refId,
    required this.action,
    required this.createdAt,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    transId: json["trans_id"],
    ref: json["ref"],
    customer: Customer.fromJson(json["customer"]),
    card: Card.fromJson(json["card"]),
    currency: json["currency"],
    prevBalance: json["prev_balance"],
    balance: json["balance"],
    refId: json["ref_id"],
    action: json["action"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "trans_id": transId,
    "ref": ref,
    "customer": customer.toJson(),
    "card": card.toJson(),
    "currency": currency,
    "prev_balance": prevBalance,
    "balance": balance,
    "ref_id": refId,
    "action": action,
    "created_at": createdAt.toIso8601String(),
  };
}

class Card {
  String id;
  String firstSix;
  String lastFour;
  String brand;
  dynamic prevBalance;
  dynamic balance;

  Card({
    required this.id,
    required this.firstSix,
    required this.lastFour,
    required this.brand,
    required this.prevBalance,
    required this.balance,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    id: json["id"],
    firstSix: json["first_six"],
    lastFour: json["last_four"],
    brand: json["brand"],
    prevBalance: json["prev_balance"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_six": firstSix,
    "last_four": lastFour,
    "brand": brand,
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
