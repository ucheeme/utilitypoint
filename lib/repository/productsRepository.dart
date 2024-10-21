import 'dart:convert';

import 'package:utilitypoint/model/defaultModel.dart';
import 'package:utilitypoint/model/request/buyAirtimeData.dart';
import 'package:utilitypoint/model/response/networksList.dart';
import 'package:utilitypoint/model/response/products.dart';
import 'package:utilitypoint/model/response/airtimeDatatransactionHistory.dart';
import 'package:utilitypoint/model/response/userDetails.dart';
import 'package:utilitypoint/model/response/userSetting.dart';
import 'package:utilitypoint/repository/apiRepository.dart';

import '../model/request/buyCableSubscriptionRequest.dart';
import '../model/request/buyElectricity.dart';
import '../model/request/confirmElectricityMeterOrCableName.dart';
import '../model/request/getProduct.dart';
import '../model/response/buyAirtimeDataResponse.dart';
import '../model/response/confirmSmartCardMeterNameResponse.dart';
import '../model/response/dataPlanCategory.dart';
import '../model/response/dataPlanResponse.dart';
import '../model/response/exchangeRate.dart';
import '../services/api_service.dart';
import '../services/appUrl.dart';

class Productsrepository extends DefaultRepository {
  Future<Object> getTransactionHistory(GetProductRequest request) async {
    var response = await postRequest(
        null,
        "${AppUrls.getTransactionHistory}?user_id=${request.userId}&date_from=${request.dateFrom}&date_to=${request.dateTo}",
        true,
        HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        List<ProductTransactionList> res =
            transactionListFromJson(json.encode(r.data));
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

  Future<Object> getNetwork() async {
    var response = await postRequest(
        null, AppUrls.getNetworks, true, HttpMethods.get);
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
        null, AppUrls.getUserSettings, true, HttpMethods.get);
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
        null, AppUrls.getProduct, true, HttpMethods.get);
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
        null, "${AppUrls.getProductDataPlanCategory}?network_id=${request.networkId}&product_slug=${request.productSlug}", true, HttpMethods.get);
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
        null, "${AppUrls.getProductPlans}?network_id=${request.networkId}&plan_category_id=${request.planCategoryId}&amount=${request.amount}&product_slug=${request.productSlug}&user_id=${request.userId}", true, HttpMethods.get);
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
        buyAirtimeResponseFromJson(json.encode(r));
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
        buyAirtimeResponseFromJson(json.encode(r));
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
        buyAirtimeResponseFromJson(json.encode(r));
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
        BuyAirtimeDataResponse res =
        buyAirtimeResponseFromJson(json.encode(r));
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
        null, AppUrls.getExchangeRate, true, HttpMethods.get);
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








}
