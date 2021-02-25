import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speakmatch/view/signin_signup/login_and_register_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => LoginAndRegisterView()),
              (_) => false),
        ),
      ),
    );
  }
}
