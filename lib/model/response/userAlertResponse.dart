// To parse this JSON data, do
//
//     final userAlertResponse = userAlertResponseFromJson(jsonString);

import 'dart:convert';

UserAlertResponse userAlertResponseFromJson(String str) => UserAlertResponse.fromJson(json.decode(str));

String userAlertResponseToJson(UserAlertResponse data) => json.encode(data.toJson());

class UserAlertResponse {
  String id;
  String firstName;
  String lastName;
  String userName;
  String email;
  String bvn;
  String addressStreet;
  DateTime dob;
  String city;
  String state;
  String country;
  String postalCode;
  String identificationType;
  String identificationNumber;
  String photo;
  String? identityType;
  String? identityNumber;
  String identityImage;
  String bvnVerificationStatus;
  dynamic bvnJson;
  String dollarWallet;
  String nairaWallet;
  String kycVerificationStatus;
  String emailNotification;
  String pushNotification;
  String smsAlert;
  String accountDeactivation;
  DateTime createdAt;
  DateTime updatedAt;
  String token;

  UserAlertResponse({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.bvn,
    required this.addressStreet,
    required this.dob,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.identificationType,
    required this.identificationNumber,
    required this.photo,
     this.identityType,
     this.identityNumber,
    required this.identityImage,
    required this.bvnVerificationStatus,
    required this.bvnJson,
    required this.dollarWallet,
    required this.nairaWallet,
    required this.kycVerificationStatus,
    required this.emailNotification,
    required this.pushNotification,
    required this.smsAlert,
    required this.accountDeactivation,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
  });

  factory UserAlertResponse.fromJson(Map<String, dynamic> json) => UserAlertResponse(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    userName: json["user_name"],
    email: json["email"],
    bvn: json["bvn"],
    addressStreet: json["address_street"],
    dob: DateTime.parse(json["dob"]),
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
    bvnJson: json["bvn_json"],
    dollarWallet: json["dollar_wallet"],
    nairaWallet: json["naira_wallet"],
    kycVerificationStatus: json["kyc_verification_status"],
    emailNotification: json["email_notification"],
    pushNotification: json["push_notification"],
    smsAlert: json["sms_alert"],
    accountDeactivation: json["account_deactivation"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "user_name": userName,
    "email": email,
    "bvn": bvn,
    "address_street": addressStreet,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
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
    "bvn_json": bvnJson,
    "dollar_wallet": dollarWallet,
    "naira_wallet": nairaWallet,
    "kyc_verification_status": kycVerificationStatus,
    "email_notification": emailNotification,
    "push_notification": pushNotification,
    "sms_alert": smsAlert,
    "account_deactivation": accountDeactivation,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "token": token,
  };
}
