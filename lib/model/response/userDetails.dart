// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'dart:convert';

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  String id;
  String? bvn;
  String? identityImage;
  String? identityNumber;
  String? identityType;
  String? identityPhoto;
  String? identificationNumber;
  String? identificationType;
  String? postalCode;
  String? country;
  String? state;
  String? city;
  String? dob;
  String? addressStreet;
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
  String uplineId;
  DateTime emailVerifiedAt;
  String emailOtp;
  DateTime otpExpirationTime;
  String twoFactorCode;
  DateTime twoFactorCodeExpirationTime;
  String active;
  String? profilePic;
  dynamic twoFactorSecret;
  dynamic twoFactorRecoveryCodes;
  DateTime createdAt;
  DateTime updatedAt;

  UserDetails({
    required this.id,
     this.bvn,
    this.country,
    this.state,
    this.city,
    this.dob,
    this.postalCode,
    this.addressStreet,
    this.identificationType,
    this.identificationNumber,
    this.identityImage,
    this.identityType,
    this.identityNumber,
    this.identityPhoto,
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
    this.profilePic,
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

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["id"],
    bvn: json["bvn"]??"",
    identityImage: json["identity_image"],
   identityNumber: json[ "identity_number"],
    identityType: json["identity_type"],
    identityPhoto: json["photo"],
    identificationNumber: json["identification_number"],
    identificationType: json["identification_type"],
    postalCode: json["postal_code"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    dob: json["dob"],
    addressStreet: json["address_street"],
    bvnJson: json["bvn_json"],
    bvnVerificationStatus: json["bvn_verification_status"],
    kycVerificationStatus: json["kyc_verification_status"],
    firstName: json["first_name"]??"",
    lastName: json["last_name"]??"",
    otherNames: json["other_names"]??"",
    userName: json["user_name"]??"",
    pin: json["pin"],
    userPlanId: json["user_plan_id"],
    roleId: json["role_id"],
    dollarWallet: json["dollar_wallet"],
    nairaWallet: json["naira_wallet"],
    email: json["email"]??"",
    accountDeactivation: json["account_deactivation"],
    smsAlert: json["sms_alert"],
    pushNotification: json["push_notification"],
    emailNotification: json["email_notification"],
    phoneNumber: json["phone_number"]??"",
    uplineId: json["upline_id"]??"",
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    emailOtp: json["email_otp"]??"",
    otpExpirationTime: DateTime.parse(json["otp_expiration_time"]),
    twoFactorCode: json["two_factor_code"]??"",
    twoFactorCodeExpirationTime: json["two_factor_code_expiration_time"] != null
        ? DateTime.parse(json["two_factor_code_expiration_time"])
        : DateTime.now().add(const Duration(minutes: 1)),
    active: json["active"],
    twoFactorSecret: json["two_factor_secret"]??"",
    twoFactorRecoveryCodes: json["two_factor_recovery_codes"]??"",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bvn": bvn,
    "identity_image": identityImage,
    "identity_number": identificationNumber,
    "identity_type": identityType,
    "photo": identityPhoto,
    "identification_number": identificationNumber,
    "identification_type": identificationType,
    "postal_code": postalCode,
    "country": country,
    "state": state,
    "city": city,
    "dob": dob,
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
  };
}
