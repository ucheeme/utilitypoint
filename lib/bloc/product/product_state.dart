part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();
}

final class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductIsLoading extends ProductState{
  @override
  List<Object> get props =>[];
}

class ProductError extends ProductState{
  final DefaultApiResponse errorResponse;
  const ProductError(this.errorResponse);
  @override
  List<Object?> get props => [errorResponse];
}

class ProductTransactionHistory extends ProductState{
  List<ProductTransactionList> response;
   ProductTransactionHistory(this.response);
  @override
  List<Object?> get props =>[response];
}

class ProductAllNetworks extends ProductState{
  List<NetworkList> response;
  ProductAllNetworks(this.response);
  @override
  List<Object?> get props =>[response];
}

class GeneralSettings extends ProductState{
  List<UserGeneralSettings> response;
  GeneralSettings(this.response);
  @override
  List<Object?> get props =>[response];
}

class AllProduct extends ProductState{
  List<Products> response;
  AllProduct(this.response);
  @override
  List<Object?> get props =>[response];
}

class AllProductPlanCategories extends ProductState{
  List<ProductPlanCategoryItem> response;
  AllProductPlanCategories(this.response);
  @override
  List<Object?> get props =>[response];
}

class AllProductPlanSuccess extends ProductState{
  List<ProductPlanItemResponse> response;
  AllProductPlanSuccess(this.response);
  @override
  List<Object?> get props =>[response];
}
class AirtimeDataTransactionHistorySuccess extends ProductState{
  List<ProductTransactionList> response;
  AirtimeDataTransactionHistorySuccess(this.response);
  @override
  List<Object?> get props =>[response];
}

class AllUserDetails extends ProductState{
  UserDetails response;
  AllUserDetails(this.response);
  @override
  List<Object?> get props =>[response];
}
class AirtimeBought extends ProductState{
  BuyAirtimeDataResponse response;
  AirtimeBought(this.response);
  @override
  List<Object?> get props =>[response];
}
class DataBought extends ProductState{
  BuyAirtimeDataResponse response;
  DataBought(this.response);
  @override
  List<Object?> get props =>[response];
}

class CableNameConfirm extends ProductState{
  ConfirmSmartCardMeterNameResponse response;
  CableNameConfirm(this.response);
  @override
  List<Object?> get props =>[response];
}

class MeterNameConfirm extends ProductState{
  final ConfirmSmartCardMeterNameResponse response;
  const MeterNameConfirm(this.response);
  @override
  List<Object?> get props =>[response];
}

class ElectricityBought extends ProductState{
  final BuyAirtimeDataResponse response;
  const ElectricityBought(this.response);
  @override
  List<Object?> get props =>[response];
}

class CableRechargeBought extends ProductState{
  final BuyAirtimeDataResponse response;
  const CableRechargeBought(this.response);
  @override
  List<Object?> get props =>[response];
}
class ProductExchangeRate extends ProductState{
  final FetchCurrencyConversionRate response;
  const ProductExchangeRate(this.response);
  @override
  List<Object?> get props => [response];
}