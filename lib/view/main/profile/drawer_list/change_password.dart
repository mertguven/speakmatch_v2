import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:speakmatch_v2/controller/profile/profile_controller.dart';
import 'package:speakmatch_v2/model/profile/request/ChangePasswordRequestMessage.dart';

class ChangePasswordView extends StatefulWidget {
  ChangePasswordView({Key key}) : super(key: key);

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  String newPassword = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Şifre Değiştir"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: "Yeni Şifre",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xdddddddd)),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.only(right: 10, left: 10),
              ),
              onChanged: (entered) {
                newPassword = entered;
              },
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.5,
            child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  primary: Theme.of(context).accentColor,
                  elevation: 5,
                ),
                onPressed: () => saveChanges(newPassword),
                child: Text(
                  "Kaydet",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  saveChanges(String newPassword) async {
    if (newPassword != "") {
      final profileController =
          Provider.of<ProfileController>(context, listen: false);
      var request = ChangePasswordRequestMessage(password: newPassword);
      var response = await profileController.changePassword(request);
      if (response.success) {
        Navigator.pop(context);
        Navigator.pop(context);
        customSnackbar(response.success, response.messages);
      } else {
        customSnackbar(response.success, response.messages);
      }
    } else {
      customSnackbar(false, "Please enter your new password!");
    }
  }

  customSnackbar(bool success, String content) {
    Get.snackbar(null, null,
        margin: EdgeInsets.all(15),
        duration: Duration(seconds: 5),
        borderRadius: 7,
        messageText: Text(
          content,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        icon: Icon(
          success ? Icons.done : Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: success ? Colors.lightGreen : Color(0xffD64565),
        snackPosition: SnackPosition.TOP);
  }
}
