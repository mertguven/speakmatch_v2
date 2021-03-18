import 'package:flutter/material.dart';

class CallEndView extends StatefulWidget {
  @override
  _CallEndViewState createState() => _CallEndViewState();
}

class _CallEndViewState extends State<CallEndView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Call End View"),
          ],
        ),
      ),
    );
  }
}
