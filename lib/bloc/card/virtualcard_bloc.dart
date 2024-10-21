import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utilitypoint/bloc/card/cardValidator.dart';
import 'package:utilitypoint/model/request/convertNairaRequest.dart';
import 'package:utilitypoint/model/request/getUserRequest.dart';
import 'package:utilitypoint/repository/card_repository.dart';
import 'package:utilitypoint/view/menuOption/convertFunds/reviewOrder.dart';

import '../../model/defaultModel.dart';
import '../../model/request/createCard.dart';
import '../../model/request/generateBankAcct.dart';
import '../../model/request/getProduct.dart';
import '../../model/request/topUpCard.dart';
import '../../model/request/unfreezeCard.dart';
import '../../model/response/cardTransactions.dart';
import '../../model/response/createVirtualAcctNum.dart';
import '../../model/response/exchangeRate.dart';
import '../../model/response/freezeUnFreezeResponse.dart';
import '../../model/response/listofVirtualCard.dart';
import '../../model/response/nairaFundingOptions.dart';
import '../../model/response/top_up_card.dart';
import '../../model/response/userDetails.dart';
import '../../model/response/userVirtualAccounts.dart';
import '../../model/response/virtualCardSuccessful.dart';
import '../../utils/app_util.dart';

part 'virtualcard_event.dart';
part 'virtualcard_state.dart';

class VirtualcardBloc extends Bloc<VirtualcardEvent, VirtualcardState> {
  final CardRepository cardRepository;
  var errorObs = PublishSubject<String>();
  Cardvalidator validation = Cardvalidator();
  VirtualcardBloc({required this.cardRepository}) : super(VirtualcardInitial()) {
    on<VirtualcardEvent>((event, emit) {});
    on<GetCardTransactionHistoryEvent>((event,emit){
      handleGetCardTransactionHistoryEvent(event.request);
    });
    on<GetUserCardEvent>((event,emit){handleGetUserCardEvent(event.request);});
    on<CreateCardEvent>((event,emit){handleCreateCardEvent(event.request);});
    on<GetNairaFundingOptionsEvent>((event,emit){handleGetNairaFundingOptionEvent();});
    on<FundCardEvent>((event,emit){handleFundCardEvent(event.request);});
    on<FreezeCardEvent>((event,emit){handleFreezeCardEvent(event.request);});
    on<UnFreezeCardEvent>((event,emit){handleUnFreezeCardEvent(event.request);});
    on<GetExchangeRateEvent>((event,emit){handleGetExchangeRateEvent();});
    on<BuyDollarEvent>((event,emit){handleBuyDollarEvent(event.request);});
    on<GetUserVirtualAccountEvent>((event,emit){handleGetUserVirtualAccountEvent(event.request);});
    on<CreateUserVirtualAccountEvent>((event,emit){handleCreateUserVirtualAccountEvent(event.request);});
  }

  void handleGetCardTransactionHistoryEvent(GetProductRequest event)async{
    emit(VirtualcardIsLoading());
    try {
      final   response = await cardRepository.getCardTransactions(event);
      if (response is CardTransaction) {
        emit(AllCardTransactions(response));
        AppUtils.debug("success");
      }else{
        emit(VirtualcardError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(VirtualcardError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleBuyDollarEvent(ConvertNairaToDollarRequest event)async{
    emit(VirtualcardIsLoading());
    try {
      final   response = await cardRepository.buyDollar(event);
      if (response is DefaultApiResponse) {
        emit(SuccessfullyBoughtDollar(response));
        AppUtils.debug("success");
      }else{
        emit(VirtualcardError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(VirtualcardError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetExchangeRateEvent()async{
    emit(VirtualcardIsLoading());
    try {
      final   response = await cardRepository.getExchangeRate();
      if (response is FetchCurrencyConversionRate) {
        emit(ExchangeRate(response));
        AppUtils.debug("success");
      }else{
        emit(VirtualcardError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(VirtualcardError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetUserCardEvent(GetUserIdRequest event)async{
    emit(VirtualcardIsLoading());
    try {
      final   response = await cardRepository.getUserCards(event);
      if (response is List<UserVirtualCards>) {
        emit(AllUserVirtualCards(response));
        AppUtils.debug("success");
      }else{
        emit(VirtualcardError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(VirtualcardError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleCreateCardEvent(CreateCardRequest event)async{
    emit(VirtualcardIsLoading());
    try {
      final   response = await cardRepository.createCard(event);
      if (response is VirtualCardSuccesful ) {
        emit(CardCreationSuccessful(response));
        AppUtils.debug("success");
      }else{
        emit(VirtualcardError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      // print(trace);
      emit(VirtualcardError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetNairaFundingOptionEvent()async{
    emit(VirtualcardIsLoading());
    try {
      final   response = await cardRepository.getNairaFundingOptions();
      if (response is List<NairaFundingOptions> ) {
        emit(NairaFundingOptionFound(response));
        AppUtils.debug("success");
      }else{
        emit(VirtualcardError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      // print(trace);
      emit(VirtualcardError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleFundCardEvent(TopUpCardRequest event)async{
    emit(VirtualcardIsLoading());
    try {
      final   response = await cardRepository.fundCard(event);
      if (response is TopUpCardSuccessful ) {
        emit(CardTopUpSuccessful(response));
        AppUtils.debug("success");
      }else{
        emit(VirtualcardError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(VirtualcardError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleFreezeCardEvent(FreezeUnfreezeCard event)async{
    emit(VirtualcardIsLoading());
    try {
      final   response = await cardRepository.freezeCard(event);
      if (response is FreezeCardSuccess ) {
        emit(CardFreezeSuccessful(response));
        AppUtils.debug("success");
      }else{
        emit(VirtualcardError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(VirtualcardError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleUnFreezeCardEvent(FreezeUnfreezeCard event)async{
    emit(VirtualcardIsLoading());
    try {
      final   response = await cardRepository.unfreezeCard(event);
      if (response is FreezeCardSuccess ) {
        emit(CardUnFreezeSuccessful(response));
        AppUtils.debug("success");
      }else{
        emit(VirtualcardError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(VirtualcardError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetUserVirtualAccountEvent( event)async{
    emit(VirtualcardIsLoading());
    try {
      final   response = await cardRepository.getUserVirtualAccounts(event);
      if (response is  List<UserVirtualAccouts>) {
        emit(AllUserVirtualAccounts(response));
        AppUtils.debug("success");
      }else{
        emit(VirtualcardError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(VirtualcardError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleCreateUserVirtualAccountEvent( event)async{
    emit(VirtualcardIsLoading());
    try {
      final   response = await cardRepository.createVirtualAccount(event);
      if (response is CreateVirtualAccountNumberSuccess) {
        emit(UserVirtualAccountGenerated(response));
        AppUtils.debug("success");
      }else{
        emit(VirtualcardError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(VirtualcardError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }

  initial(){
    emit(VirtualcardInitial());
  }
}
