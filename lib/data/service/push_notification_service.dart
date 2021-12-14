import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:speakmatch_v2/data/model/home/notification_model.dart';
import 'package:speakmatch_v2/data/service/firestore_service.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirestoreService _firestoreService = FirestoreService();

  Future<void> init() async {
    NotificationSettings _settings = await _firebaseMessaging.requestPermission(
        alert: true, badge: true, sound: true, criticalAlert: true);
    if (_settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user grandted the permission!");

      FirebaseMessaging.onMessage.listen((message) {
        _firestoreService.saveNotification(NotificationModel(
            title: message.notification.title,
            body: message.notification.body,
            sendTime: message.sentTime));
        print("app is in the foreground: " + message.notification.toString());
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        _firestoreService.saveNotification(NotificationModel(
            title: message.notification.title,
            body: message.notification.body,
            sendTime: message.sentTime));
        print("app is in the background: " + message.notification.toString());
      });
    }
  }
}
