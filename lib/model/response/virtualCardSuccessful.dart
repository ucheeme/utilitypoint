// To parse this JSON data, do
//
//     final virtualCardSuccesful = virtualCardSuccesfulFromJson(jsonString);

import 'dart:convert';

VirtualCardSuccesful virtualCardSuccesfulFromJson(String str) => VirtualCardSuccesful.fromJson(json.decode(str));

String virtualCardSuccesfulToJson(VirtualCardSuccesful data) => json.encode(data.toJson());

class VirtualCardSuccesful {
  Details details;

  VirtualCardSuccesful({
    required this.details,
  });

  factory VirtualCardSuccesful.fromJson(Map<String, dynamic> json) => VirtualCardSuccesful(
    details: Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "details": details.toJson(),
  };
}

class Details {
  String transId;
  String ref;
  Card card;
  Customer customer;

  Details({
    required this.transId,
    required this.ref,
    required this.card,
    required this.customer,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    transId: json["trans_id"],
    ref: json["ref"],
    card: Card.fromJson(json["card"]),
    customer: Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "trans_id": transId,
    "ref": ref,
    "card": card.toJson(),
    "customer": customer.toJson(),
  };
}

class Card {
  String id;
  String cardType;
  String currency;
  String brand;
  String name;
  String firstSix;
  String lastFour;
  String masked;
  String number;
  String expiry;
  String ccv;
  Billing billing;
  DateTime createdAt;
  DateTime updatedAt;

  Card({
    required this.id,
    required this.cardType,
    required this.currency,
    required this.brand,
    required this.name,
    required this.firstSix,
    required this.lastFour,
    required this.masked,
    required this.number,
    required this.expiry,
    required this.ccv,
    required this.billing,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    id: json["id"],
    cardType: json["card_type"],
    currency: json["currency"],
    brand: json["brand"],
    name: json["name"],
    firstSix: json["first_six"],
    lastFour: json["last_four"],
    masked: json["masked"],
    number: json["number"],
    expiry: json["expiry"],
    ccv: json["ccv"],
    billing: Billing.fromJson(json["billing"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "card_type": cardType,
    "currency": currency,
    "brand": brand,
    "name": name,
    "first_six": firstSix,
    "last_four": lastFour,
    "masked": masked,
    "number": number,
    "expiry": expiry,
    "ccv": ccv,
    "billing": billing.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Billing {
  String street;
  String city;
  String state;
  String country;
  String postalCode;

  Billing({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
  });

  factory Billing.fromJson(Map<String, dynamic> json) => Billing(
    street: json["street"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    postalCode: json["postal_code"],
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "city": city,
    "state": state,
    "country": country,
    "postal_code": postalCode,
  };
}

class Customer {
  String id;
  String name;

  Customer({
    required this.id,
    required this.name,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
