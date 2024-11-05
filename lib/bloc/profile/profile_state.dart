part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}
class ProfileIsLoading extends ProfileState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProfileError extends ProfileState{
  DefaultApiResponse errorResponse;
  ProfileError(this.errorResponse);
  @override
  // TODO: implement props
  List<Object?> get props => [errorResponse];
}

class UserDetailUpdate extends ProfileState{
  UpdateUserDetailResponse response;
  UserDetailUpdate(this.response);
  @override
  List<Object?> get props => [response];
}

class PinReset extends ProfileState{
  SecondDefaultResponse response;
  PinReset(this.response);
  @override
  List<Object?> get props => [response];
}

class PasswordChangedSuccefully extends ProfileState{
  SecondDefaultResponse response;
  PasswordChangedSuccefully(this.response);
  @override
  List<Object?> get props => [response];
}

class UserLogOut extends ProfileState{
  DefaultApiResponse response;
  UserLogOut(this.response);
  @override
  List<Object?> get props => [response];
}

class UserNotifications extends ProfileState{
  AllUserNotification response;
  UserNotifications(this.response);
  @override
  List<Object?> get props => [response];
}

class MarkedAsRead extends ProfileState{
  MarkAsReadUnReadResponse response;
  MarkedAsRead(this.response);
  @override
  List<Object?> get props => [response];
}

class MarkedAsUnRead extends ProfileState{
  MarkAsReadUnReadResponse response;
  MarkedAsUnRead(this.response);
  @override
  List<Object?> get props => [response];
}

class UserAppSettingUpdated extends ProfileState{
  UserAlertResponse response;
  UserAppSettingUpdated(this.response);
  @override
  List<Object?> get props => [response];
}

class UserFAQs extends ProfileState{
  List<FaqResponse> response;
  UserFAQs(this.response);
  @override
  List<Object?> get props => [response];
}

class AllUserDetails extends ProfileState{
  UserDetails response;
  AllUserDetails(this.response);
  @override
  List<Object?> get props =>[response];
}

class UserKYCs extends ProfileState{
  UserKycResponse response;
  UserKYCs(this.response);
  @override
  List<Object?> get props =>[response];
}