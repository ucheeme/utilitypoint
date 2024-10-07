part of 'virtualcard_bloc.dart';

sealed class VirtualcardEvent extends Equatable {
  const VirtualcardEvent();
}

class GetCardTransactionHistoryEvent extends VirtualcardEvent {
  final GetProductRequest request;
  const GetCardTransactionHistoryEvent(this.request);
  @override
  List<Object?> get props => [];
}

class GetUserCardEvent extends VirtualcardEvent {
  final GetUserIdRequest request;
  const GetUserCardEvent(this.request);
  @override
  List<Object?> get props => [];
}

class CreateCardEvent extends VirtualcardEvent {
  final CreateCardRequest request;
  const CreateCardEvent(this.request);
  @override
  List<Object?> get props => [];
}

class FundCardEvent extends VirtualcardEvent {
  final TopUpCardRequest request;
  const FundCardEvent(this.request);
  @override
  List<Object?> get props => [];
}

class FreezeCardEvent extends VirtualcardEvent {
  final FreezeUnfreezeCard request;
  const FreezeCardEvent(this.request);
  @override
  List<Object?> get props => [];
}

class UnFreezeCardEvent extends VirtualcardEvent {
  final FreezeUnfreezeCard request;
  const UnFreezeCardEvent(this.request);
  @override
  List<Object?> get props => [];
}