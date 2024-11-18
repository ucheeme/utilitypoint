import 'dart:convert';

import 'package:utilitypoint/bloc/profile/profile_bloc.dart';
import 'package:utilitypoint/model/request/changePassword.dart';
import 'package:utilitypoint/model/request/getProduct.dart';
import 'package:utilitypoint/model/request/markAsReadUnread/markReadUnRead.dart';
import 'package:utilitypoint/model/request/resetPin.dart';
import 'package:utilitypoint/model/request/updateUserRequest.dart';
import 'package:utilitypoint/model/request/userAlertRequest.dart';
import 'package:utilitypoint/model/response/allUserNotification.dart';
import 'package:utilitypoint/model/response/faqResponse.dart';
import 'package:utilitypoint/model/response/markReadUnReadesponse.dart';
import 'package:utilitypoint/repository/apiRepository.dart';

import '../model/defaultModel.dart';
import '../model/request/logOutRequest.dart';
import '../model/response/updateUserResponse.dart';
import '../model/response/userAlertResponse.dart';
import '../model/response/userDetails.dart';
import '../model/response/userInfoUpdated.dart';
import '../model/response/userKYCResponse.dart';
import '../services/api_service.dart';
import '../services/appUrl.dart';
import '../view/home/home_screen.dart';
import '../view/onboarding_screen/signIn/login_screen.dart';

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
   Future<Object> logOutUser(LogOutRequest request) async {
     var response = await postRequest(
         request, AppUrls.logOut, true, HttpMethods.post);
     var r = handleSuccessResponse(response);
     if (r is DefaultApiResponse) {
       if (r.status == true) {
         DefaultApiResponse res =
         defaultApiResponseFromJson(json.encode(r));
         return res;
       } else {
         return r;
       }
     } else {
       handleErrorResponse(response);
       return errorResponse!;
     }
   }
   Future<Object> markAsReadUnRead(MarkAsReadUnReadRequest request) async {
     var response = await postRequest(
         request, AppUrls.markNotification, true, HttpMethods.post);
     var r = handleSuccessResponse(response);
     if (r is DefaultApiResponse) {
       if (r.status == true) {
         MarkAsReadUnReadResponse res =
         markAsReadUnReadResponseFromJson(json.encode(r.data));
         return res;
       } else {
         return r;
       }
     } else {
       handleErrorResponse(response);
       return errorResponse!;
     }
   }
   Future<Object> markAsRead(MarkAsReadUnReadRequest request) async {
     var response = await postRequest(
         request, AppUrls.markNotification, true, HttpMethods.post);
     var r = handleSuccessResponse(response);
     if (r is DefaultApiResponse) {
       if (r.status == true) {
         MarkAsReadUnReadResponse res =
         markAsReadUnReadResponseFromJson(json.encode(r.data));
         return res;
       } else {
         return r;
       }
     } else {
       handleErrorResponse(response);
       return errorResponse!;
     }
   }
   Future<Object> updateUserAppSetting(UserAlertNotificationRequest request) async {
     var response = await postRequest(
         request, AppUrls.updateAppSetting, true, HttpMethods.post);
     var r = handleSuccessResponse(response);
     if (r is DefaultApiResponse) {
       if (r.status == true) {
         UserAlertResponse res =
       userAlertResponseFromJson(json.encode(r.data));
         return res;
       } else {
         return r;
       }
     } else {
       handleErrorResponse(response);
       return errorResponse!;
     }
   }
   Future<Object> getUserNotifications(GetProductRequest request) async {
     var response = await postRequest(
         request, "${AppUrls.getUserNotification}?user_id=${request.userId}&start_date=${request.startDate}&end_date=${request.endDate}", true, HttpMethods.get);
     var r = handleSuccessResponse(response);
     if (r is DefaultApiResponse) {
       if (r.status == true) {
         AllUserNotification res =
         allUserNotificationFromJson(json.encode(r.data));
         return res;
       } else {
         return r;
       }
     } else {
       handleErrorResponse(response);
       return errorResponse!;
     }
   }
   Future<Object> getFAQ( ) async {
     var response = await postRequest(null, AppUrls.getFAQ, true, HttpMethods.get);
     var r = handleSuccessResponse(response);
     if (r is DefaultApiResponse) {
       if (r.status == true) {
         List<FaqResponse> res = faqResponseFromJson(json.encode(r.data));
         return res;
       } else {
         return r;
       }
     } else {
       handleErrorResponse(response);
       return errorResponse!;
     }
   }

   Future<Object> getUserDetails(GetProductRequest request) async {
     var response = await postRequest(
         null,
         "${AppUrls.getUserDetails}?user_id=${request.userId}",
         true,
         HttpMethods.get);
     var r = handleSuccessResponse(response);
     if (r is DefaultApiResponse) {
       if (r.status == true) {
         UserDetails res =
         userDetailsFromJson(json.encode(r.data));
         return res;
       } else {
         return r;
       }
     } else {
       handleErrorResponse(response);
       return errorResponse!;
     }
   }
   Future<Object?> getUserKYCUploads(GetProductRequest request) async {
     var response = await postRequest(
         null, "${AppUrls.getUserUploadedKYC}?user_id=${request.userId}", true, HttpMethods.get);
     var r = handleSuccessResponse(response);
     if (r is DefaultApiResponse) {
       if (r.status == true) {
         UserKycResponse? res;
         if(r.data==null){
           res = UserKycResponse(id: "",
               userId: loginResponse!.id,
               nin: null, driversLicense: null,
               votersCard: null,
               verificationStatus: 0,
               profilePicture:userDetails==null? "assets/image/images_png/tempImage.png": userDetails!.profilePic,
               internationalPassport: null,
               createdAt: DateTime.now(),
               updatedAt: DateTime.now());
         }else{
           res= userKycResponseFromJson(json.encode(r.data));
         }
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