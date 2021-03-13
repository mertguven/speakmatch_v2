import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speakmatch_v2/core/extension/device_screen_size.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Bildirimler"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset("assets/animations/no_notification.json",
                width: context.deviceWidth() * 0.8),
            Text("Henüz bildirim yok...",
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
