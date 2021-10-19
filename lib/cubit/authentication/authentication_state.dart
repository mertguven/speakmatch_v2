part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationLoginOrGoogleSuccessfulState extends AuthenticationState {}

class AuthenticationLoginOrGoogleUnsuccessfulState extends AuthenticationState {
  final String errorMessage;

  AuthenticationLoginOrGoogleUnsuccessfulState({this.errorMessage});
}

class AuthenticationSignupSuccessfulState extends AuthenticationState {}

class AuthenticationSignupUnsuccessfulState extends AuthenticationState {
  final String errorMessage;

  AuthenticationSignupUnsuccessfulState({this.errorMessage});
}

class SuccessForgotPasswordState extends AuthenticationState {}

class UnSuccessForgotPasswordState extends AuthenticationState {
  final String errorMessage;

  UnSuccessForgotPasswordState({this.errorMessage});
}
