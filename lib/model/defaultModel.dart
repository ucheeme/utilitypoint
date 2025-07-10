// To parse this JSON data, do
//
//     final defaultApiResponse = defaultApiResponseFromJson(jsonString);

import 'dart:convert';

DefaultApiResponse defaultApiResponseFromJson(String str) => DefaultApiResponse.fromJson(json.decode(str));

String defaultApiResponseToJson(DefaultApiResponse data) => json.encode(data.toJson());

class DefaultApiResponse {
  bool? status;
  String message;
  dynamic data;
  dynamic errors;
  dynamic code;
  DefaultApiResponse({
     this.status,
    required this.message,
     this.data,
    this.errors,
    this.code
  });

  factory DefaultApiResponse.fromJson(Map<String, dynamic> json) => DefaultApiResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"],
    errors: json["errors"],
    code: json["code"]
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "errors":errors,
    "code":code
  };
}

DefaultErrorApiResponse defaultErrorApiResponseFromJson(String str) => DefaultErrorApiResponse.fromJson(json.decode(str));

String defaultErrorApiResponseToJson(DefaultErrorApiResponse data) => json.encode(data.toJson());

class DefaultErrorApiResponse {
  List<String> email;

  DefaultErrorApiResponse({
    required this.email,
  });

  factory DefaultErrorApiResponse.fromJson(Map<String, dynamic> json) => DefaultErrorApiResponse(
    email: List<String>.from(json["email"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "email": List<dynamic>.from(email.map((x) => x)),
  };
}



SecondDefaultResponse secondDefaultResponseFromJson(String str) => SecondDefaultResponse.fromJson(json.decode(str));

String secondDefaultResponseToJson(SecondDefaultResponse data) => json.encode(data.toJson());

class SecondDefaultResponse {
  bool status;
  String message;
  List<dynamic> data;

  SecondDefaultResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SecondDefaultResponse.fromJson(Map<String, dynamic> json) => SecondDefaultResponse(
    status: json["status"],
    message: json["message"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}


