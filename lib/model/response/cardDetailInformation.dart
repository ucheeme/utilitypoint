// To parse this JSON data, do
//
//     final SingleCardInformation  = SingleCardInformation FromJson(jsonString);

import 'dart:convert';

SingleCardInformation  singleCardInformationFromJson(String str) => SingleCardInformation.fromJson(json.decode(str));

String SingleCardInformationToJson(SingleCardInformation  data) => json.encode(data.toJson());

class SingleCardInformation  {
  bool status;
  String description;
  Message message;
  int statusCode;

  SingleCardInformation ({
    required this.status,
    required this.description,
    required this.message,
    required this.statusCode,
  });

  factory SingleCardInformation.fromJson(Map<String, dynamic> json) => SingleCardInformation (
    status: json["status"],
    description: json["description"],
    message: Message.fromJson(json["message"]),
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "description": description,
    "message": message.toJson(),
    "status_code": statusCode,
  };
}

class Message {
  Details details;

  Message({
    required this.details,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    details: Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "details": details.toJson(),
  };
}

class Details {
  String id;
  String currency;
  String cardType;
  String brand;
  String firstSix;
  String lastFour;
  String masked;
  String cardNumber;
  String expiry;
  String ccv;
  int balance;
  String status;
  Billing billing;
  DateTime createdAt;
  DateTime updatedAt;
  bool terminate;
  dynamic terminateDate;
  Customer customer;

  Details({
    required this.id,
    required this.currency,
    required this.cardType,
    required this.brand,
    required this.firstSix,
    required this.lastFour,
    required this.masked,
    required this.cardNumber,
    required this.expiry,
    required this.ccv,
    required this.balance,
    required this.status,
    required this.billing,
    required this.createdAt,
    required this.updatedAt,
    required this.terminate,
    required this.terminateDate,
    required this.customer,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["id"],
    currency: json["currency"],
    cardType: json["card_type"],
    brand: json["brand"],
    firstSix: json["first_six"],
    lastFour: json["last_four"],
    masked: json["masked"],
    cardNumber: json["card_number"],
    expiry: json["expiry"],
    ccv: json["ccv"],
    balance: json["balance"],
    status: json["status"],
    billing: Billing.fromJson(json["billing"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    terminate: json["terminate"],
    terminateDate: json["terminate_date"],
    customer: Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "currency": currency,
    "card_type": cardType,
    "brand": brand,
    "first_six": firstSix,
    "last_four": lastFour,
    "masked": masked,
    "card_number": cardNumber,
    "expiry": expiry,
    "ccv": ccv,
    "balance": balance,
    "status": status,
    "billing": billing.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "terminate": terminate,
    "terminate_date": terminateDate,
    "customer": customer.toJson(),
  };
}

class Billing {
  String address;
  String country;
  String state;
  String city;
  String postalCode;

  Billing({
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.postalCode,
  });

  factory Billing.fromJson(Map<String, dynamic> json) => Billing(
    address: json["address"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    postalCode: json["postal_code"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "country": country,
    "state": state,
    "city": city,
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
