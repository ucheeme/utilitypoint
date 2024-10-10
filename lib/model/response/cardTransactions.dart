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
  String? id;
  String? customerId;
  String? uid;
  String? cid;
  String? cardUuid;
  String? bid;
  String? currency;
  String? balance;
  String? cardType;
  String? brand;
  String? cardId;
  String? provider;
  String? name;
  String? number;
  String? firstsix;
  String? lastfour;
  String? masked;
  String? expiry;
  String? ccv;
  String? address;
  String? meta;
  DateTime? dateCreated;
  DateTime? lastModified;
  String? status;
  String? terminate;
  dynamic reason;
  dynamic terminateDate;
  String? refId;
  String? refType;
  String? amount;
  DateTime createdAt;
  String? transId;
  String? description;

  CardTransactionList({
     this.id,
     this.customerId,
     this.uid,
     this.cid,
     this.cardUuid,
     this.bid,
     this.currency,
     this.balance,
     this.cardType,
     this.brand,
     this.cardId,
     this.provider,
     this.name,
     this.number,
     this.firstsix,
     this.lastfour,
     this.masked,
     this.expiry,
     this.ccv,
     this.address,
     this.meta,
      this.dateCreated,
     this.lastModified,
     this.status,
     this.terminate,
     this.reason,
     this.terminateDate,
     this.refId,
     this.refType,
     this.amount,
     required this.createdAt,
     this.transId,
     this.description,
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
    dateCreated: json["date_created"]==null?null:DateTime.parse(json["date_created"]),
    lastModified:  json["last_modified"]==null?null:DateTime.parse(json["last_modified"]),
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
    "date_created": dateCreated?.toIso8601String(),
    "last_modified": lastModified?.toIso8601String(),
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
