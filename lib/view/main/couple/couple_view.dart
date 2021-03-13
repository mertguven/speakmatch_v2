import 'package:flutter/material.dart';

class CoupleView extends StatefulWidget {
  @override
  _CoupleViewState createState() => _CoupleViewState();
}

class _CoupleViewState extends State<CoupleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Text("Couple View"),
        ),
      ),
    );
  }
}
