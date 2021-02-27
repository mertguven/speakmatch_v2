import 'dart:io';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BigProfilePicture extends StatefulWidget {
  File image;
  BigProfilePicture({this.image});

  @override
  _BigProfilePictureState createState() => _BigProfilePictureState();
}

class _BigProfilePictureState extends State<BigProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Profile Photo"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: FractionallySizedBox(
          heightFactor: 0.6,
          child: Hero(
            tag: "photo",
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: widget.image == null
                      ? AssetImage("assets/images/user.png")
                      : Image.file(widget.image).image,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
