import 'package:utilitypoint/env/env.dart';

import '../flavour/flavour.dart';
import '../flavour/locator.dart';

class AppUrls{
  static final baseUrl = locator<AppFlavorConfig>().apiBaseUrl;
  static final register= "${baseUrl}auth/register";
  static final emailVerification="${baseUrl}user/verify_email";
  static final resendEmailVerification="${baseUrl}user/resend_email_verification_code";
  static final setPin="${baseUrl}user/set_user_pin";
  static final changePin="${baseUrl}user/change_user_pin";
  static final setUserInfo="${baseUrl}user/update_user";
  static final login="${baseUrl}auth/login";
  static final forgotPassword="${baseUrl}auth/forgot_password";
  static final createNewPassword="${baseUrl}auth/complete_password_reset";
  static final completeTwoFactorAuthentication="${baseUrl}auth/complete_two_factor_authentication";
  static final resendCompleteTwoFactorAuthentication="${baseUrl}auth/resend_2fa_code";
  static final getUserCards="${baseUrl}user/view_virtual_cards";
  static final getCardTransaction="${baseUrl}user/virtual_card_transactions";
  static final createUserCard="${baseUrl}user/create_virtual_card";
  static final createVirtualAcct="${baseUrl}user/generate_naira_virtual_accounts";
  static final topUpCard="${baseUrl}user/topup_virtual_card";
  static final freezeUserCard="${baseUrl}user/freeze_card";
  static final unFreezeUserCard="${baseUrl}user/unfreeze_card";
  static final getTransactionHistory="${baseUrl}user/fetch_transactions";
  static final getUserSettings="${baseUrl}settings";
  static final getUserVirtualAccounts="${baseUrl}user/fetch_naira_virtual_accounts";
  static final getUserDetails="${baseUrl}user/fetch_single_user";
  static final getExchangeRate="${baseUrl}fetch_currency_conversion_setting";
  static final getNairaFunding="${baseUrl}fetch_naira_funding_options";
  static final getNetworks="${baseUrl}user/fetch_networks";
  static final getProduct="${baseUrl}user/fetch_products";
  static final getProductDataPlanCategory="${baseUrl}user/fetch_product_plan_categories";
  static final getProductPlans="${baseUrl}user/fetch_product_plans";
  static final buyElectricity="${baseUrl}user/buy_electricity";
  static final confirmSmartCableName="${baseUrl}user/validate_cable_tv";
  static final confirmElectricityMeterName="${baseUrl}user/validate_metre_number";
  static final cableSubscription="${baseUrl}user/buy_cable_tv";
  static final buyAirtime="${baseUrl}user/buy_airtime";
  static final buyDollar="${baseUrl}currency/buy_dollar";
  static final buyData="${baseUrl}user/buy_data";
  static final buyCableSub="${baseUrl}user/buy_cable_tv";
  static final updateUserPassword="${baseUrl}user/reset_password";
  static final resetUserPin="${baseUrl}user/change_user_pin";
  static final updateUserDetails="${baseUrl}user/update_user";
  static final logOut="${baseUrl}auth/logout";
  static final getUserNotification="${baseUrl}user/fetch_user_notifications";
  static final markNotification="${baseUrl}user/toggle_user_notification_read_status";
  static final getNairaTransactions="${baseUrl}user/fetch_naira_wallet_transactions";
  static final getDollarsTransactions="${baseUrl}user/fetch_dollar_wallet_transactions";
  static final getUserUploadedKYC="${baseUrl}kyc/fetch_user_kyc_details";
  static final getUSerKYCVerificationStatus="${baseUrl}kyc/user_verification_status";
  static final uploadKYCDocumentC="${baseUrl}kyc/upload_user_kyc_document";
  static final uploadBVNDocumentC="${baseUrl}kyc/user_bvn_verification";
  static final updateAppSetting="${baseUrl}user/update_appside_setting";
  static final getFAQ="${baseUrl}faqs";
  static final getSingleVirtualCard="${baseUrl}user/view_single_virtual_card";
  static final setUserIdentifier="${baseUrl}user/update_user_unique";
  static final getSingleUserDetails="${baseUrl}user/fetch_single_user";
  static final getUserWalletBalance="${baseUrl}user/fetch_wallet_balance";

  static final validateBvnOtp= "${baseUrl}kyc/verify_bvn_phone_otp";
 // static final completeTwoFactorAuthentication=
 // "${baseUrl}auth/complete_two_factor_authentication";
}