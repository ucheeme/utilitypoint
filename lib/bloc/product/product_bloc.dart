import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utilitypoint/model/request/buyCableSubscriptionRequest.dart';
import 'package:utilitypoint/model/request/confirmElectricityMeterOrCableName.dart';
import 'package:utilitypoint/model/response/userDetails.dart';
import 'package:utilitypoint/model/response/userSetting.dart';

import '../../model/defaultModel.dart';
import '../../model/request/buyAirtimeData.dart';
import '../../model/request/buyElectricity.dart';
import '../../model/request/getProduct.dart';
import '../../model/response/buyAirtimeDataResponse.dart';
import '../../model/response/buy_electricity_response.dart';
import '../../model/response/confirmSmartCardMeterNameResponse.dart';
import '../../model/response/dataPlanCategory.dart';
import '../../model/response/dataPlanResponse.dart';
import '../../model/response/exchangeRate.dart';
import '../../model/response/networksList.dart';
import '../../model/response/products.dart';
import '../../model/response/airtimeDatatransactionHistory.dart';
import '../../repository/productsRepository.dart';
import '../../utils/app_util.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final Productsrepository productRepository;
  var errorObs = PublishSubject<String>();
  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {});
    // on<GetProductTransactionHistoryEvent>((event,emit){
    //   handleGetTransactionHistory(event.request);
    // });
    on<GetAllNetworkEvent>((event,emit){handleGetAllNetwork();});
    on<GetUserSettingsEvent>((event,emit){handleGetUserSetting();});
    on<GetAllProductEvent>((event,emit){handleGetAllProducts();});
    on<GetAllProductPlanCategoryEvent>((event,emit){handleGetAllDataProductPlanCategoryEvent(event.request);});
    on<GetAllProductPlanEvent>((event,emit){handleGetAllDataProductPlanEvent(event.request);});
    on<GetProductTransactionHistoryEvent>((event,emit){handleGetProductTransactionHistoryEvent(event.request);});
    on<GetUserDetails>((event,emit){handleGetUserDetails(event.request);});
    on<BuyAirtimeEvent>((event,emit){handleBuyAirtimeEvent(event.request);});
    on<BuyDataEvent>((event,emit){handleBuyDataEvent(event.request);});
    on<BuyCableSubscriptionEvent>((event,emit){handleBuyCableSubscriptionEvent(event.request);});
    on<BuyElectricityEvent>((event,emit){handleElectricityEvent(event.request);});
    on<ConfirmMeterNameEvent>((event,emit){handleConfirmMeterNameEvent(event.request);});
    on<ConfirmCableNameEvent>((event,emit){handleConfirmCableNameEvent(event.request);});
    on<GetExchangeRateEvent>((event,emit){handleGetExchangeRateEvent();});
  }
  void handleGetTransactionHistory(GetProductRequest event)async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.getTransactionHistory(event);
      if (response is List<ProductTransactionList>) {
        emit(ProductTransactionHistory(response));
        AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetAllNetwork()async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.getNetwork();
      if (response is List<NetworkList>) {
        emit(ProductAllNetworks(response));
        AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetUserSetting()async{
 //   emit(ProductIsLoading());
    try {
      final   response = await productRepository.getUserSetting();
      if (response is List<UserGeneralSettings>) {
        emit(GeneralSettings(response));
        AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetAllProducts()async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.getProduct();
      if (response is  List<Products>) {
        emit(AllProduct(response));
        AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetAllDataProductPlanCategoryEvent(GetProductRequest event)async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.getProductPlanCategory(event);
      if (response is List<ProductPlanCategoryItem>) {
        emit(AllProductPlanCategories(response));
        AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetAllDataProductPlanEvent(GetProductRequest event)async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.getProductPlans(event);
      if (response is  List<ProductPlanItemResponse>) {
        emit(AllProductPlanSuccess(response));
       AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetProductTransactionHistoryEvent(GetProductRequest event)async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.getTransactionHistory(event);
      if (response is  List<ProductTransactionList>) {
        emit(AirtimeDataTransactionHistorySuccess(response));
       AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetUserDetails(GetProductRequest event)async{
    //emit(ProductIsLoading());
    print("Year");
    try {
      final   response = await productRepository.getUserDetails(event);
      if (response is UserDetails) {
        emit(AllUserDetails(response));
       AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleBuyAirtimeEvent(BuyAirtimeDataRequest event)async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.buyAirtime(event);
      if (response is BuyAirtimeDataResponse) {
        emit(AirtimeBought(response));
       AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleBuyDataEvent(BuyAirtimeDataRequest event)async{
    emit(ProductIsLoading());

    try {
      final   response = await productRepository.buyData(event);
      if (response is BuyAirtimeDataResponse) {
        emit(DataBought(response));
       AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleElectricityEvent(BuyElectricityRequest event)async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.buyElectric(event);
      if (response is BuyAirtimeDataResponse) {
        emit(ElectricityBought(response));
       AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleBuyCableSubscriptionEvent(BuyCableSubscriptionRequest event)async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.buyCableSub(event);
      if (response is BuyAirtimeDataResponse) {
        emit(CableRechargeBought(response));
       AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleConfirmCableNameEvent(ConfirmMeterOrCableNameRequest event)async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.confirmCableName(event);
      if (response is ConfirmSmartCardMeterNameResponse) {
        emit(CableNameConfirm(response));
       AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleConfirmMeterNameEvent(ConfirmMeterOrCableNameRequest event)async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.confirmMeterName(event);
      if (response is ConfirmSmartCardMeterNameResponse) {
        emit(MeterNameConfirm(response));
       AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }

  void handleGetExchangeRateEvent()async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.getExchangeRate();
      if (response is FetchCurrencyConversionRate) {
        emit(ProductExchangeRate(response) );
        AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  initial(){
    emit(ProductInitial());
  }

}
