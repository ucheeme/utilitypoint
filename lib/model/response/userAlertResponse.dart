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
  String bvnVerificationStatus;
  BvnJson? bvnJson;
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
    required this.bvnVerificationStatus,
     this.bvnJson,
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
    bvnVerificationStatus: json["bvn_verification_status"],
    bvnJson: BvnJson.fromJson(json["bvn_json"]),
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
    "bvn_verification_status": bvnVerificationStatus,
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
  String number;

  Data({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.number,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json["firstName"],
    lastName: json["lastName"],
    middleName: json["middleName"],
    dateOfBirth: json["dateOfBirth"],
    phoneNumber: json["phoneNumber"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "middleName": middleName,
    "dateOfBirth": dateOfBirth,
    "phoneNumber": phoneNumber,
    "number": number,
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
