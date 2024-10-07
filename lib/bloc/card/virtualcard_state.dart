part of 'virtualcard_bloc.dart';

sealed class VirtualcardState extends Equatable {
  const VirtualcardState();
}

final class VirtualcardInitial extends VirtualcardState {
  @override
  List<Object> get props => [];
}

class VirtualcardIsLoading extends VirtualcardState{
  @override
  List<Object> get props =>[];
}

class VirtualcardError extends VirtualcardState{
  final DefaultApiResponse errorResponse;
  const VirtualcardError(this.errorResponse);
  @override
  List<Object?> get props => [errorResponse];
}

class AllUserVirtualCards extends VirtualcardState{
  final List<UserVirtualCards> response;
  const AllUserVirtualCards(this.response);
  @override
  List<Object?> get props => [response];
}

class AllCardTransactions extends VirtualcardState{
  final CardTransaction response;
  const AllCardTransactions(this.response);
  @override
  List<Object?> get props => [response];
}

class CardCreationSuccessful extends VirtualcardState{
  final VirtualCardSuccesful response;
  const CardCreationSuccessful(this.response);
  @override
  List<Object?> get props => [response];
}

class CardTopUpSuccessful extends VirtualcardState{
  final TopUpCardSuccessful response;
  const CardTopUpSuccessful(this.response);
  @override
  List<Object?> get props => [response];
}

class CardFreezeSuccessful extends VirtualcardState{
  final FreezeCardSuccess response;
  const CardFreezeSuccessful(this.response);
  @override
  List<Object?> get props => [response];
}

class CardUnFreezeSuccessful extends VirtualcardState{
  final FreezeCardSuccess response;
  const CardUnFreezeSuccessful(this.response);
  @override
  List<Object?> get props => [response];
}