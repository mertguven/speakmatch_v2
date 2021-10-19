part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class SuccessSignOutState extends ProfileState {}

class UnSuccessSignOutState extends ProfileState {}
