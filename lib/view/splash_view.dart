// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/shared-prefs.dart';
import 'package:speakmatch_v2/view/authentication/authentication_view.dart';
import 'package:speakmatch_v2/view/main/page_router_view.dart';

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
                child: Image.asset("assets/images/speakmatch_logo.png"))),
      ),
    );
  }

  Future<void> redirect() async {
    Future.delayed(
      Duration(seconds: 2),
      () {
        if (SharedPrefs.getLogin) {
          Get.offAll(() => PageRouterView(), duration: Duration(seconds: 1));
        } else {
          Get.offAll(() => AuthenticationView(),
              duration: Duration(seconds: 1));
        }
      },
    );
  }
}
