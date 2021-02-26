import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speakmatch_v2/controller/signin-signup/auth_controller.dart';
import 'package:speakmatch_v2/locator.dart';
import 'package:speakmatch_v2/model/signin_signup/AuthSurrogateRequestMessage.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/view/main/main_view.dart';

class UsernamePasswordButton extends StatefulWidget {
  final String whichProcess;
  final AnimationController controller;

  const UsernamePasswordButton({Key key, this.whichProcess, this.controller})
      : super(key: key);
  @override
  _UsernamePasswordButtonState createState() => _UsernamePasswordButtonState();
}

class _UsernamePasswordButtonState extends State<UsernamePasswordButton>
    with TickerProviderStateMixin {
  bool isObscureButtonClicked = true;
  var userName = "";
  var password = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        usernamePasswordTextFormField("Username"),
        SizedBox(height: 20),
        usernamePasswordTextFormField("Password"),
        SizedBox(height: 30),
        usernameAndPasswordButtons(widget.whichProcess),
      ],
    );
  }

  Container usernamePasswordTextFormField(String labelText) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        cursorColor: Color(0xffD64565),
        obscureText: isObscureButtonClicked && labelText == "Password",
        onChanged: (entered) {
          labelText == "Username" ? userName = entered : password = entered;
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: labelText == "Username"
              ? Icon(Icons.person, color: Colors.white)
              : IconButton(
                  icon: Icon(
                      isObscureButtonClicked ? Icons.lock : Icons.lock_open,
                      color: Colors.white),
                  onPressed: () {
                    setState(() {
                      isObscureButtonClicked = !isObscureButtonClicked;
                    });
                  },
                ),
          labelStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.only(left: 15, bottom: 15, top: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xffD64565),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  Row usernameAndPasswordButtons(String whichProcess) {
    if (whichProcess == "Sign In") {
      return Row(
        children: [
          Expanded(
            flex: 4,
            child: RaisedButton(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                loginOrRegister("login");
              },
              child: Text(
                "Login",
                style: TextStyle(color: Color(0xff1F2A5D), fontSize: 16),
              ),
            ),
          ),
          SizedBox(width: 10),
          RaisedButton(
              color: Color(0xfff3b000),
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                widget.controller.reverse();
              },
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              )),
        ],
      );
    } else {
      return Row(
        children: [
          RaisedButton(
              color: Color(0xffD64565),
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                widget.controller.reverse();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          SizedBox(width: 10),
          Expanded(
            flex: 4,
            child: RaisedButton(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                loginOrRegister("register");
              },
              child: Text(
                "Register",
                style: TextStyle(color: Color(0xff1F2A5D), fontSize: 16),
              ),
            ),
          ),
        ],
      );
    }
  }

  Future<void> loginOrRegister(String whichProcess) async {
    if (userName == "" || password == "") {
      customSnackbar(false, "Please be sure to enter the information");
    } else {
      AuthController authController = locator<AuthController>();
      AuthSurrogateRequestMessage requestMessage =
          AuthSurrogateRequestMessage(username: userName, password: password);
      if (whichProcess == "login") {
        var responseMessage = await authController.signIn(requestMessage);
        if (responseMessage.success) {
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => MainView()),
              (_) => false);
        } else {
          customSnackbar(responseMessage.success, responseMessage.messages);
        }
      } else {
        var responseMessage = await authController.signUp(requestMessage);
        if (responseMessage.success) {
          widget.controller.reverse();
          customSnackbar(responseMessage.success,
              "Registration successful. You can login.");
        } else {
          customSnackbar(responseMessage.success, responseMessage.messages);
        }
      }
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
