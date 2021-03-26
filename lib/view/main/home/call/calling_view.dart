import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:speakmatch_v2/controller/home/home_controller.dart';
import 'package:speakmatch_v2/model/home/call/response/SelectOnlineUserResponseMessage.dart';
import 'package:speakmatch_v2/model/home/request/UserStatusChangeRequestMessage.dart';
import 'package:speakmatch_v2/view/main/home/call/connecting_view.dart';
import 'package:speakmatch_v2/view/main/home/call/select_error_view.dart';

class CallingView extends StatefulWidget {
  @override
  _CallingViewState createState() => _CallingViewState();
}

class _CallingViewState extends State<CallingView>
    with TickerProviderStateMixin {
  AnimationController _controller;
  StreamController<SelectOnlineUserResponseMessage> _streamController;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _streamController = new StreamController();
    _searchOnlineUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.9],
            colors: [
              Color(0xFFD64565),
              Color(0xffe08791),
            ],
          ),
        ),
        child: StreamBuilder<SelectOnlineUserResponseMessage>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/animations/calling.json"),
                Text(
                  "Aranıyor...",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ],
            );
          },
        ), /*Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/animations/calling.json"),
            Text(
              "Aranıyor...",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),*/
      ),
    );
  }

  void _searchOnlineUser() async {
    var homeController = Provider.of<HomeController>(context, listen: false);
    var response = await homeController.selectOnlineUser();
    _streamController.add(response);
    if (response.success) {
      _controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 2000))
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: ConnectingView(response: response),
                    type: PageTransitionType.fade),
                (route) => false);
          }
        });
      _controller.forward();
    } else {
      _selectError();
    }
  }

  void _selectError() async {
    var homeController = Provider.of<HomeController>(context, listen: false);
    UserStatusChangeRequestMessage request =
        UserStatusChangeRequestMessage(status: "Idle");
    await homeController.changeUserStatus(request);
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(child: SelectErrorView(), type: PageTransitionType.fade),
        (route) => false);
  }
}
