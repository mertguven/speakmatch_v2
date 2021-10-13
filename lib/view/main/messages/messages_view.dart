import 'package:flutter/material.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({Key key}) : super(key: key);

  @override
  _MessagesViewState createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message View"),
      ),
    );
  }
}
