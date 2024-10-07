part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetTransactionHistoryEvent extends ProductEvent {
  final GetProductRequest request;
  const GetTransactionHistoryEvent(this.request);
  @override
  List<Object?> get props => [];
}

class GetAllNetworkEvent extends ProductEvent {
  const GetAllNetworkEvent();
  @override
  List<Object?> get props => [];
}

class GetAllProductEvent extends ProductEvent {
  const GetAllProductEvent();
  @override
  List<Object?> get props => [];
}

class GetAllDataProductPlanCategoryEvent extends ProductEvent {
  final GetProductRequest request;
  const GetAllDataProductPlanCategoryEvent(this.request);
  @override
  List<Object?> get props => [];
}

class GetAllDataProductPlanEvent extends ProductEvent {
  final GetProductRequest request;
  const GetAllDataProductPlanEvent(this.request);
  @override
  List<Object?> get props => [];
}