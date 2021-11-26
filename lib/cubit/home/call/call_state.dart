part of 'call_cubit.dart';

@immutable
abstract class CallState {}

class CallInitialState extends CallState {}

class CallLoadingState extends CallState {}

class CallFoundUserState extends CallState {
  final String channelName;

  CallFoundUserState({this.channelName});
}

class SuccessAgoraTokenState extends CallState {
  final String token;

  SuccessAgoraTokenState(this.token);
}

class UnSuccessAgoraTokenState extends CallState {
  final String errorMessage;

  UnSuccessAgoraTokenState(this.errorMessage);
}
