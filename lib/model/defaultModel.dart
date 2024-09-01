// To parse this JSON data, do
//
//     final defaultApiResponse = defaultApiResponseFromJson(jsonString);

import 'dart:convert';

DefaultApiResponse defaultApiResponseFromJson(String str) => DefaultApiResponse.fromJson(json.decode(str));

String defaultApiResponseToJson(DefaultApiResponse data) => json.encode(data.toJson());

class DefaultApiResponse {
  int code;
  dynamic data;
  String message;
  DefaultErrorApiResponse? error;

  DefaultApiResponse({
    required this.code,
    this.data,
    required this.message,
    this.error,
  });

  factory DefaultApiResponse.fromJson(Map<String, dynamic> json) => DefaultApiResponse(
      code: json["code"],
      data: json["data"],
      message: json["message"],
      error: json["error"]==null?null:DefaultErrorApiResponse.fromJson(json["error"])
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data,
    "message": message,
    "error": error,
  };
}

DefaultErrorApiResponse defaultErrorApiResponseFromJson(String str) => DefaultErrorApiResponse.fromJson(json.decode(str));

String defaultErrorApiResponseToJson(DefaultErrorApiResponse data) => json.encode(data.toJson());

class DefaultErrorApiResponse {
  String id;
  String service;
  String details;
  String publicMessage;

  DefaultErrorApiResponse({
    required this.id,
    required this.service,
    required this.details,
    required this.publicMessage,
  });

  factory DefaultErrorApiResponse.fromJson(Map<String, dynamic> json) => DefaultErrorApiResponse(
    id: json["id"],
    service: json["service"],
    details: json["details"],
    publicMessage: json["publicMessage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service": service,
    "details": details,
    "publicMessage": publicMessage,
  };
}
