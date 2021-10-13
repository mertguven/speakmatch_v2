import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customSnackbar(bool success, String content) {
  Get.snackbar(
    "",
    "",
    titleText: Text(
      success ? "Successful!" : "Error!",
      style: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    ),
    margin: EdgeInsets.all(15),
    duration: Duration(seconds: 5),
    borderRadius: 7,
    messageText: Text(
      content,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
    icon: Icon(
      success ? Icons.done : Icons.info,
      size: 28.0,
      color: Colors.white,
    ),
    backgroundColor: success ? Colors.lightGreen : Color(0xffD64565),
    snackPosition: SnackPosition.TOP,
  );
}
