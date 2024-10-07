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

class AllProduct extends ProductState{
  List<Products> response;
  AllProduct(this.response);
  @override
  List<Object?> get props =>[response];
}

class AllDataProductPlanCategories extends ProductState{
  List<DataPlanCategory> response;
  AllDataProductPlanCategories(this.response);
  @override
  List<Object?> get props =>[response];
}

class AllProductPlanSuccess extends ProductState{
  List<DataPlanResponse> response;
  AllProductPlanSuccess(this.response);
  @override
  List<Object?> get props =>[response];
}