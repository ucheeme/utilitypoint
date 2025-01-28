import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utilitypoint/bloc/product/product_bloc.dart';
import 'package:utilitypoint/model/request/buyCableSubscriptionRequest.dart';
import 'package:utilitypoint/model/request/confirmElectricityMeterOrCableName.dart';
import 'package:utilitypoint/model/response/userDetails.dart';
import 'package:utilitypoint/model/response/userSetting.dart';

import '../../model/defaultModel.dart';
import '../../model/request/buyAirtimeData.dart';
import '../../model/request/buyElectricity.dart';
import '../../model/request/bvnOtpValidate.dart';
import '../../model/request/getProduct.dart';
import '../../model/response/buyAirtimeDataResponse.dart';
import '../../model/response/buy_electricity_response.dart';
import '../../model/response/bvnFinalVerification.dart';
import '../../model/response/bvnValidationResponse.dart';
import '../../model/response/confirmSmartCardMeterNameResponse.dart';
import '../../model/response/dataPlanCategory.dart';
import '../../model/response/dataPlanResponse.dart';
import '../../model/response/electricResponse.dart';
import '../../model/response/exchangeRate.dart';
import '../../model/response/kycValidated.dart';
import '../../model/response/nairaDollarTransactionList.dart';
import '../../model/response/networksList.dart';
import '../../model/response/products.dart';
import '../../model/response/airtimeDatatransactionHistory.dart';
import '../../model/response/userKYCResponse.dart';
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
    on<GetAllNairaWalletTransactionsEvent>((event,emit){handleGetAllNairaWalletTransactionsEvent(event.request);});
    on<GetAllDollarWalletTransactionsEvent>((event,emit){handleGetAllDollarWalletTransactionsEvent(event.request);});
    on<GetAllUserUploadedKYCEvent>((event,emit){handleGetAllUserUploadedKYCEvent(event.request);});
    on<GetUserKYCStatusEvent>((event,emit){handleGetUserKYCStatusEvent(event.request);});
    on<UploadUserKYCEvent>((event,emit){handleUploadUserKYCEvent(event.request);});
    on<VerifyBVNEvent>((event,emit){handleVerifyBVNEvent(event.request);});
    on<ValidateBVNOTPEvent>((event,emit){handleValidateBVNOTPEvent(event.request);});
   // on<GetAllUserUploadedKYCEvent>((event,emit){handleGetAllUserUploadedKYCEvent(event.request);});
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
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
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
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
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
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
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
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
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
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
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
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
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
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
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
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
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
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
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
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
    }
  }

  void handleElectricityEvent(BuyElectricityRequest event)async{
    emit(ProductIsLoading());
    try {
      final   response = await productRepository.buyElectric(event);
      if (response is ElectricBoughtResponse) {
        emit(ElectricityBought(response));
       AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
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
      print(e);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
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
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
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
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
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
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
    }
  }

  void handleGetAllNairaWalletTransactionsEvent(event)async{
    emit(ProductIsLoading());
    try {
      final response = await productRepository.getNairaTransactions(event);

      if (response is List<NairaTransactionList>) {
        emit(AllNairaTransactions(response) );
        AppUtils.debug("success");
      }else{
        if(response==[]){
          emit(AllNairaTransactions(const []) );
        }else{
          emit(ProductError(response as DefaultApiResponse));
          AppUtils.debug("error");
        }

      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
    }
  }

  void handleGetAllDollarWalletTransactionsEvent(event)async{
    emit(ProductIsLoading());
    try {
      final response = await productRepository.getDollarsTransactions(event);
      if (response is List<NairaTransactionList>) {
        emit(AllDollarTransactions(response) );
        AppUtils.debug("success");
      }else{
        if(response==[]){
          emit(AllDollarTransactions(const []) );
        }else{
          emit(ProductError(response as DefaultApiResponse));
          AppUtils.debug("error");
        }

      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
    }
  }

  void handleGetAllUserUploadedKYCEvent(event)async{
    emit(ProductIsLoading());
    try {
      final response = await productRepository.getUserKYCUploads(event);
      if (response is UserKycResponse) {
        emit(UserKYCs(response) );
        AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
    }
  }

  void handleGetUserKYCStatusEvent(event)async{
    emit(ProductIsLoading());
    try {
      final  response = await productRepository.getUserKYCStatus(event);
      if ((response is UserKycResponse) ) {
        emit(UserKYCVerificationStatus(response) );
        AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
    }
  }

  void handleUploadUserKYCEvent(event)async{
    emit(ProductIsLoading());
    try {
      final response = await productRepository.uploadKYC(event);
      if (response is KycVerificationResponse) {
        emit(KYCUpdated(response) );
        AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
    }
  }

  void handleVerifyBVNEvent(event)async{
    emit(ProductIsLoading());
    try {
      final response = await productRepository.verifyBVN(event);
      if (response is BvnValidationResponse) {
        emit(BVNVerified(response) );
        AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
    }
  }

  void handleValidateBVNOTPEvent(event)async{
    emit(ProductIsLoading());
    try {
      final response = await productRepository.validateBVNOTP(event);
      if (response is BvnFinalVerified) {
        emit(ValidateBvnOtp(response) );
        AppUtils.debug("success");
      }else{
        emit(ProductError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProductError(AppUtils.defaultErrorResponse(msg: "An Error Occurred")));
    }
  }

  initial(){
    emit(ProductInitial());
  }

}
