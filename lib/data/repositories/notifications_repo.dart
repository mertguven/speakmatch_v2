import 'package:speakmatch_v2/data/model/home/notification_model.dart';
import 'package:speakmatch_v2/data/service/firestore_service.dart';

class NotificationsRepository {
  FirestoreService _firestoreService = FirestoreService();

  Future<List<NotificationModel>> getNotifications() async {
    final response = await _firestoreService.getNotifications();
    if (response != null) {
      final modelList = response.docs
          .map((e) => NotificationModel.fromJson(e.data()))
          .toList();
      return modelList;
    } else {
      return null;
    }
  }
}
