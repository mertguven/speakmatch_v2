import 'package:flutter/material.dart';

class ChangeUserInformationView extends StatefulWidget {
  @override
  _ChangeUserInformationViewState createState() =>
      _ChangeUserInformationViewState();
}

class _ChangeUserInformationViewState extends State<ChangeUserInformationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change User Information"),
      ),
    );
  }
}
