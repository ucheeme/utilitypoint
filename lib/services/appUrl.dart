import 'package:utilitypoint/env/env.dart';

class AppUrls{
  static const baseUrl =Env.baseUrlStaging;
  static const register= "$baseUrl/auth/register";
  static const emailVerification="$baseUrl/user/verify_email";
  static const resendEmailVerification="$baseUrl/user/resend_email_verification_code";
  static const setPin="$baseUrl/user/set_user_pin";
  static const setUserInfo="$baseUrl/user/update_user";
  static const login="$baseUrl/auth/login";
  static const forgotPassword="$baseUrl/auth/forgot_password";
  static const completeTwoFactorAuthentication="$baseUrl/auth/complete_two_factor_authentication";
 // static const completeTwoFactorAuthentication=
 // "$baseUrl/auth/complete_two_factor_authentication";
}