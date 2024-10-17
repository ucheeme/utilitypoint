import 'dart:convert';

import '../model/defaultModel.dart';
import '../services/api_service.dart';
import '../services/api_status.dart';
import '../services/appUrl.dart';
import '../utils/app_util.dart';

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
    print("this is the resposee: $response");
    if(response is Success) {
      var r = defaultApiResponseFromJson(response.response as String);
      return r;
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
}