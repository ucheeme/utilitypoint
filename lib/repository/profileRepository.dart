import 'dart:convert';

import 'package:utilitypoint/model/request/changePassword.dart';
import 'package:utilitypoint/model/request/resetPin.dart';
import 'package:utilitypoint/model/request/updateUserRequest.dart';
import 'package:utilitypoint/repository/apiRepository.dart';

import '../model/defaultModel.dart';
import '../model/response/updateUserResponse.dart';
import '../model/response/userInfoUpdated.dart';
import '../services/api_service.dart';
import '../services/appUrl.dart';

class ProfileRepository extends DefaultRepository{
   Future<Object> resetUserPassword(ChangeUserPasswordRequest request) async {
     var response = await postRequest(
         request, AppUrls.updateUserPassword, true, HttpMethods.post);
     var r = handleSuccessResponse(response);
     if (r is DefaultApiResponse) {
       if (r.status == true) {
         SecondDefaultResponse res =
         secondDefaultResponseFromJson(json.encode(r));
         return res;
       } else {
         return r;
       }
     } else {
       handleErrorResponse(response);
       return errorResponse!;
     }
   }
   Future<Object> changeUserPin(ResetUserPinRequest request) async {
     var response = await postRequest(
         request, AppUrls.resetUserPin, true, HttpMethods.post);
     var r = handleSuccessResponse(response);
     if (r is DefaultApiResponse) {
       if (r.status == true) {
         SecondDefaultResponse res =
         secondDefaultResponseFromJson(json.encode(r));
         return res;
       } else {
         return r;
       }
     } else {
       handleErrorResponse(response);
       return errorResponse!;
     }
   }
   Future<Object> updateUserDetails(UpdateUserDetailRequest request) async {
     var response = await postRequest(
         request, AppUrls.updateUserDetails, true, HttpMethods.post);
     var r = handleSuccessResponse(response);
     if (r is DefaultApiResponse) {
       if (r.status == true) {
         UpdateUserDetailResponse res =
         updateUserDetailResponseFromJson(json.encode(r.data));
         return res;
       } else {
         return r;
       }
     } else {
       handleErrorResponse(response);
       return errorResponse!;
     }
   }
}