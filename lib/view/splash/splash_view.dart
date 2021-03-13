import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speakmatch_v2/core/components/logo.dart';
import 'package:speakmatch_v2/shared-prefs.dart';
import 'package:speakmatch_v2/view/main/main_view.dart';
import 'package:speakmatch_v2/view/signin_signup/login_and_register_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  bool isAnimationCompleted = false;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0, end: 50).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            isAnimationCompleted = true;
            Future.delayed(Duration(milliseconds: 2000), () => pageRotate());
          });
        }
      });
    _animationController.forward();
  }

  Future<void> waiting(StatefulWidget whichView) async =>
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 1500),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  whichView),
          (_) => false);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [getSplashImage(), getCircularIndicator()],
          ),
        ),
      ),
    );
  }

  Visibility getCircularIndicator() => Visibility(
      visible: isAnimationCompleted, child: CircularProgressIndicator());

  Padding getSplashImage() => Padding(
        padding: EdgeInsets.only(bottom: _animation.value),
        child: LogoComponents(widhtFactor: 0.6),
      );

  Future pageRotate() async {
    if (SharedPrefs.getLogin) {
      print("user token: " + SharedPrefs.getToken);
      waiting(MainView());
    } else {
      waiting(LoginAndRegisterView());
    }
  }
}