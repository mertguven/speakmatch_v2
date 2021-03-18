import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:speakmatch_v2/controller/home/home_controller.dart';
import 'package:speakmatch_v2/model/home/call/response/SelectOnlineUserResponseMessage.dart';
import 'package:speakmatch_v2/view/main/home/call/voice_call_view.dart';
import 'package:speakmatch_v2/view/main/main_view.dart';

class ConnectingView extends StatefulWidget {
  final SelectOnlineUserResponseMessage response;
  ConnectingView({this.response});

  @override
  _ConnectingViewState createState() => _ConnectingViewState();
}

class _ConnectingViewState extends State<ConnectingView>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _generateAgoraTokenAndAnimationController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        goBackHomeView(context);
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 5),
              Text(
                widget.response.username,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(),
              FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Lottie.asset("assets/animations/countdown.json")),
              Spacer(),
              Text(
                "Bağlanıyor...",
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(flex: 5),
            ],
          ),
        ),
      ),
    );
  }

  void goBackHomeView(BuildContext context) => Navigator.pushAndRemoveUntil(
      context,
      PageTransition(child: MainView(), type: PageTransitionType.leftToRight),
      (route) => false);

  _generateAgoraTokenAndAnimationController() async {
    var homeController = Provider.of<HomeController>(context, listen: false);
    var response = await homeController.generateAgoraToken();
    if (response.success) {
      _controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 2500))
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: VoiceCallView(
                        response: widget.response, token: response.token),
                    type: PageTransitionType.fade),
                (route) => false);
          }
        });
      _controller.forward();
    }
  }
}
