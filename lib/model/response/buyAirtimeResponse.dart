// To parse this JSON data, do
//
//     final buyAirtimeResponse = buyAirtimeResponseFromJson(jsonString);

import 'dart:convert';

BuyAirtimeResponse buyAirtimeResponseFromJson(String str) => BuyAirtimeResponse.fromJson(json.decode(str));

String buyAirtimeResponseToJson(BuyAirtimeResponse data) => json.encode(data.toJson());

class BuyAirtimeResponse {
  bool status;
  String message;
  List<Datum> data;

  BuyAirtimeResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BuyAirtimeResponse.fromJson(Map<String, dynamic> json) => BuyAirtimeResponse(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String message;
  String adminMessage;
  int status;

  Datum({
    required this.message,
    required this.adminMessage,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    message: json["message"],
    adminMessage: json["admin_message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "admin_message": adminMessage,
    "status": status,
  };
}

AirtimeAdminMessage airtimAdminMessageFromJson(String str) => AirtimeAdminMessage.fromJson(json.decode(str));

String airtimAdminMessageToJson(AirtimeAdminMessage data) => json.encode(data.toJson());

class AirtimeAdminMessage {
  String status;
  Detail detail;

  AirtimeAdminMessage({
    required this.status,
    required this.detail,
  });

  factory AirtimeAdminMessage.fromJson(Map<String, dynamic> json) => AirtimeAdminMessage(
    status: json["Status"],
    detail: Detail.fromJson(json["Detail"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Detail": detail.toJson(),
  };
}

class Detail {
  String success;
  String message;
  Info info;

  Detail({
    required this.success,
    required this.message,
    required this.info,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    success: json["success"],
    message: json["message"],
    info: Info.fromJson(json["info"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "info": info.toJson(),
  };
}

class Info {
  String id;
  String referenceId;
  String detail;
  String balanceBefore;
  String balanceAfter;
  String success;
  String type;
  String amount;
  DateTime period;
  String userid;
  String realresponse;
  String data;

  Info({
    required this.id,
    required this.referenceId,
    required this.detail,
    required this.balanceBefore,
    required this.balanceAfter,
    required this.success,
    required this.type,
    required this.amount,
    required this.period,
    required this.userid,
    required this.realresponse,
    required this.data,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    id: json["Id"],
    referenceId: json["Reference_id"],
    detail: json["Detail"],
    balanceBefore: json["Balance_before"],
    balanceAfter: json["Balance_after"],
    success: json["Success"],
    type: json["Type"],
    amount: json["Amount"],
    period: DateTime.parse(json["Period"]),
    userid: json["Userid"],
    realresponse: json["realresponse"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Reference_id": referenceId,
    "Detail": detail,
    "Balance_before": balanceBefore,
    "Balance_after": balanceAfter,
    "Success": success,
    "Type": type,
    "Amount": amount,
    "Period": period.toIso8601String(),
    "Userid": userid,
    "realresponse": realresponse,
    "data": data,
  };
}
