// To parse this JSON data, do
//
//     final bvnValidationResponse = bvnValidationResponseFromJson(jsonString);

import 'dart:convert';

BvnValidationResponse bvnValidationResponseFromJson(String str) => BvnValidationResponse.fromJson(json.decode(str));

String bvnValidationResponseToJson(BvnValidationResponse data) => json.encode(data.toJson());

class BvnValidationResponse {
  String? smsStatus;
  String? phoneNumber;
  String? to;
  String? pinId;
  String? bvnValidationResponsePinId;
  String? status;

  BvnValidationResponse({
     this.smsStatus,
     this.phoneNumber,
     this.to,
     this.pinId,
     this.bvnValidationResponsePinId,
     this.status,
  });

  factory BvnValidationResponse.fromJson(Map<String, dynamic> json) => BvnValidationResponse(
    smsStatus: json["smsStatus"],
    phoneNumber: json["phone_number"],
    to: json["to"],
    pinId: json["pinId"],
    bvnValidationResponsePinId: json["pin_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "smsStatus": smsStatus,
    "phone_number": phoneNumber,
    "to": to,
    "pinId": pinId,
    "pin_id": bvnValidationResponsePinId,
    "status": status,
  };
}
