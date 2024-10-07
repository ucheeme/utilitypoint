// To parse this JSON data, do
//
//     final userVirtualCards = userVirtualCardsFromJson(jsonString);

import 'dart:convert';

List<UserVirtualCards> userVirtualCardsFromJson(String str) => List<UserVirtualCards>.from(json.decode(str).map((x) => UserVirtualCards.fromJson(x)));

String userVirtualCardsToJson(List<UserVirtualCards> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserVirtualCards {
  String id;
  String userId;
  dynamic postalCode;
  dynamic country;
  dynamic state;
  dynamic city;
  String cardCcv;
  String cardExpiry;
  String cardNumber;
  String cardMasked;
  String cardLastFour;
  String cardFirstSix;
  String cardName;
  String cardTransactionId;
  String freezeStatus;
  String cardId;
  String cardProvider;
  String customerId;
  String currency;
  String brand;
  String amount;
  String cardType;
  String activationStatus;
  String cardReference;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  UserVirtualCards({
    required this.id,
    required this.userId,
    required this.postalCode,
    required this.country,
    required this.state,
    required this.city,
    required this.cardCcv,
    required this.cardExpiry,
    required this.cardNumber,
    required this.cardMasked,
    required this.cardLastFour,
    required this.cardFirstSix,
    required this.cardName,
    required this.cardTransactionId,
    required this.freezeStatus,
    required this.cardId,
    required this.cardProvider,
    required this.customerId,
    required this.currency,
    required this.brand,
    required this.amount,
    required this.cardType,
    required this.activationStatus,
    required this.cardReference,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory UserVirtualCards.fromJson(Map<String, dynamic> json) => UserVirtualCards(
    id: json["id"],
    userId: json["user_id"],
    postalCode: json["postal_code"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    cardCcv: json["card_ccv"],
    cardExpiry: json["card_expiry"],
    cardNumber: json["card_number"],
    cardMasked: json["card_masked"],
    cardLastFour: json["card_last_four"],
    cardFirstSix: json["card_first_six"],
    cardName: json["card_name"],
    cardTransactionId: json["card_transaction_id"],
    freezeStatus: json["freeze_status"],
    cardId: json["card_id"],
    cardProvider: json["card_provider"],
    customerId: json["customer_id"],
    currency: json["currency"],
    brand: json["brand"],
    amount: json["amount"],
    cardType: json["card_type"],
    activationStatus: json["activation_status"],
    cardReference: json["card_reference"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "postal_code": postalCode,
    "country": country,
    "state": state,
    "city": city,
    "card_ccv": cardCcv,
    "card_expiry": cardExpiry,
    "card_number": cardNumber,
    "card_masked": cardMasked,
    "card_last_four": cardLastFour,
    "card_first_six": cardFirstSix,
    "card_name": cardName,
    "card_transaction_id": cardTransactionId,
    "freeze_status": freezeStatus,
    "card_id": cardId,
    "card_provider": cardProvider,
    "customer_id": customerId,
    "currency": currency,
    "brand": brand,
    "amount": amount,
    "card_type": cardType,
    "activation_status": activationStatus,
    "card_reference": cardReference,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toJson(),
  };
}

class User {
  String id;
  String firstName;
  String lastName;
  dynamic otherNames;
  String userName;
  String pin;
  String userPlanId;
  String roleId;
  String dollarWallet;
  String nairaWallet;
  String email;
  String phoneNumber;
  String uplineId;
  DateTime emailVerifiedAt;
  String emailOtp;
  DateTime otpExpirationTime;
  String twoFactorCode;
  DateTime twoFactorCodeExpirationTime;
  String active;
  dynamic twoFactorSecret;
  dynamic twoFactorRecoveryCodes;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.otherNames,
    required this.userName,
    required this.pin,
    required this.userPlanId,
    required this.roleId,
    required this.dollarWallet,
    required this.nairaWallet,
    required this.email,
    required this.phoneNumber,
    required this.uplineId,
    required this.emailVerifiedAt,
    required this.emailOtp,
    required this.otpExpirationTime,
    required this.twoFactorCode,
    required this.twoFactorCodeExpirationTime,
    required this.active,
    required this.twoFactorSecret,
    required this.twoFactorRecoveryCodes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    otherNames: json["other_names"],
    userName: json["user_name"],
    pin: json["pin"],
    userPlanId: json["user_plan_id"],
    roleId: json["role_id"],
    dollarWallet: json["dollar_wallet"],
    nairaWallet: json["naira_wallet"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    uplineId: json["upline_id"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    emailOtp: json["email_otp"],
    otpExpirationTime: DateTime.parse(json["otp_expiration_time"]),
    twoFactorCode: json["two_factor_code"],
    twoFactorCodeExpirationTime: DateTime.parse(json["two_factor_code_expiration_time"]),
    active: json["active"],
    twoFactorSecret: json["two_factor_secret"],
    twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "other_names": otherNames,
    "user_name": userName,
    "pin": pin,
    "user_plan_id": userPlanId,
    "role_id": roleId,
    "dollar_wallet": dollarWallet,
    "naira_wallet": nairaWallet,
    "email": email,
    "phone_number": phoneNumber,
    "upline_id": uplineId,
    "email_verified_at": emailVerifiedAt.toIso8601String(),
    "email_otp": emailOtp,
    "otp_expiration_time": otpExpirationTime.toIso8601String(),
    "two_factor_code": twoFactorCode,
    "two_factor_code_expiration_time": twoFactorCodeExpirationTime.toIso8601String(),
    "active": active,
    "two_factor_secret": twoFactorSecret,
    "two_factor_recovery_codes": twoFactorRecoveryCodes,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
