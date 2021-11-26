part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final UserResponseModel model;

  ProfileLoadedState({this.model});
}

class ProfileErrorState extends ProfileState {
  final String errorMessage;

  ProfileErrorState({this.errorMessage});
}

class SuccessChangePersonalInformationState extends ProfileState {}

class SuccessSignOutState extends ProfileState {}

class UnSuccessSignOutState extends ProfileState {}
