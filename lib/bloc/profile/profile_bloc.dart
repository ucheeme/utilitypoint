import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utilitypoint/model/defaultModel.dart';
import 'package:utilitypoint/model/request/markAsReadUnread/markReadUnRead.dart';
import 'package:utilitypoint/model/request/resetPin.dart';
import 'package:utilitypoint/model/request/updateUserRequest.dart';
import 'package:utilitypoint/model/response/faqResponse.dart';
import 'package:utilitypoint/model/response/markReadUnReadesponse.dart';
import 'package:utilitypoint/model/response/userInfoUpdated.dart';
import 'package:utilitypoint/repository/apiRepository.dart';

import '../../model/request/changePassword.dart';
import '../../model/request/getProduct.dart';
import '../../model/request/logOutRequest.dart';
import '../../model/request/userAlertRequest.dart';
import '../../model/response/allUserNotification.dart';
import '../../model/response/updateUserResponse.dart';
import '../../model/response/userAlertResponse.dart';
import '../../model/response/userDetails.dart';
import '../../model/response/userKYCResponse.dart';
import '../../repository/profileRepository.dart';
import '../../utils/app_util.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository profileRepository;
  var errorObs = PublishSubject<String>();
  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<ResetPinEvent>((event,emit){handleResetPinEvent(event.request);});
    on<UpdateUserDetailsEvent>((event,emit){handleUpdateUserDetailsEvent(event.request);});
    on<ChangePasswordEvent>((event,emit){handleChangePasswordEvent(event.request);});
    on<LogOutUserEvent>((event,emit){handleLogOutEvent(event.request);});
    on<GetAllUserNotificationEvent>((event,emit){handleGetAllUserNotificationEvent(event.request);});
    on<MarkNotificationAsReadEvent>((event,emit){handleMarkNotificationAsReadEvent(event.request);});
    on<MarkNotificationAsUnReadEvent>((event,emit){handleMarkNotificationAsUnReadEvent(event.request);});
    on<GetFAQsEvent>((event,emit){handleGetFAQsEvent();});
    on<GetUserDetails>((event,emit){handleGetUserDetails(event.request);});
    on<GetAllUserUploadedKYCEvent>((event,emit){handleGetAllUserUploadedKYCEvent(event.request);});
    on<UpdateUserAppSettingEvent>((event,emit){handleUpdateUserAppSettingEvent(event.request);});
  }
  void handleResetPinEvent(ResetUserPinRequest event)async{
    emit(ProfileIsLoading());
    try {
      final   response = await profileRepository.changeUserPin(event);
      if (response is SecondDefaultResponse) {
        emit(PinReset(response));
        AppUtils.debug("success");
      }else{
        emit(ProfileError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProfileError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleUpdateUserDetailsEvent(UpdateUserDetailRequest event)async{
    emit(ProfileIsLoading());
    try {
      final   response = await profileRepository.updateUserDetails(event);
      if (response is UpdateUserDetailResponse) {
        emit(UserDetailUpdate(response));
        AppUtils.debug("success");
      }else{
        emit(ProfileError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProfileError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleChangePasswordEvent(ChangeUserPasswordRequest event)async{
    emit(ProfileIsLoading());
    try {
      final   response = await profileRepository.resetUserPassword(event);
      if (response is SecondDefaultResponse) {
        if(response.status==true){
          emit(PasswordChangedSuccefully(response));
          AppUtils.debug("success");
        }else{
          emit(ProfileError(response as DefaultApiResponse));
          AppUtils.debug("error");
        }
      }else{
        emit(ProfileError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProfileError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleLogOutEvent(LogOutRequest event)async{
    //emit(ProfileIsLoading());
    try {
      final response = await profileRepository.logOutUser(event);
      if (response is DefaultApiResponse) {
        if(response.status==true){
          emit(UserLogOut(response));
          AppUtils.debug("success");
        }else{
          emit(ProfileError(response as DefaultApiResponse));
          AppUtils.debug("error");
        }
      }else{
        emit(ProfileError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProfileError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetAllUserNotificationEvent(GetProductRequest event)async{
    emit(ProfileIsLoading());
    try {
      final response = await profileRepository.getUserNotifications(event);
      if (response is AllUserNotification) {
        emit(UserNotifications(response));
      }else{
        emit(ProfileError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProfileError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleMarkNotificationAsReadEvent( event)async{
    //emit(ProfileIsLoading());
    try {
      final response = await profileRepository.markAsReadUnRead(event);
      if (response is MarkAsReadUnReadResponse) {
        emit(MarkedAsRead(response));
      }else{
        emit(ProfileError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProfileError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleMarkNotificationAsUnReadEvent( event)async{
    //emit(ProfileIsLoading());
    try {
      final response = await profileRepository.markAsReadUnRead(event);
      if (response is MarkAsReadUnReadResponse) {
        emit(MarkedAsUnRead(response));
      }else{
        emit(ProfileError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProfileError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleUpdateUserAppSettingEvent( event)async{
    emit(ProfileIsLoading());
    try {
      final response = await profileRepository.updateUserAppSetting(event);
      if (response is UserAlertResponse) {
        emit(UserAppSettingUpdated(response));
      }else{
        emit(ProfileError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProfileError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }
  void handleGetFAQsEvent  ()async{
    emit(ProfileIsLoading());
    try {
      final response = await profileRepository.getFAQ();
      if (response is List<FaqResponse>) {
        emit(UserFAQs(response));
      }else{
        emit(ProfileError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProfileError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }

  void handleGetUserDetails(GetProductRequest event)async{
    //emit(ProductIsLoading());
    print("Year");
    try {
      final   response = await profileRepository.getUserDetails(event);
      if (response is UserDetails) {
        emit(AllUserDetails(response));
        AppUtils.debug("success");
      }else{
        emit(ProfileError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProfileError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }

  void handleGetAllUserUploadedKYCEvent(event)async{
    //emit(ProductIsLoading());
    try {
      final response = await profileRepository.getUserKYCUploads(event);
      if (response is UserKycResponse?) {
        emit(UserKYCs(response) );
        AppUtils.debug("success");
      }
      else{
        emit(ProfileError(response as DefaultApiResponse));
        AppUtils.debug("error");
      }
    }catch(e,trace){
      print(trace);
      emit(ProfileError(AppUtils.defaultErrorResponse(msg: e.toString())));
    }
  }

  initial(){
    emit(ProfileInitial());
  }
}
