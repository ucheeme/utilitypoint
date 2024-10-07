// To parse this JSON data, do
//
//     final buyElectricityResponse = buyElectricityResponseFromJson(jsonString);

import 'dart:convert';

BuyElectricityResponse buyElectricityResponseFromJson(String str) => BuyElectricityResponse.fromJson(json.decode(str));

String buyElectricityResponseToJson(BuyElectricityResponse data) => json.encode(data.toJson());

class BuyElectricityResponse {
  ElectricityData the1;

  BuyElectricityResponse({
    required this.the1,
  });

  factory BuyElectricityResponse.fromJson(Map<String, dynamic> json) => BuyElectricityResponse(
    the1: ElectricityData.fromJson(json["1"]),
  );

  Map<String, dynamic> toJson() => {
    "1": the1.toJson(),
  };
}

class ElectricityData {
  String message;
  String adminMessage;
  int status;

  ElectricityData({
    required this.message,
    required this.adminMessage,
    required this.status,
  });

  factory ElectricityData.fromJson(Map<String, dynamic> json) => ElectricityData(
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

ElectricityAdminMessage adminMessageFromJson(String str) => ElectricityAdminMessage.fromJson(json.decode(str));

String adminMessageToJson(ElectricityAdminMessage data) => json.encode(data.toJson());

class ElectricityAdminMessage {
  String status;
  Detail detail;

  ElectricityAdminMessage({
    required this.status,
    required this.detail,
  });

  factory ElectricityAdminMessage.fromJson(Map<String, dynamic> json) => ElectricityAdminMessage(
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
