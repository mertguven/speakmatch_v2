import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:speakmatch_v2/view/main/home/home_view.dart';
import 'package:speakmatch_v2/view/main/main_view.dart';

class SelectErrorView extends StatefulWidget {
  @override
  _SelectErrorViewState createState() => _SelectErrorViewState();
}

class _SelectErrorViewState extends State<SelectErrorView> {
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
              Spacer(flex: 3),
              FractionallySizedBox(
                  widthFactor: 0.7,
                  child: Lottie.asset("assets/animations/404.json")),
              Spacer(),
              Text(
                "Şu an tüm kullanıcılar meşgul",
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(),
              FractionallySizedBox(
                widthFactor: 0.5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    primary: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text("Tamam",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          child: HomeView(),
                          type: PageTransitionType.leftToRight),
                      (route) => false),
                ),
              ),
              Spacer(flex: 3),
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
}
