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