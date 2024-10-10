import 'package:utilitypoint/env/env.dart';

class AppUrls{
  static const baseUrl =Env.baseUrlStaging;
  static const register= "${baseUrl}auth/register";
  static const emailVerification="${baseUrl}user/verify_email";
  static const resendEmailVerification="${baseUrl}user/resend_email_verification_code";
  static const setPin="${baseUrl}user/set_user_pin";
  static const changePin="${baseUrl}user/change_user_pin";
  static const setUserInfo="${baseUrl}user/update_user";
  static const login="${baseUrl}auth/login";
  static const forgotPassword="${baseUrl}auth/forgot_password";
  static const completeTwoFactorAuthentication="${baseUrl}auth/complete_two_factor_authentication";
  static const resendCompleteTwoFactorAuthentication="${baseUrl}auth/resend_2fa_code";
  static const getUserCards="${baseUrl}user/view_virtual_cards";
  static const getCardTransaction="${baseUrl}user/virtual_card_transactions";
  static const createUserCard="${baseUrl}user/create_virtual_card";
  static const topUpCard="${baseUrl}user/topup_virtual_card";
  static const freezeUserCard="${baseUrl}user/freeze_card";
  static const unFreezeUserCard="${baseUrl}user/unfreeze_card";
  static const getTransactionHistory="${baseUrl}user/fetch_transactions";
  static const getExchangeRate="${baseUrl}fetch_currency_conversion_setting";
  static const getNetworks="${baseUrl}user/fetch_networks";
  static const getProduct="${baseUrl}user/fetch_products";
  static const getProductDataPlanCategory="${baseUrl}user/fetch_product_plan_categories";
  static const getProductPlans="${baseUrl}user/fetch_product_plans";
  static const buyElectricity="${baseUrl}user/buy_electricity";
  static const confirmSmartCableName="${baseUrl}user/validate_cable_tv";
  static const confirmElectricityMeterName="${baseUrl}user/validate_metre_number";
  static const cableSubscription="${baseUrl}user/buy_cable_tv";
  static const buyAirtime="${baseUrl}user/buy_airtime";
  static const buyDollar="${baseUrl}currency/buy_dollar";
 // static const completeTwoFactorAuthentication=
 // "${baseUrl}auth/complete_two_factor_authentication";
}