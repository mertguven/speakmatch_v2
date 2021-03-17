import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:speakmatch_v2/model/home/call/response/SelectOnlineUserResponseMessage.dart';
import 'package:speakmatch_v2/view/main/main_view.dart';

class MeetingView extends StatefulWidget {
  final SelectOnlineUserResponseMessage response;
  MeetingView({this.response});
  @override
  _MeetingViewState createState() => _MeetingViewState();
}

class _MeetingViewState extends State<MeetingView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        goBackHomeView(context);
      },
      child: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.response.username),
            CircleAvatar(
              maxRadius: 70,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: NetworkImage(widget.response.url),
            ),
          ],
        ),
      )),
    );
  }

  void goBackHomeView(BuildContext context) => Navigator.pushAndRemoveUntil(
      context,
      PageTransition(child: MainView(), type: PageTransitionType.leftToRight),
      (route) => false);
}
