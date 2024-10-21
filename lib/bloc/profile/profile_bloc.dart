import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utilitypoint/model/defaultModel.dart';
import 'package:utilitypoint/model/request/resetPin.dart';
import 'package:utilitypoint/model/request/updateUserRequest.dart';
import 'package:utilitypoint/model/response/userInfoUpdated.dart';
import 'package:utilitypoint/repository/apiRepository.dart';

import '../../model/request/changePassword.dart';
import '../../model/request/logOutRequest.dart';
import '../../model/response/updateUserResponse.dart';
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

  initial(){
    emit(ProfileInitial());
  }
}
