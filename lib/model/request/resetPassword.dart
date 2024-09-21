// To parse this JSON data, do
//
//     final resetPassword = resetPasswordFromJson(jsonString);

import 'dart:convert';

ResetPasswordRequest resetPasswordFromJson(String str) => ResetPasswordRequest.fromJson(json.decode(str));

String resetPasswordToJson(ResetPasswordRequest data) => json.encode(data.toJson());

class ResetPasswordRequest {
  String userId;
  String currentPassword;
  String newPassword;
  String confirmNewPassword;

  ResetPasswordRequest({
    required this.userId,
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      ResetPasswordRequest(
    userId: json["user_id"],
    currentPassword: json["current_password"],
    newPassword: json["new_password"],
    confirmNewPassword: json["confirm_new_password"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "current_password": currentPassword,
    "new_password": newPassword,
    "confirm_new_password": confirmNewPassword,
  };
}
