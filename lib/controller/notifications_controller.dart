import 'package:speakmatch_v2/data/model/home/notification_model.dart';
import 'package:speakmatch_v2/data/repositories/notifications_repo.dart';

class NotificationsController {
  NotificationsRepository _repository = NotificationsRepository();

  Future<List<NotificationModel>> getNotifications() async {
    return _repository.getNotifications();
  }
}
