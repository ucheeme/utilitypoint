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

class NairaFundingOptionFound extends VirtualcardState{
  final List<NairaFundingOptions> response;
  const NairaFundingOptionFound(this.response);
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
class ExchangeRate extends VirtualcardState{
  final FetchCurrencyConversionRate response;
  const ExchangeRate(this.response);
  @override
  List<Object?> get props => [response];
}
class ExchangeRate2 extends VirtualcardState{
  final FetchCurrencyConversionRate response;
  const ExchangeRate2(this.response);
  @override
  List<Object?> get props => [response];
}

class SuccessfullyBoughtDollar extends VirtualcardState{
  final DefaultApiResponse response;
  const SuccessfullyBoughtDollar(this.response);
  @override
  List<Object?> get props => [response];
}

class AllUserVirtualAccounts extends VirtualcardState{
  final List<UserVirtualAccouts> response;
  const AllUserVirtualAccounts(this.response);
  @override
  List<Object?> get props => [response];
}

class UserVirtualAccountGenerated extends VirtualcardState{
  final CreateVirtualAccountNumberSuccess response;
  const UserVirtualAccountGenerated(this.response);
  @override
  List<Object?> get props => [response];
}

class SingleCardDetail extends VirtualcardState{
  final SingleCardInformation response;
  const SingleCardDetail(this.response);
  @override
  List<Object?> get props => [response];
}