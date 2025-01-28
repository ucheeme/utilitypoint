// To parse this JSON data, do
//
//     final productTransactionList = productTransactionListFromJson(jsonString);

import 'dart:convert';

List<ProductTransactionList> productTransactionListFromJson(String str) => List<ProductTransactionList>.from(json.decode(str).map((x) => ProductTransactionList.fromJson(x)));

String productTransactionListToJson(List<ProductTransactionList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductTransactionList {
  String id;
  String userId;
  String productPlanId;
  String transactionCategory;
  String status;
  String walletCategory;
  String? phoneNumber;
  dynamic smartCardNumber;
  String? metreNumber;
  String cableTvSlots;
  String utilitySlots;
  String amount;
  dynamic referralCommissionValue;
  String discountedAmount;
  String balanceBefore;
  String balanceAfter;
  String description;
  String userScreenMessage;
  String adminScreenMessage;
  String referralCommissionStatus;
  DateTime createdAt;
  DateTime updatedAt;
  ProductPlan productPlan;

  ProductTransactionList({
    required this.id,
    required this.userId,
    required this.productPlanId,
    required this.transactionCategory,
    required this.status,
    required this.walletCategory,
    required this.phoneNumber,
    required this.smartCardNumber,
    required this.metreNumber,
    required this.cableTvSlots,
    required this.utilitySlots,
    required this.amount,
    required this.referralCommissionValue,
    required this.discountedAmount,
    required this.balanceBefore,
    required this.balanceAfter,
    required this.description,
    required this.userScreenMessage,
    required this.adminScreenMessage,
    required this.referralCommissionStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.productPlan,
  });

  factory ProductTransactionList.fromJson(Map<String, dynamic> json) => ProductTransactionList(
    id: json["id"],
    userId: json["user_id"],
    productPlanId: json["product_plan_id"],
    transactionCategory: json["transaction_category"],
    status: json["status"],
    walletCategory: json["wallet_category"],
    phoneNumber: json["phone_number"],
    smartCardNumber: json["smart_card_number"],
    metreNumber: json["metre_number"],
    cableTvSlots: json["cable_tv_slots"],
    utilitySlots: json["utility_slots"],
    amount: json["amount"],
    referralCommissionValue: json["referral_commission_value"],
    discountedAmount: json["discounted_amount"],
    balanceBefore: json["balance_before"],
    balanceAfter: json["balance_after"],
    description: json["description"],
    userScreenMessage: json["user_screen_message"],
    adminScreenMessage: json["admin_screen_message"],
    referralCommissionStatus: json["referral_commission_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    productPlan: ProductPlan.fromJson(json["product_plan"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_plan_id": productPlanId,
    "transaction_category": transactionCategory,
    "status": status,
    "wallet_category": walletCategory,
    "phone_number": phoneNumber,
    "smart_card_number": smartCardNumber,
    "metre_number": metreNumber,
    "cable_tv_slots": cableTvSlots,
    "utility_slots": utilitySlots,
    "amount": amount,
    "referral_commission_value": referralCommissionValue,
    "discounted_amount": discountedAmount,
    "balance_before": balanceBefore,
    "balance_after": balanceAfter,
    "description": description,
    "user_screen_message": userScreenMessage,
    "admin_screen_message": adminScreenMessage,
    "referral_commission_status": referralCommissionStatus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "product_plan": productPlan.toJson(),
  };
}

class ProductPlan {
  String id;
  String uplineCommissionCap;
  String uplineFlatCommission;
  String uplinePercentageCommission;
  String uplineCommissionOption;
  String productPlanName;
  String productPlanCategoryId;
  String automationProductPlanId;
  String automationId;
  String costPrice;
  String dataSizeInMb;
  String validityInDays;
  String defaultSellingPrice;
  String userLevel1SellingPrice;
  String userLevel2SellingPrice;
  String userLevel3SellingPrice;
  String userLevel4SellingPrice;
  dynamic userLevel5SellingPrice;
  dynamic userLevel6SellingPrice;
  String visibility;
  String publicVisibility;
  String activeStatus;
  DateTime createdAt;
  DateTime updatedAt;

  ProductPlan({
    required this.id,
    required this.uplineCommissionCap,
    required this.uplineFlatCommission,
    required this.uplinePercentageCommission,
    required this.uplineCommissionOption,
    required this.productPlanName,
    required this.productPlanCategoryId,
    required this.automationProductPlanId,
    required this.automationId,
    required this.costPrice,
    required this.dataSizeInMb,
    required this.validityInDays,
    required this.defaultSellingPrice,
    required this.userLevel1SellingPrice,
    required this.userLevel2SellingPrice,
    required this.userLevel3SellingPrice,
    required this.userLevel4SellingPrice,
    required this.userLevel5SellingPrice,
    required this.userLevel6SellingPrice,
    required this.visibility,
    required this.publicVisibility,
    required this.activeStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductPlan.fromJson(Map<String, dynamic> json) => ProductPlan(
    id: json["id"],
    uplineCommissionCap: json["upline_commission_cap"],
    uplineFlatCommission: json["upline_flat_commission"],
    uplinePercentageCommission: json["upline_percentage_commission"],
    uplineCommissionOption: json["upline_commission_option"],
    productPlanName: json["product_plan_name"],
    productPlanCategoryId: json["product_plan_category_id"],
    automationProductPlanId: json["automation_product_plan_id"],
    automationId: json["automation_id"],
    costPrice: json["cost_price"],
    dataSizeInMb: json["data_size_in_mb"],
    validityInDays: json["validity_in_days"],
    defaultSellingPrice: json["default_selling_price"],
    userLevel1SellingPrice: json["user_level_1_selling_price"],
    userLevel2SellingPrice: json["user_level_2_selling_price"],
    userLevel3SellingPrice: json["user_level_3_selling_price"],
    userLevel4SellingPrice: json["user_level_4_selling_price"],
    userLevel5SellingPrice: json["user_level_5_selling_price"],
    userLevel6SellingPrice: json["user_level_6_selling_price"],
    visibility: json["visibility"],
    publicVisibility: json["public_visibility"],
    activeStatus: json["active_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "upline_commission_cap": uplineCommissionCap,
    "upline_flat_commission": uplineFlatCommission,
    "upline_percentage_commission": uplinePercentageCommission,
    "upline_commission_option": uplineCommissionOption,
    "product_plan_name": productPlanName,
    "product_plan_category_id": productPlanCategoryId,
    "automation_product_plan_id": automationProductPlanId,
    "automation_id": automationId,
    "cost_price": costPrice,
    "data_size_in_mb": dataSizeInMb,
    "validity_in_days": validityInDays,
    "default_selling_price": defaultSellingPrice,
    "user_level_1_selling_price": userLevel1SellingPrice,
    "user_level_2_selling_price": userLevel2SellingPrice,
    "user_level_3_selling_price": userLevel3SellingPrice,
    "user_level_4_selling_price": userLevel4SellingPrice,
    "user_level_5_selling_price": userLevel5SellingPrice,
    "user_level_6_selling_price": userLevel6SellingPrice,
    "visibility": visibility,
    "public_visibility": publicVisibility,
    "active_status": activeStatus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
