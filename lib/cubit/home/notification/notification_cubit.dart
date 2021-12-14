import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:speakmatch_v2/controller/notifications_controller.dart';
import 'package:speakmatch_v2/data/model/home/notification_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitialState());
  NotificationsController _controller = NotificationsController();

  Future<void> getNotifications() async {
    emit(NotificationLoadingState());
    _controller.getNotifications().then((value) {
      if (value != null) {
        emit(NotificationLoadedState(listOfModel: value));
      } else {
        emit(NotificationFailedState(errorMessage: "Something went wrong!"));
      }
    });
  }
}
