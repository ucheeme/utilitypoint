import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:utilitypoint/utils/device_util.dart';
import 'package:utilitypoint/view/onboarding_screen/signUp/verifyemail.dart';

import '../model/defaultModel.dart';
import '../model/response/errorResponse.dart';
import '../services/api_service.dart';
import '../services/api_service.dart';
import '../services/api_status.dart';
import '../services/appUrl.dart';
import '../utils/app_util.dart';
import '../view/onboarding_screen/signIn/login_screen.dart';

class DefaultRepository{

  DefaultApiResponse? _errorResponse;
  DefaultApiResponse? get errorResponse => _errorResponse;
  setErrorResponse(DefaultApiResponse? value) {
    _errorResponse = value;
    if (value?.errors  != null){
      var res = jsonDecode(value?.errors);
      if (res['errors'].isNotEmpty) {
        _errorResponse?.message =
        "${res.publicMessage} ";
      }else{
        if(value!.message.toLowerCase().contains("unauthenticated")){
          _errorResponse?.message = "Please Login again";
        }else {
          _errorResponse?.message = value!.message;
        }
      }
    }
  }

  handleErrorResponse(dynamic response) {
    if (response is Failure) {
      if (response.errorResponse is DefaultApiResponse) {
        try {

          setErrorResponse(response.errorResponse as DefaultApiResponse);
        }
        catch (e) {
          setErrorResponse(AppUtils.defaultErrorResponse(msg: e.toString()));
        }
      }else{
        setErrorResponse(AppUtils.defaultErrorResponse(msg: "error response is not a same type with DefaultApiResponse"));
      }
    }
    else if(response is ForbiddenAccess){
      setErrorResponse(AppUtils.defaultErrorResponse(msg: "Access denied"));
    }else if(response is UnExpectedError){
      setErrorResponse(AppUtils.defaultErrorResponse(msg: "Unplanned error"));
    }else if(response is NetWorkFailure){
      setErrorResponse(AppUtils.defaultErrorResponse(msg: "Network not available"));
    }
  }


  Object handleSuccessResponse(dynamic response) {
    if (response is DefaultApiResponse) {
      var r = response;//defaultApiResponseFromJson(response.response as String);
      return r;
    }else{
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> postRequest(request, url, requiresToken, HttpMethods method) async {
    var response = await ApiService.makeApiCall(request, url,requireAccess:
    requiresToken, requestType: method,
        baseUrl: AppUrls.baseUrl);
    print("this is the response: $response");
    if(response is Success) {
      var r = defaultApiResponseFromJson(response.response as String);
      if(r.code.toString()=="700"){
        NewErrorResponse res = newErrorResponseFromJson(json.encode(r.data));
        accessToken = res.token;
        Future.delayed((Duration(seconds: 3)),(){
          Get.to(SignInPage());
        });
       return DefaultApiResponse(message: r.message, status: false, code: r.code);
      }
      if(r.code.toString()=="800"){
        NewErrorResponse res = newErrorResponseFromJson(json.encode(r.data));
        accessToken = res.token;
        String deviceIdTemp = deviceId;
        deviceId = res.deviceIdN!;
        print("this is the deviceId: ${res.deviceIdN}");
        Future.delayed((Duration(seconds: 3)),(){
         Get.to(VerifyEmail(isFromSignInPage: true,));
        });
        return DefaultApiResponse(message: r.message, status: false, code: r.code);
      }
      return r;
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> postRequestImage(request, url, requiresToken, HttpMethods method) async {
    var response = await ApiService.uploadDoc(request, url,);
    print("this is the resposee: $response");
    if(response is Success) {
      var r = defaultApiResponseFromJson(response.response as String);
      if(r.code.toString()=="700"){
        NewErrorResponse res = newErrorResponseFromJson(json.encode(r.data));
        accessToken = res.token;
        Future.delayed((Duration(seconds: 3)),(){
          Get.to(SignInPage());
        });
        return DefaultApiResponse(message: r.message, status: false, code: r.code);
      }
      if(r.code.toString()=="800"){
        NewErrorResponse res = newErrorResponseFromJson(json.encode(r.data));
        accessToken = res.token;
        Future.delayed((Duration(seconds: 3)),(){
          Get.to(VerifyEmail(isFromSignInPage: true,));
        });
        return DefaultApiResponse(message: r.message, status: false, code: r.code);
      }
      return r;
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
}