// To parse this JSON data, do
//
//     final userAlertNotificationRequest = userAlertNotificationRequestFromJson(jsonString);

import 'dart:convert';

UserAlertNotificationRequest userAlertNotificationRequestFromJson(String str) => UserAlertNotificationRequest.fromJson(json.decode(str));

String userAlertNotificationRequestToJson(UserAlertNotificationRequest data) => json.encode(data.toJson());

class UserAlertNotificationRequest {
  String userId;
  String emailNotification;
  String pushNotification;
  String smsAlert;
  String accountDeactivation;

  UserAlertNotificationRequest({
    required this.userId,
    required this.emailNotification,
    required this.pushNotification,
    required this.smsAlert,
    required this.accountDeactivation,
  });

  factory UserAlertNotificationRequest.fromJson(Map<String, dynamic> json) => UserAlertNotificationRequest(
    userId: json["user_id"],
    emailNotification: json["email_notification"],
    pushNotification: json["push_notification"],
    smsAlert: json["sms_alert"],
    accountDeactivation: json["account_deactivation"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "email_notification": emailNotification,
    "push_notification": pushNotification,
    "sms_alert": smsAlert,
    "account_deactivation": accountDeactivation,
  };
}
