part of 'onboard_new_bloc.dart';

sealed class OnboardNewEvent extends Equatable {
  const OnboardNewEvent();
}

class CreateUserAccountEvent extends OnboardNewEvent {
  final CreateAccountRequest request;
  const CreateUserAccountEvent(this.request);
  @override
  List<Object?> get props => [];
}

class VerifyUserEmailEvent extends OnboardNewEvent {
  final VerifiedEmailRequest request;
  const VerifyUserEmailEvent(this.request);
  @override
  List<Object?> get props => [];
}

class ResendEmailVerificationCodeEvent extends OnboardNewEvent{
  final VerifiedEmailRequest request;
  const ResendEmailVerificationCodeEvent(this.request);
  @override
  List<Object?> get props => [];
}

class SetTransactionEvent extends OnboardNewEvent{
  final SetTransactionPinRequest request;
  const SetTransactionEvent(this.request);
  @override
  List<Object?> get props => [];
}

class ChangePinEvent extends OnboardNewEvent{
  final ChangePinRequest request;
  const ChangePinEvent(this.request);
  @override
  List<Object?> get props => [];
}

class SetUserIdentifierEvent extends OnboardNewEvent{
  final SetUniqueIdentifierRequest request;
  const SetUserIdentifierEvent(this.request);
  @override
  List<Object?> get props => [];
}

class SetUserInfoEvent extends OnboardNewEvent{
  final UpdateUser request;
  const SetUserInfoEvent(this.request);
  @override
  List<Object?> get props => [];
}

class LoginUserEvent extends OnboardNewEvent{
  final LoginUserRequest request;
  const LoginUserEvent(this.request);
  @override
  List<Object?> get props => [];
}

class LoginUserTwoFactorAuthenticationEvent extends OnboardNewEvent{
  final TwoFactorAuthenticationRequest request;
  const LoginUserTwoFactorAuthenticationEvent(this.request);
  @override
  List<Object?> get props => [];
}

class ResendTwoFactorAuthenticatorEvent extends OnboardNewEvent{
  final VerifiedEmailRequest request;
  const ResendTwoFactorAuthenticatorEvent(this.request);
  @override
  List<Object?> get props => [];
}

class ForgotPasswordEvent extends OnboardNewEvent{
  final String request;
  const ForgotPasswordEvent(this.request);
  @override
  List<Object?> get props => [];
}

class SignInCreateNewPasswordEvent extends OnboardNewEvent{
  final SignInResetPasswordRequest request;
  const SignInCreateNewPasswordEvent(this.request);
  @override
  List<Object?> get props => [];
}

class GetSingleUserDetailEvent extends OnboardNewEvent{
  String userId;
   GetSingleUserDetailEvent(this.userId);
  @override
  List<Object?> get props => [];
}