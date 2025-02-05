import 'dart:convert';

import 'package:utilitypoint/model/request/createCard.dart';
import 'package:utilitypoint/model/request/getUserRequest.dart';
import 'package:utilitypoint/model/request/topUpCard.dart';
import 'package:utilitypoint/model/request/unfreezeCard.dart';
import 'package:utilitypoint/model/response/createVirtualAcctNum.dart';

import '../bloc/card/virtualcard_bloc.dart';
import '../model/defaultModel.dart';
import '../model/request/convertNairaRequest.dart';
import '../model/request/generateBankAcct.dart';
import '../model/request/getProduct.dart';
import '../model/response/cardDetailInformation.dart';
import '../model/response/cardTransactions.dart';
import '../model/response/exchangeRate.dart';
import '../model/response/freezeUnFreezeResponse.dart';
import '../model/response/listofVirtualCard.dart';
import '../model/response/nairaFundingOptions.dart';
import '../model/response/top_up_card.dart';
import '../model/response/userVirtualAccounts.dart';
import '../model/response/virtualCardSuccessful.dart';
import '../services/api_service.dart';
import '../services/appUrl.dart';
import '../utils/device_util.dart';
import 'apiRepository.dart';

class CardRepository extends DefaultRepository{
  Future<Object> getUserCards(GetUserIdRequest request) async {
    var response = await postRequest(
        null, "${AppUrls.getUserCards}?user_id=${request.userId}&device_id=$deviceId", true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        List<UserVirtualCards> res =
        userVirtualCardsFromJson(json.encode(r.data));
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

 Future<Object> getNairaFundingOptions() async {
    var response = await postRequest(
        null, AppUrls.getNairaFunding, true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        List<NairaFundingOptions> res =
        nairaFundingOptionsFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> getCardTransactions(GetProductRequest request) async {
    var response = await postRequest(
        null, "${AppUrls.getCardTransaction}?user_id=${request.userId}&"
        "card_id=${request.cardId}&start_date=${request.startDate}&end_date=${request.endDate}"
        "&page_size=${request.pageSize}&page=${request.page}&device_id=$deviceId",
        true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        CardTransaction res =
        cardTransactionFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> getUserVirtualAccounts(GetProductRequest request) async {
    var response = await postRequest(
        null, "${AppUrls.getUserVirtualAccounts}?user_id=${request.userId}&"
        "pin=${request.pin}&device_id=$deviceId",
        true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        List<UserVirtualAccouts> res =
        userVirtualAccoutsFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }
  Future<Object> getUserSingleCardDetails(GetProductRequest request) async {
    var response = await postRequest(
        null, "${AppUrls.getSingleVirtualCard}?user_id=${request.userId}&"
        "card_id=${request.cardId}&device_id=$deviceId",
        true, HttpMethods.get);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        SingleCardInformation res =
        singleCardInformationFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> createCard(CreateCardRequest request) async {
    var response = await postRequest(
        request, AppUrls.createUserCard,
        true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        VirtualCardSuccesful res =
        virtualCardSuccesfulFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> createVirtualAccount(GenerateBankAccountRequest request) async {
    var response = await postRequest(
        request,AppUrls.createVirtualAcct,
        true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {

        CreateVirtualAccountNumberSuccess res =
        createVirtualAccountNumberSuccessFromJson(json.encode(r.data));
        if(res.success){
          return res;
        }else{
          return r;
        }

      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> fundCard(TopUpCardRequest request) async {
    var response = await postRequest(
        request, AppUrls.topUpCard,
        true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        TopUpCardSuccessful res =
        topUpCardSuccessfulFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> freezeCard(FreezeUnfreezeCard request) async {
    var response = await postRequest(request, AppUrls.freezeUserCard,
        true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        FreezeCardSuccess res =
        freezeCardSuccessFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> unfreezeCard(FreezeUnfreezeCard request) async {
    var response = await postRequest(request, AppUrls.unFreezeUserCard,
        true, HttpMethods.post);
    var r = handleSuccessResponse(response);
    if (r is DefaultApiResponse) {
      if (r.status == true) {
        FreezeCardSuccess res =
        freezeCardSuccessFromJson(json.encode(r.data));
        return res;
      } else {
        return r;
      }
    } else {
      handleErrorResponse(response);
      return errorResponse!;
    }
  }

  Future<Object> buyDollar(ConvertNairaToDollarRequest request) async {
    var response = await postRequest(request, AppUrls.buyDollar,
        true, HttpMethods.post);
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
}