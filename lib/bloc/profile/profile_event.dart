part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ResetPinEvent extends ProfileEvent{
  ResetUserPinRequest request;
  ResetPinEvent(this.request);
  @override
  List<Object?> get props => [];
}

class ChangePasswordEvent extends ProfileEvent{
  ChangeUserPasswordRequest request;
  ChangePasswordEvent(this.request);
  @override
  List<Object?> get props => [];
}
class LogOutUserEvent extends ProfileEvent{
  LogOutRequest request;
  LogOutUserEvent(this.request);
  @override
  List<Object?> get props => [];
}

class UpdateUserDetailsEvent extends ProfileEvent{
  UpdateUserDetailRequest request;
  UpdateUserDetailsEvent(this.request);
  @override
  List<Object?> get props => [];
}