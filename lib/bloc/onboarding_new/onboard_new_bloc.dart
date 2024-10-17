import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utilitypoint/model/request/changePin.dart';

import '../../model/defaultModel.dart';
import '../../model/request/accountCreation.dart';
import '../../model/request/loginRequest.dart';
import '../../model/request/setTransactionPin.dart';
import '../../model/request/signInResetPasswordRequest.dart';
import '../../model/request/twoFactorAuthenticationRequest.dart';
import '../../model/request/updateUserInfo.dart';
import '../../model/request/verifyEmailRequest.dart';
import '../../model/response/accountCreated.dart';
import '../../model/response/userInfoUpdated.dart';
import '../../repository/onboarding_repository.dart';
import '../../utils/app_util.dart';
import 'onBoardingValidator.dart';

part 'onboard_new_event.dart';
part 'onboard_new_state.dart';

class OnboardNewBloc extends Bloc<OnboardNewEvent, OnboardNewState> {
  final OnboardingRepository onboardingRepository;
  var errorObs = PublishSubject<String>();
  OnboardingFormValidation validation = OnboardingFormValidation();
  OnboardNewBloc({required this.onboardingRepository}) : super(OnboardNewInitial()) {
    on<OnboardNewEvent>((event, emit) {});
    on<CreateUserAccountEvent>((event, emit) async {handleAccountCreateEvent(event);});
    on<VerifyUserEmailEvent>((event, emit)async{handleVerifyEmailEvent(event.request);});
    on<ResendEmailVerificationCodeEvent>((event, emit)async{handleResendEmailVerificationEvent(event.request);});
    on<SetTransactionEvent>((event, emit)async{handleSetTransactionPin(event.request);});
    on<SetUserInfoEvent>((event, emit)async{handleSetUserInfo(event.request);});
    on<LoginUserEvent>((event, emit)async{handleLoginUser(event.request);});
    on<ForgotPasswordEvent>((event, emit)async{handleForgotPassword(event.request);});
    on<LoginUserTwoFactorAuthenticationEvent>((event, emit)async{handleTwoFactorAuthentication(event.request);});
    on<ResendTwoFactorAuthenticatorEvent>((event, emit)async{handleResendTwoFactorAuthentication(event.request);});
    on<ChangePinEvent>((event, emit)async{handleChangePin(event.request);});
    on<SignInCreateNewPasswordEvent>((event, emit)async{handleSignInCreateNewPasswordEvent(event.request);});
  }
  void handleAccountCreateEvent(event)async{
    emit(OnboardingIsLoading());
    try {
      final response = await onboardingRepository.createUser(event.request );
      if (response is AccountCreatedResponse) {
        emit(AccountCreated(response));
        AppUtils.debug("success");
      }else{
        emit(OnBoardingError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(OnBoardingError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleVerifyEmailEvent(VerifiedEmailRequest event)async{
    emit(OnboardingIsLoading());
    try {
      final   response = await onboardingRepository.verifyUserEmail(event);
      if (response is DefaultApiResponse) {
        if(response.status==true){
          emit(EmailVerified(response));
          AppUtils.debug("success");
        }else{
          emit(OnBoardingError(response as DefaultApiResponse));
          AppUtils.debug("error");
        }
      }else{
        emit(OnBoardingError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(OnBoardingError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleResendEmailVerificationEvent(VerifiedEmailRequest event)async{
    emit(OnboardingIsLoading());
    try {
      final   response = await onboardingRepository.resendVerificationCode(event);
      if (response is DefaultApiResponse) {
        if(response.status==true){
          emit(ReSentEmailVerification(response));
          AppUtils.debug("success");
        }else{
          emit(OnBoardingError(response as DefaultApiResponse));
          AppUtils.debug("error");
        }
      }else{
        emit(OnBoardingError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(OnBoardingError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleSetTransactionPin(SetTransactionPinRequest event)async{
    emit(OnboardingIsLoading());
    try {
      final   response = await onboardingRepository.setTransactionPin(event);
      if (response is DefaultApiResponse) {
        if(response.status==true){
          emit(TransactionPinSet(response));
          AppUtils.debug("success");
        }else{
          emit(OnBoardingError(response as DefaultApiResponse));
          AppUtils.debug("error");
        }
      }else{
        emit(OnBoardingError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(OnBoardingError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleSetUserInfo(UpdateUser event)async{
    emit(OnboardingIsLoading());
    try {
      final   response = await onboardingRepository.setUserInfo(event);
      if (response is UserInfoUpdated) {
          emit(UserInfoUpdatedState(response));
          AppUtils.debug("success");
      }else{
        emit(OnBoardingError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(OnBoardingError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleLoginUser(LoginUserRequest event)async{
    emit(OnboardingIsLoading());
    try {
      final   response = await onboardingRepository.loginUser(event);
      if (response is UserInfoUpdated) {
          emit(LoggedinUser(response));
          AppUtils.debug("success");
      }else{
        emit(OnBoardingError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(OnBoardingError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleForgotPassword(String event)async{
    emit(OnboardingIsLoading());
    try {
      final   response = await onboardingRepository.forgotPassword(event);
      if (response is UserInfoUpdated) {

          emit(ForgotPasswordSuccess(response));
          AppUtils.debug("success");

      }else{
        emit(OnBoardingError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(OnBoardingError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleTwoFactorAuthentication(TwoFactorAuthenticationRequest event)async{
    emit(OnboardingIsLoading());
    try {
      final   response = await onboardingRepository.twoFactorAuthentication(event);
      if (response is UserInfoUpdated) {
          emit(TwoFactorAuthenticated(response));
          AppUtils.debug("success");

      }else{
        emit(OnBoardingError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(OnBoardingError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleResendTwoFactorAuthentication(VerifiedEmailRequest event)async{
    emit(OnboardingIsLoading());
    try {
      final   response = await onboardingRepository.resendTwoFactorAuthentication(event);
      if (response is DefaultApiResponse) {
        if(response.status== true){
          emit(TwoFactorAuthenticationCodeResent(response));
          AppUtils.debug("success");
        }else{
          emit(OnBoardingError(response as DefaultApiResponse));
          AppUtils.debug("error");
        }
      }else{
        emit(OnBoardingError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(OnBoardingError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }

  void handleChangePin(ChangePinRequest event)async{
    emit(OnboardingIsLoading());
    try {
      final   response = await onboardingRepository.changeTransactionPin(event);
      if (response is DefaultApiResponse) {
        if(response.status== true){
          emit(PinChanged(response));
          AppUtils.debug("success");
        }else{
          emit(OnBoardingError(response as DefaultApiResponse));
          AppUtils.debug("error");
        }
      }else{
        emit(OnBoardingError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(OnBoardingError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }

  void handleSignInCreateNewPasswordEvent(SignInResetPasswordRequest event)async{
    emit(OnboardingIsLoading());
    try {
      final response = await onboardingRepository.createNewPassword(event);
      if (response is UserInfoUpdated) {
          emit(NewPasswordCreated(response));
          AppUtils.debug("success");
      }else{
        emit(OnBoardingError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(OnBoardingError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }


  initial(){
    emit(OnboardNewInitial());
  }


}
