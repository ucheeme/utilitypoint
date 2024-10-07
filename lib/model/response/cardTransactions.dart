// To parse this JSON data, do
//
//     final cardTransaction = cardTransactionFromJson(jsonString);

import 'dart:convert';

CardTransaction cardTransactionFromJson(String str) => CardTransaction.fromJson(json.decode(str));

String cardTransactionToJson(CardTransaction data) => json.encode(data.toJson());

class CardTransaction {
  Details details;

  CardTransaction({
    required this.details,
  });

  factory CardTransaction.fromJson(Map<String, dynamic> json) => CardTransaction(
    details: Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "details": details.toJson(),
  };
}

class Details {
  List<CardTransactionList> transactions;
  int total;
  int page;
  int pageSize;

  Details({
    required this.transactions,
    required this.total,
    required this.page,
    required this.pageSize,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    transactions: List<CardTransactionList>.from(json["transactions"].map((x) => CardTransactionList.fromJson(x))),
    total: json["total"],
    page: json["page"],
    pageSize: json["page_size"],
  );

  Map<String, dynamic> toJson() => {
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
    "total": total,
    "page": page,
    "page_size": pageSize,
  };
}

class CardTransactionList {
  String id;
  String customerId;
  String uid;
  String cid;
  String cardUuid;
  String bid;
  String currency;
  String balance;
  String cardType;
  String brand;
  String cardId;
  String provider;
  String name;
  String number;
  String firstsix;
  String lastfour;
  String masked;
  String expiry;
  String ccv;
  String address;
  String meta;
  DateTime dateCreated;
  DateTime lastModified;
  String status;
  String terminate;
  dynamic reason;
  dynamic terminateDate;
  String refId;
  String refType;
  String amount;
  DateTime createdAt;
  String transId;
  String description;

  CardTransactionList({
    required this.id,
    required this.customerId,
    required this.uid,
    required this.cid,
    required this.cardUuid,
    required this.bid,
    required this.currency,
    required this.balance,
    required this.cardType,
    required this.brand,
    required this.cardId,
    required this.provider,
    required this.name,
    required this.number,
    required this.firstsix,
    required this.lastfour,
    required this.masked,
    required this.expiry,
    required this.ccv,
    required this.address,
    required this.meta,
    required this.dateCreated,
    required this.lastModified,
    required this.status,
    required this.terminate,
    required this.reason,
    required this.terminateDate,
    required this.refId,
    required this.refType,
    required this.amount,
    required this.createdAt,
    required this.transId,
    required this.description,
  });

  factory CardTransactionList.fromJson(Map<String, dynamic> json) => CardTransactionList(
    id: json["id"],
    customerId: json["customer_id"],
    uid: json["uid"],
    cid: json["cid"],
    cardUuid: json["card_uuid"],
    bid: json["bid"],
    currency: json["currency"],
    balance: json["balance"],
    cardType: json["card_type"],
    brand: json["brand"],
    cardId: json["card_id"],
    provider: json["provider"],
    name: json["name"],
    number: json["number"],
    firstsix: json["firstsix"],
    lastfour: json["lastfour"],
    masked: json["masked"],
    expiry: json["expiry"],
    ccv: json["ccv"],
    address: json["address"],
    meta: json["meta"],
    dateCreated: DateTime.parse(json["date_created"]),
    lastModified: DateTime.parse(json["last_modified"]),
    status: json["status"],
    terminate: json["terminate"],
    reason: json["reason"],
    terminateDate: json["terminate_date"],
    refId: json["ref_id"],
    refType: json["ref_type"],
    amount: json["amount"],
    createdAt: DateTime.parse(json["created_at"]),
    transId: json["trans_id"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "uid": uid,
    "cid": cid,
    "card_uuid": cardUuid,
    "bid": bid,
    "currency": currency,
    "balance": balance,
    "card_type": cardType,
    "brand": brand,
    "card_id": cardId,
    "provider": provider,
    "name": name,
    "number": number,
    "firstsix": firstsix,
    "lastfour": lastfour,
    "masked": masked,
    "expiry": expiry,
    "ccv": ccv,
    "address": address,
    "meta": meta,
    "date_created": dateCreated.toIso8601String(),
    "last_modified": lastModified.toIso8601String(),
    "status": status,
    "terminate": terminate,
    "reason": reason,
    "terminate_date": terminateDate,
    "ref_id": refId,
    "ref_type": refType,
    "amount": amount,
    "created_at": createdAt.toIso8601String(),
    "trans_id": transId,
    "description": description,
  };
}
