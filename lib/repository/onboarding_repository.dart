import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:utilitypoint/model/defaultModel.dart';
import 'package:utilitypoint/model/request/changePin.dart';
import 'package:utilitypoint/model/request/loginRequest.dart';
import 'package:utilitypoint/model/request/setUniqueIdentifier.dart';
import 'package:utilitypoint/model/request/verifyEmailRequest.dart';
import 'package:utilitypoint/repository/apiRepository.dart';

import '../bloc/onboarding_new/onboard_new_bloc.dart';
import '../model/request/accountCreation.dart';
import '../model/request/setTransactionPin.dart';
import '../model/request/signInResetPasswordRequest.dart';
import '../model/request/twoFactorAuthenticationRequest.dart';
import '../model/request/updateUserInfo.dart';
import '../model/response/accountCreated.dart';
import '../model/response/setUniqueIdentifierResponse.dart';
import '../model/response/userDetailsInfo.dart';
import '../model/response/userInfoUpdated.dart';
import '../services/api_service.dart';
import '../services/appUrl.dart';

class OnboardingRepository extends DefaultRepository {
  Future<Object> createUser(request) async {
    var response = await postRequest(
        request, AppUrls.register, false, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        AccountCreatedResponse res = accountCreatedFromJson(
            json.encode(r.data));
        return res;
      } else {
        return r;
      }
    }
    else {
      print(response);
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> verifyUserEmail(VerifiedEmailRequest request) async {
    var response = await postRequest(null,
        "${AppUrls.emailVerification}?user_id=${request.userId}&otp=${request
            .otp}",
        true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        DefaultApiResponse res = defaultApiResponseFromJson(json.encode(r));
        return res;
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> resendVerificationCode(VerifiedEmailRequest request) async {
    var response = await postRequest(null,
        "${AppUrls.resendEmailVerification}?user_id=${request.userId}",
        true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        DefaultApiResponse res = defaultApiResponseFromJson(json.encode(r));
        return res;
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> resendTwoFactorAuthentication(
      VerifiedEmailRequest request) async {
    var response = await postRequest(null,
        "${AppUrls.resendCompleteTwoFactorAuthentication}?user_id=${request
            .userId}",
        true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        DefaultApiResponse res = defaultApiResponseFromJson(json.encode(r));
        return res;
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> setTransactionPin(SetTransactionPinRequest request) async {
    var response = await postRequest(request, AppUrls.setPin,
        true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        DefaultApiResponse res = defaultApiResponseFromJson(json.encode(r));
        return res;
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> changeTransactionPin(ChangePinRequest request) async {
    var response = await postRequest(request, AppUrls.changePin,
        true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        DefaultApiResponse res = defaultApiResponseFromJson(json.encode(r));
        return res;
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> createNewPassword(SignInResetPasswordRequest request) async {
    var response = await postRequest(request, AppUrls.createNewPassword,
        true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        UserInfoUpdated res = userInfoUpdatedFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> setUserInfo(UpdateUser request) async {
    var response = await postRequest(request, AppUrls.setUserInfo,
        true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        UserInfoUpdated res = userInfoUpdatedFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> setIdentifiers(SetUniqueIdentifierRequest request) async {
    var response = await postRequest(request, AppUrls.setUserIdentifier,
        true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        UniqueIdentifierResponse res = uniqueIdentifierResponseFromJson(
            json.encode(r.data));
        return res;
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> loginUser(LoginUserRequest request) async {
    var response = await postRequest(request, AppUrls.login,
        true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        UserInfoUpdated res = userInfoUpdatedFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> forgotPassword(String request) async {
    var response = await postRequest(
        null, "${AppUrls.forgotPassword}?email=$request",
        true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        UserInfoUpdated res = userInfoUpdatedFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> twoFactorAuthentication(
      TwoFactorAuthenticationRequest request) async {
    var response = await postRequest(
        request, AppUrls.completeTwoFactorAuthentication,
        true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        UserInfoUpdated res = userInfoUpdatedFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> getSingleUserDetails(String request) async {
    var response = await postRequest(
        null, "${AppUrls.getSingleUserDetails}?user_id=$request",
        true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        UserDetailsInfo res = userDetailsInfoFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    }
    else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
}