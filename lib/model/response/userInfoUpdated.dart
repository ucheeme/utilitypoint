// To parse this JSON data, do
//
//     final userInfoUpdated = userInfoUpdatedFromJson(jsonString);

import 'dart:convert';

UserInfoUpdated userInfoUpdatedFromJson(String str) => UserInfoUpdated.fromJson(json.decode(str));

String userInfoUpdatedToJson(UserInfoUpdated data) => json.encode(data.toJson());

class UserInfoUpdated {
  String id;
  String firstName;
  String lastName;
  dynamic userName;
  String email;
  String bvn;
  String? addressStreet;
  DateTime dob;
  String city;
  String state;
  String country;
  String postalCode;
  String identificationType;
  String identificationNumber;
  String photo;
  String identityType;
  dynamic identityNumber;
  dynamic identityImage;
  String bvnVerificationStatus;
  dynamic bvnJson;
  String dollarWallet;
  String nairaWallet;
  String canDoCardTransaction;
  String kycVerificationStatus;
  String emailNotification;
  String pushNotification;
  String smsAlert;
  String accountDeactivation;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime lastLogIn;
  String? deviceId;
  int? requireOtp;
  dynamic emailOtp;
  String token;

  UserInfoUpdated({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.bvn,
     this.addressStreet,
    required this.dob,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.identificationType,
    required this.identificationNumber,
    required this.photo,
    required this.identityType,
    required this.identityNumber,
    required this.identityImage,
    required this.bvnVerificationStatus,
    required this.bvnJson,
    required this.dollarWallet,
    required this.nairaWallet,
    required this.kycVerificationStatus,
    required this.canDoCardTransaction,
    required this.emailNotification,
    required this.pushNotification,
    required this.smsAlert,
    required this.accountDeactivation,
    required this.createdAt,
    required this.updatedAt,
    this.deviceId,
    required this.lastLogIn,
    this.requireOtp,
    this.emailOtp,
    required this.token,
  });

  factory UserInfoUpdated.fromJson(Map<String, dynamic> json) => UserInfoUpdated(
    id: json["id"],
    firstName: json["first_name"]??"Utility Point",
    lastName: json["last_name"]??"Utility Point",
    userName: json["user_name"]??"utilityPoint",
    email: json["email"],
    bvn: json["bvn"]??"",
    addressStreet: json["address_street"] ?? "",
    dob: json["dob"]==null?DateTime.now():
    isValidIsoDate(json["dob"])?
    DateTime.parse(json["dob"]):DateTime.now(),
    city: json["city"]??"",
    state: json["state"]??"",
    country: json["country"]??"",
    postalCode: json["postal_code"]??"",
    identificationType: json["identification_type"]??"",
    identificationNumber: json["identification_number"]??"",
    photo: json["photo"]??"",
    identityType: json["identity_type"]??"",
    identityNumber: json["identity_number"]??"",
    identityImage: json["identity_image"]??"",
    bvnVerificationStatus: json["bvn_verification_status"]??"",
    bvnJson: json["bvn_json"].runtimeType==int?
    json["bvn_json"]:json["bvn_json"]==null
        ?null: BvnJson.fromJson(json["bvn_json"]),
    dollarWallet: json["dollar_wallet"],
    nairaWallet: json["naira_wallet"],
    kycVerificationStatus: json["kyc_verification_status"],
    canDoCardTransaction: json["can_do_card_transactions"],
    emailNotification: json["email_notification"],
    pushNotification: json["push_notification"],
    smsAlert: json["sms_alert"],
    accountDeactivation: json["account_deactivation"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    lastLogIn:  DateTime.parse(json["last_login_at"]),
    deviceId: json["device_id"],
    requireOtp: json["require_otp"],
    emailOtp: json["email_otp"],
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
    "bvn_json": bvnJson?.toJson(),
    "dollar_wallet": dollarWallet,
    "naira_wallet": nairaWallet,
    "can_do_card_transactions": canDoCardTransaction,
    "kyc_verification_status": kycVerificationStatus,
    "email_notification": emailNotification,
    "push_notification": pushNotification,
    "sms_alert": smsAlert,
    "account_deactivation": accountDeactivation,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "last_log_in": lastLogIn.toIso8601String(),
    "device_id": deviceId,
    "require_otp": requireOtp,
    "email_otp": emailOtp,
    "token": token,
  };
}

bool isValidIsoDate(String input) {
  try {
    DateTime.parse(input);
    return true;
  } catch (e) {
    return false;
  }
}
BvnJson bvnJsonFromJson(String str) => BvnJson.fromJson(json.decode(str));

String bvnJsonToJson(BvnJson data) => json.encode(data.toJson());

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
    status: json["status"]??"",
    detail: json["detail"]??"",
    responseCode: json["response_code"]??"",
    data: json["data"]==null?Data(firstName: '', lastName: '', middleName: '', dateOfBirth: '', phoneNumber: ''):
    Data.fromJson(json["data"]),
    verification: Verification.fromJson(json["verification"]),
    session: List<dynamic>.from(json["session"].map((x) => x)),
    endpointName: json["endpoint_name"]??"",
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
