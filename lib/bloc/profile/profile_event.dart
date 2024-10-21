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
class GetAllUserNotificationEvent extends ProfileEvent {
  final GetProductRequest request;
  const GetAllUserNotificationEvent(this.request);
  @override
  List<Object?> get props => [];
}
class MarkNotificationAsReadEvent extends ProfileEvent {
  final MarkAsReadUnReadRequest request;
  const MarkNotificationAsReadEvent(this.request);
  @override
  List<Object?> get props => [];
}

class MarkNotificationAsUnReadEvent extends ProfileEvent {
  final MarkAsReadUnReadRequest request;
  const MarkNotificationAsUnReadEvent(this.request);
  @override
  List<Object?> get props => [];
}
class UpdateUserAppSettingEvent extends ProfileEvent {
  final UserAlertNotificationRequest request;
  const UpdateUserAppSettingEvent(this.request);
  @override
  List<Object?> get props => [];
}