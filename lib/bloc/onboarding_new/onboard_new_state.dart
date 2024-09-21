part of 'onboard_new_bloc.dart';

sealed class OnboardNewState extends Equatable {
  const OnboardNewState();
}

final class OnboardNewInitial extends OnboardNewState {
  @override
  List<Object> get props => [];
}

class OnboardingIsLoading extends OnboardNewState{
  @override
  List<Object> get props =>[];
}

class OnBoardingError extends OnboardNewState{
  final DefaultApiResponse errorResponse;
  const OnBoardingError(this.errorResponse);
  @override
  List<Object?> get props => [errorResponse];
}

class AccountCreated extends OnboardNewState{
  AccountCreatedResponse response;
  AccountCreated(this.response);
  @override
  List<Object?> get props =>[response];
}

class EmailVerified extends OnboardNewState{
  DefaultApiResponse response;
  EmailVerified(this.response);
  @override
  List<Object?> get props =>[response];
}

class ReSentEmailVerification extends OnboardNewState{
  DefaultApiResponse response;
  ReSentEmailVerification(this.response);
  @override
  List<Object?> get props =>[response];
}

class TransactionPinSet extends OnboardNewState{
  DefaultApiResponse response;
  TransactionPinSet(this.response);
  @override
  List<Object?> get props =>[response];
}

class ForgotPasswordSuccess extends OnboardNewState{
  DefaultApiResponse response;
  ForgotPasswordSuccess(this.response);
  @override
  List<Object?> get props =>[response];
}

class UserInfoUpdatedState extends OnboardNewState{
  UserInfoUpdated response;
  UserInfoUpdatedState(this.response);
  @override
  List<Object?> get props =>[response];
}

class LoggedinUser extends OnboardNewState{
  UserInfoUpdated response;
  LoggedinUser(this.response);
  @override
  List<Object?> get props =>[response];
}