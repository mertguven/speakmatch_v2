// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speakmatch_v2/view/authentication/authentication_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    redirect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: FractionallySizedBox(
            widthFactor: 0.5,
            child: Hero(
                tag: "logo",
                child: Image.asset("assets/images/login_screen.png"))),
      ),
    );
  }

  Future<void> redirect() async {
    Future.delayed(
      Duration(seconds: 2),
      () => Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 2),
              pageBuilder: (_, __, ___) => AuthenticationView()),
          (_) => false),
    );
  }
}
