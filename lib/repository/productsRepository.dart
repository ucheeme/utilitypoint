import 'dart:convert';

import 'package:utilitypoint/model/defaultModel.dart';
import 'package:utilitypoint/model/request/buyAirtimeData.dart';
import 'package:utilitypoint/model/response/networksList.dart';
import 'package:utilitypoint/model/response/products.dart';
import 'package:utilitypoint/model/response/airtimeDatatransactionHistory.dart';
import 'package:utilitypoint/model/response/userDetails.dart';
import 'package:utilitypoint/model/response/userSetting.dart';
import 'package:utilitypoint/repository/apiRepository.dart';
import 'package:utilitypoint/view/home/home_screen.dart';
import 'package:utilitypoint/view/onboarding_screen/signIn/login_screen.dart';

import '../model/request/buyCableSubscriptionRequest.dart';
import '../model/request/buyElectricity.dart';
import '../model/request/bvnOtpValidate.dart';
import '../model/request/confirmElectricityMeterOrCableName.dart';
import '../model/request/getProduct.dart';
import '../model/response/buyAirtimeDataResponse.dart';
import '../model/response/bvnFinalVerification.dart';
import '../model/response/bvnValidationResponse.dart';
import '../model/response/confirmSmartCardMeterNameResponse.dart';
import '../model/response/dataPlanCategory.dart';
import '../model/response/dataPlanResponse.dart';
import '../model/response/electricResponse.dart';
import '../model/response/exchangeRate.dart';
import '../model/response/kycValidated.dart';
import '../model/response/nairaDollarTransactionList.dart';
import '../model/response/userKYCResponse.dart';
import '../model/response/validateBVNOTPResponse.dart';
import '../model/response/walletBalance.dart';
import '../services/api_service.dart';
import '../services/appUrl.dart';
import '../utils/device_util.dart';

