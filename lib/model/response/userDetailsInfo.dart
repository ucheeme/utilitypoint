// To parse this JSON data, do
//
//     final userDetailsInfo = userDetailsInfoFromJson(jsonString);

import 'dart:convert';

UserDetailsInfo userDetailsInfoFromJson(String str) => UserDetailsInfo.fromJson(json.decode(str));

String userDetailsInfoToJson(UserDetailsInfo data) => json.encode(data.toJson());

class UserDetailsInfo {
  String id;
  dynamic bvn;
  dynamic sendchampJson;
  dynamic termiiJson;
  dynamic termiiPinId;
  dynamic sendchampSuccessStatus;
  dynamic sendchampChannel;
  dynamic sendchampOtp;
  dynamic sendchampReference;
  dynamic sendchampAttempts;
  String canDoCardTransactions;
  String identityImage;
  dynamic identityNumber;
  String identityType;
  String photo;
  String identificationNumber;
  String identificationType;
  String postalCode;
  String country;
  String state;
  String city;
  DateTime dob;
  String addressStreet;
  dynamic bvnJson;
  String bvnVerificationStatus;
  String kycVerificationStatus;
  String firstName;
  String lastName;
  String otherNames;
  String userName;
  String pin;
  String userPlanId;
  String roleId;
  String dollarWallet;
  String nairaWallet;
  String email;
  String accountDeactivation;
  String smsAlert;
  String pushNotification;
  String emailNotification;
  String phoneNumber;
  dynamic uplineId;
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
  String deviceId;
  DateTime lastLoginAt;

  UserDetailsInfo({
    required this.id,
    required this.bvn,
     this.sendchampJson,
    required this.termiiJson,
    required this.termiiPinId,
    required this.sendchampSuccessStatus,
    required this.sendchampChannel,
    required this.sendchampOtp,
    required this.sendchampReference,
    required this.sendchampAttempts,
    required this.canDoCardTransactions,
    required this.identityImage,
    required this.identityNumber,
    required this.identityType,
    required this.photo,
    required this.identificationNumber,
    required this.identificationType,
    required this.postalCode,
    required this.country,
    required this.state,
    required this.city,
    required this.dob,
    required this.addressStreet,
    required this.bvnJson,
    required this.bvnVerificationStatus,
    required this.kycVerificationStatus,
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
    required this.accountDeactivation,
    required this.smsAlert,
    required this.pushNotification,
    required this.emailNotification,
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
    required this.deviceId,
    required this.lastLoginAt,
  });

  factory UserDetailsInfo.fromJson(Map<String, dynamic> json) => UserDetailsInfo(
    id: json["id"],
    bvn: json["bvn"],
    sendchampJson: json["sendchamp_json"]==null?null:SendchampJson.fromJson(json["sendchamp_json"]),
    termiiJson: json["termii_json"],
    termiiPinId: json["termii_pin_id"],
    sendchampSuccessStatus: json["sendchamp_success_status"],
    sendchampChannel: json["sendchamp_channel"],
    sendchampOtp: json["sendchamp_otp"],
    sendchampReference: json["sendchamp_reference"],
    sendchampAttempts: json["sendchamp_attempts"],
    canDoCardTransactions: json["can_do_card_transactions"],
    identityImage: json["identity_image"],
    identityNumber: json["identity_number"],
    identityType: json["identity_type"],
    photo: json["photo"],
    identificationNumber: json["identification_number"],
    identificationType: json["identification_type"],
    postalCode: json["postal_code"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    dob: DateTime.parse(json["dob"]),
    addressStreet: json["address_street"],
    bvnJson: json["bvn_json"],
    bvnVerificationStatus: json["bvn_verification_status"],
    kycVerificationStatus: json["kyc_verification_status"],
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
    accountDeactivation: json["account_deactivation"],
    smsAlert: json["sms_alert"],
    pushNotification: json["push_notification"],
    emailNotification: json["email_notification"],
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
    deviceId: json["device_id"],
    lastLoginAt: DateTime.parse(json["last_login_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bvn": bvn,
    "sendchamp_json": sendchampJson.toJson(),
    "termii_json": termiiJson,
    "termii_pin_id": termiiPinId,
    "sendchamp_success_status": sendchampSuccessStatus,
    "sendchamp_channel": sendchampChannel,
    "sendchamp_otp": sendchampOtp,
    "sendchamp_reference": sendchampReference,
    "sendchamp_attempts": sendchampAttempts,
    "can_do_card_transactions": canDoCardTransactions,
    "identity_image": identityImage,
    "identity_number": identityNumber,
    "identity_type": identityType,
    "photo": photo,
    "identification_number": identificationNumber,
    "identification_type": identificationType,
    "postal_code": postalCode,
    "country": country,
    "state": state,
    "city": city,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "address_street": addressStreet,
    "bvn_json": bvnJson,
    "bvn_verification_status": bvnVerificationStatus,
    "kyc_verification_status": kycVerificationStatus,
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
    "account_deactivation": accountDeactivation,
    "sms_alert": smsAlert,
    "push_notification": pushNotification,
    "email_notification": emailNotification,
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
    "device_id": deviceId,
    "last_login_at": "${lastLoginAt.year.toString().padLeft(4, '0')}-${lastLoginAt.month.toString().padLeft(2, '0')}-${lastLoginAt.day.toString().padLeft(2, '0')}",
  };
}

class SendchampJson {
  SendchampJson();

  factory SendchampJson.fromJson(Map<String, dynamic> json) => SendchampJson(
  );

  Map<String, dynamic> toJson() => {
  };
}
