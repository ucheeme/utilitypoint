// To parse this JSON data, do
//
//     final userGeneralSettings = userGeneralSettingsFromJson(jsonString);

import 'dart:convert';

List<UserGeneralSettings> userGeneralSettingsFromJson(String str) => List<UserGeneralSettings>.from(json.decode(str).map((x) => UserGeneralSettings.fromJson(x)));

String userGeneralSettingsToJson(List<UserGeneralSettings> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserGeneralSettings {
  String id;
  String fieldName;
  String fieldValue;
  DateTime createdAt;
  DateTime updatedAt;

  UserGeneralSettings({
    required this.id,
    required this.fieldName,
    required this.fieldValue,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserGeneralSettings.fromJson(Map<String, dynamic> json) => UserGeneralSettings(
    id: json["id"],
    fieldName: json["field_name"],
    fieldValue: json["field_value"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "field_name": fieldName,
    "field_value": fieldValue,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
