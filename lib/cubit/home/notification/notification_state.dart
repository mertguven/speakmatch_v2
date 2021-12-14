part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationLoadedState extends NotificationState {
  final List<NotificationModel> listOfModel;

  NotificationLoadedState({this.listOfModel});
}

class NotificationFailedState extends NotificationState {
  final String errorMessage;

  NotificationFailedState({this.errorMessage});
}
