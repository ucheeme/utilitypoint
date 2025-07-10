// To parse this JSON data, do
//
//     final newErrorResponse = newErrorResponseFromJson(jsonString);

import 'dart:convert';

NewErrorResponse newErrorResponseFromJson(String str) => NewErrorResponse.fromJson(json.decode(str));

String newErrorResponseToJson(NewErrorResponse data) => json.encode(data.toJson());

class NewErrorResponse {
  dynamic id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? phoneNumber;
  String? bvn;
  dynamic addressStreet;
  dynamic dob;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic postalCode;
  dynamic identificationType;
  dynamic identificationNumber;
  dynamic photo;
  dynamic identityType;
  dynamic identityNumber;
  dynamic identityImage;
  String? bvnVerificationStatus;
  String? canDoCardTransactions;
  BvnJson? bvnJson;
  String? dollarWallet;
  String? nairaWallet;
  String? kycVerificationStatus;
  String? emailNotification;
  String? pushNotification;
  String? smsAlert;
  String? accountDeactivation;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime lastLoginAt;
  String? deviceIdN;
  int? requireOtp;
  String token;

  NewErrorResponse({
     this.id,
     this.firstName,
     this.lastName,
     this.userName,
     this.email,
     this.phoneNumber,
     this.bvn,
     this.addressStreet,
     this.dob,
     this.city,
     this.state,
     this.country,
     this.postalCode,
     this.identificationType,
     this.identificationNumber,
     this.photo,
     this.identityType,
     this.identityNumber,
     this.identityImage,
     this.bvnVerificationStatus,
     this.canDoCardTransactions,
     this.bvnJson,
     this.dollarWallet,
     this.nairaWallet,
     this.kycVerificationStatus,
     this.emailNotification,
     this.pushNotification,
     this.smsAlert,
     this.accountDeactivation,
    required this.createdAt,
    required this.updatedAt,
    required this.lastLoginAt,
     this.deviceIdN,
     this.requireOtp,
    required this.token,
  });

  factory NewErrorResponse.fromJson(Map<String, dynamic> json) => NewErrorResponse(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    userName: json["user_name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    bvn: json["bvn"],
    addressStreet: json["address_street"],
    dob: json["dob"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    postalCode: json["postal_code"],
    identificationType: json["identification_type"],
    identificationNumber: json["identification_number"],
    photo: json["photo"],
    identityType: json["identity_type"],
    identityNumber: json["identity_number"],
    identityImage: json["identity_image"],
    bvnVerificationStatus: json["bvn_verification_status"],
    canDoCardTransactions: json["can_do_card_transactions"],
    bvnJson:json["bvn_json"]!=null?BvnJson.fromJson(json["bvn_json"]):null,
    dollarWallet: json["dollar_wallet"],
    nairaWallet: json["naira_wallet"],
    kycVerificationStatus: json["kyc_verification_status"],
    emailNotification: json["email_notification"],
    pushNotification: json["push_notification"],
    smsAlert: json["sms_alert"],
    accountDeactivation: json["account_deactivation"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    lastLoginAt: DateTime.parse(json["last_login_at"]),
    deviceIdN: json["device_id"],
    requireOtp: json["require_otp"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "user_name": userName,
    "email": email,
    "phone_number": phoneNumber,
    "bvn": bvn,
    "address_street": addressStreet,
    "dob": dob,
    "city": city,
    "state": state,
    "country": country,
    "postal_code": postalCode,
    "identification_type": identificationType,
    "identification_number": identificationNumber,
    "photo": photo,
    "identity_type": identityType,
    "identity_number": identityNumber,
    "identity_image": identityImage,
    "bvn_verification_status": bvnVerificationStatus,
    "can_do_card_transactions": canDoCardTransactions,
    "bvn_json": bvnJson?.toJson(),
    "dollar_wallet": dollarWallet,
    "naira_wallet": nairaWallet,
    "kyc_verification_status": kycVerificationStatus,
    "email_notification": emailNotification,
    "push_notification": pushNotification,
    "sms_alert": smsAlert,
    "account_deactivation": accountDeactivation,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "last_login_at": "${lastLoginAt.year.toString().padLeft(4, '0')}-${lastLoginAt.month.toString().padLeft(2, '0')}-${lastLoginAt.day.toString().padLeft(2, '0')}",
    "device_id": deviceIdN,
    "require_otp": requireOtp,
    "token": token,
  };
}

class BvnJson {
  bool status;
  String detail;
  String responseCode;
  Data data;
  Verification verification;
  List<dynamic> session;
  String endpointName;

  BvnJson({
    required this.status,
    required this.detail,
    required this.responseCode,
    required this.data,
    required this.verification,
    required this.session,
    required this.endpointName,
  });

  factory BvnJson.fromJson(Map<String, dynamic> json) => BvnJson(
    status: json["status"],
    detail: json["detail"],
    responseCode: json["response_code"],
    data: Data.fromJson(json["data"]),
    verification: Verification.fromJson(json["verification"]),
    session: List<dynamic>.from(json["session"].map((x) => x)),
    endpointName: json["endpoint_name"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "detail": detail,
    "response_code": responseCode,
    "data": data.toJson(),
    "verification": verification.toJson(),
    "session": List<dynamic>.from(session.map((x) => x)),
    "endpoint_name": endpointName,
  };
}

class Data {
  String firstName;
  String lastName;
  String middleName;
  String dateOfBirth;
  String phoneNumber;

  Data({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.dateOfBirth,
    required this.phoneNumber,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json["firstName"],
    lastName: json["lastName"],
    middleName: json["middleName"],
    dateOfBirth: json["dateOfBirth"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "middleName": middleName,
    "dateOfBirth": dateOfBirth,
    "phoneNumber": phoneNumber,
  };
}

class Verification {
  String status;
  String reference;

  Verification({
    required this.status,
    required this.reference,
  });

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
    status: json["status"],
    reference: json["reference"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "reference": reference,
  };
}
