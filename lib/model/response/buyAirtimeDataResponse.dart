// To parse this JSON data, do
//
//     final buyAirtimeDataResponse = buyAirtimeDataResponseFromJson(jsonString);

import 'dart:convert';

BuyAirtimeDataResponse buyAirtimeDataResponseFromJson(String str) => BuyAirtimeDataResponse.fromJson(json.decode(str));

String buyAirtimeDataResponseToJson(BuyAirtimeDataResponse data) => json.encode(data.toJson());

class BuyAirtimeDataResponse {
  String networkId;
  String phoneNumber;
  String productPlanCategoryId;
  String productPlanId;
  String pin;
  String walletCategory;
  int validatephonenetwork;
  String userId;
  List<Datum> data;

  BuyAirtimeDataResponse({
    required this.networkId,
    required this.phoneNumber,
    required this.productPlanCategoryId,
    required this.productPlanId,
    required this.pin,
    required this.walletCategory,
    required this.validatephonenetwork,
    required this.userId,
    required this.data,
  });

  factory BuyAirtimeDataResponse.fromJson(Map<String, dynamic> json) => BuyAirtimeDataResponse(
    networkId: json["network_id"]??"",
    phoneNumber: json["phone_number"]??"",
    productPlanCategoryId: json["product_plan_category_id"]??"",
    productPlanId: json["product_plan_id"]??"",
    pin: json["pin"]??"",
    walletCategory: json["wallet_category"]??"",
    validatephonenetwork: json["validatephonenetwork"]??0,
    userId: json["user_id"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "network_id": networkId,
    "phone_number": phoneNumber,
    "product_plan_category_id": productPlanCategoryId,
    "product_plan_id": productPlanId,
    "pin": pin,
    "wallet_category": walletCategory,
    "validatephonenetwork": validatephonenetwork,
    "user_id": userId,
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


AirtimeDataAdminMessage airtimAdminMessageFromJson(String str) => AirtimeDataAdminMessage.fromJson(json.decode(str));

String airtimAdminMessageToJson(AirtimeDataAdminMessage data) => json.encode(data.toJson());

class AirtimeDataAdminMessage {
  String status;
  Detail detail;

  AirtimeDataAdminMessage({
    required this.status,
    required this.detail,
  });

  factory AirtimeDataAdminMessage.fromJson(Map<String, dynamic> json) => AirtimeDataAdminMessage(
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
