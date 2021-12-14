import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String title;
  String body;
  DateTime sendTime;

  NotificationModel({this.title, this.body, this.sendTime});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    sendTime = (json['sendTime'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['sendTime'] = Timestamp.fromDate(this.sendTime);
    return data;
  }
}
