part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProductTransactionHistoryEvent extends ProductEvent {
  final GetProductRequest request;
  const GetProductTransactionHistoryEvent(this.request);
  @override
  List<Object?> get props => [];
}

class GetAllNetworkEvent extends ProductEvent {
  const GetAllNetworkEvent();
  @override
  List<Object?> get props => [];
}
class GetUserSettingsEvent extends ProductEvent {
  const GetUserSettingsEvent();
  @override
  List<Object?> get props => [];
}

class GetAllProductEvent extends ProductEvent {
  const GetAllProductEvent();
  @override
  List<Object?> get props => [];
}

class GetAllProductPlanCategoryEvent extends ProductEvent {
  final GetProductRequest request;
  const GetAllProductPlanCategoryEvent(this.request);
  @override
  List<Object?> get props => [];
}

class GetAllProductPlanEvent extends ProductEvent {
  final GetProductRequest request;
  const GetAllProductPlanEvent(this.request);
  @override
  List<Object?> get props => [];
}

class GetUserDetails extends ProductEvent{
  final GetProductRequest request;
  const GetUserDetails(this.request);
  @override
  List<Object?> get props => [];
}

class BuyAirtimeEvent extends ProductEvent{
  final BuyAirtimeDataRequest request;
  const BuyAirtimeEvent(this.request);
  @override
  List<Object?> get props => [];
}

class BuyDataEvent extends ProductEvent{
  final BuyAirtimeDataRequest request;
  const BuyDataEvent(this.request);
  @override
  List<Object?> get props => [];
}

class ConfirmMeterNameEvent extends ProductEvent{
  final ConfirmMeterOrCableNameRequest request;
  const ConfirmMeterNameEvent(this.request);
  @override
  List<Object?> get props => [];
}

class ConfirmCableNameEvent extends ProductEvent{
  final ConfirmMeterOrCableNameRequest request;
  const ConfirmCableNameEvent(this.request);
  @override
  List<Object?> get props => [];
}

class BuyCableSubscriptionEvent extends ProductEvent{
  final BuyCableSubscriptionRequest request;
  const BuyCableSubscriptionEvent(this.request);
  @override
  List<Object?> get props => [];
}
class BuyElectricityEvent extends ProductEvent{
  final BuyElectricityRequest request;
  const BuyElectricityEvent(this.request);
  @override
  List<Object?> get props => [];
}

class GetExchangeRateEvent extends ProductEvent {

  const GetExchangeRateEvent();
  @override
  List<Object?> get props => [];
}

class GetAllNairaWalletTransactionsEvent extends ProductEvent {
  final GetProductRequest request;
  const GetAllNairaWalletTransactionsEvent(this.request);
  @override
  List<Object?> get props => [];
}

class GetAllDollarWalletTransactionsEvent extends ProductEvent {
  final GetProductRequest request;
  const GetAllDollarWalletTransactionsEvent(this.request);
  @override
  List<Object?> get props => [];
}

class GetAllUserUploadedKYCEvent extends ProductEvent {
  final GetProductRequest request;
  const GetAllUserUploadedKYCEvent(this.request);
  @override
  List<Object?> get props => [];
}

class GetUserKYCStatusEvent extends ProductEvent {
  final GetProductRequest request;
  const GetUserKYCStatusEvent(this.request);
  @override
  List<Object?> get props => [];
}

class UploadUserKYCEvent extends ProductEvent {
  final GetProductRequest request;
  const UploadUserKYCEvent(this.request);
  @override
  List<Object?> get props => [];
}

class VerifyBVNEvent extends ProductEvent {
  final GetProductRequest request;
  const VerifyBVNEvent(this.request);
  @override
  List<Object?> get props => [];
}
class ValidateBVNOTPEvent extends ProductEvent {
  final ValidateBvnOtpRequest request;
  const ValidateBVNOTPEvent(this.request);
  @override
  List<Object?> get props => [];
}