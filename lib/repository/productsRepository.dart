import 'dart:convert';

import 'package:utilitypoint/model/defaultModel.dart';
import 'package:utilitypoint/model/response/networksList.dart';
import 'package:utilitypoint/model/response/products.dart';
import 'package:utilitypoint/model/response/transactionHistory.dart';
import 'package:utilitypoint/repository/apiRepository.dart';

import '../model/request/getProduct.dart';
import '../model/response/dataPlanCategory.dart';
import '../model/response/dataPlanResponse.dart';
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

  Future<Object> getProductDataPlanCategory(GetProductRequest request) async {
    var response = await postRequest(
        null, "${AppUrls.getProductDataPlanCategory}?network_id=${request.networkId}&product_slug=${request.productSlug}", true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        List<DataPlanCategory> res =
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
        List<DataPlanResponse> res =
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









}