class Productsrepository extends DefaultRepository {
  Future<Object> getTransactionHistory(GetProductRequest request) async {
    var response = await postRequest(
        request,
        "${AppUrls.getTransactionHistory}?user_id=${request.userId}&date_from=${request.dateFrom}&date_to=${request.dateTo}&device_id=$deviceId",
        true,
        HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        List<ProductTransactionList> res =
        productTransactionListFromJson(json.encode(r.data));
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
        "${AppUrls.getUserDetails}?user_id=${request.userId}&device_id=$deviceId",
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

  Future<Object> getNetwork() async {
    var response = await postRequest(
        null, "${AppUrls.getNetworks}", true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        List<NetworkList> res =
        networkListFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
  Future<Object> getUserSetting() async {
    var response = await postRequest(
        null, "${AppUrls.getUserSettings}", true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        List<UserGeneralSettings> res =
        userGeneralSettingsFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> getProduct() async {
    var response = await postRequest(
    null, "${AppUrls.getProduct}", true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        List<Products> res =
        productsFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> getProductPlanCategory(GetProductRequest request) async {
    var response = await postRequest(
        null, "${AppUrls.getProductDataPlanCategory}?network_id=${request.networkId}&product_slug=${request.productSlug}&device_id=$deviceId", true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        List<ProductPlanCategoryItem> res =
        dataPlanCategoryFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> getProductPlans(GetProductRequest request) async {
    var response = await postRequest(
        null, "${AppUrls.getProductPlans}?network_id=${request.networkId}&plan_category_id=${request.planCategoryId}&amount=${request.amount}&product_slug=${request.productSlug}&user_id=${request.userId}&device_id=$deviceId", true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        List<ProductPlanItemResponse> res =
        dataPlanResponseFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
  Future<Object> buyAirtime(BuyAirtimeDataRequest request) async {
    var response = await postRequest(
        request, AppUrls.buyAirtime, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        BuyAirtimeDataResponse res =
        buyAirtimeDataResponseFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
  Future<Object> buyData(BuyAirtimeDataRequest request) async {
    var response = await postRequest(
        request, AppUrls.buyData, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        BuyAirtimeDataResponse res =
        buyAirtimeDataResponseFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
  Future<Object> buyCableSub(BuyCableSubscriptionRequest request) async {
    var response = await postRequest(
        request, AppUrls.buyCableSub, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        BuyAirtimeDataResponse res =
        buyAirtimeDataResponseFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
  Future<Object> buyElectric(BuyElectricityRequest request) async {
    var response = await postRequest(
        request, AppUrls.buyElectricity, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        ElectricBoughtResponse res =
        electricBoughtResponseFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
  Future<Object> confirmMeterName(ConfirmMeterOrCableNameRequest request) async {
    var response = await postRequest(
        request, AppUrls.confirmElectricityMeterName, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        ConfirmSmartCardMeterNameResponse res =
        confirmSmartCardNameResponseFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
  Future<Object> confirmCableName(ConfirmMeterOrCableNameRequest request) async {
    var response = await postRequest(
        request, AppUrls.confirmSmartCableName, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        ConfirmSmartCardMeterNameResponse res =
        confirmSmartCardNameResponseFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> getExchangeRate() async {
    var response = await postRequest(
        null, "${AppUrls.getExchangeRate}", true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        FetchCurrencyConversionRate res =
        fetchCurrenctConversionRateFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> getNairaTransactions(GetProductRequest request) async {
    var response = await postRequest(
        null, "${AppUrls.getNairaTransactions}?user_id=${request.userId}&start_date=${request.startDate}&end_date=${request.endDate}&device_id=$deviceId", true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        List<NairaTransactionList> res =
        nairaTransactionListFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
  Future<Object> getDollarsTransactions(GetProductRequest request) async {
    var response = await postRequest(
        null, "${AppUrls.getDollarsTransactions}?user_id=${request.userId}&start_date=${request.startDate}&end_date=${request.endDate}&device_id=$deviceId", true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        List<NairaTransactionList> res =
        nairaTransactionListFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> getUserKYCUploads(GetProductRequest request) async {
    var response = await postRequest(
        null, "${AppUrls.getUserUploadedKYC}?user_id=${request.userId}&device_id=$deviceId", true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        UserKycResponse? res;
        if(r.data==null){
          res = UserKycResponse(id: "",
              userId: loginResponse!.id,
              nin: null, driversLicense: null,
              votersCard: null,
              profilePicture:userDetails==null? "assets/image/images_png/tempImage.png": userDetails!.profilePic,
              internationalPassport: null,
              verificationStatus: 0,
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

  Future<Object?> getUserKYCStatus(GetProductRequest request) async {
    var response = await postRequest(
        null, "${AppUrls.getUSerKYCVerificationStatus}?user_id=${request.userId}&device_id=$deviceId", true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        UserKycResponse? res;
        if(r.data==null){
          res = UserKycResponse(id: "",
              userId: loginResponse!.id,
              nin: null, driversLicense: null,
              votersCard: null,
              profilePicture:userDetails==null? "assets/image/images_png/tempImage.png":userDetails!.profilePic,
              internationalPassport: null,
              verificationStatus: 0,
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

  Future<Object> uploadKYC(GetProductRequest request) async {
    var response = await postRequestImage(
        request, AppUrls.uploadKYCDocumentC, true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        KycVerificationResponse res =
        kycVerificationResponseFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
  Future<Object> verifyBVN(GetProductRequest request) async {
    var response = await postRequest(
        request,AppUrls.uploadBVNDocumentC , true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        BvnValidationResponse res =
        bvnValidationResponseFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
  Future<Object> validateBVNOTP(ValidateBvnOtpRequest request) async {
    var response = await postRequest(
        request,AppUrls.validateBvnOtp , true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        BvnFinalVerified res =
        bvnFinalVerifiedFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> getWalletBalance(String request)async{
    var response = await postRequest(
        null, "${AppUrls.getUserWalletBalance}?user_id=$request&device_id=$deviceId", true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if(r is DefaultApiResponse){
      if(r.status == true){
        WalletBalanceResponse res = walletBalanceResponseFromJson(json.encode(r.data));
        return res;
      }else{
        return r;
      }
    }else{
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

}
GetProductRequest getProductRequest = GetProductRequest();