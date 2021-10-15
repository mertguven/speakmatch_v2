import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/controller/authentication_controller.dart';
import 'package:speakmatch_v2/core/utilities/custom_dialog.dart';
import 'package:speakmatch_v2/core/utilities/custom_snackbar.dart';
import 'package:speakmatch_v2/data/model/authentication/request/forgot_password_request_model.dart';
import 'package:speakmatch_v2/data/model/authentication/response/forgot_password_response_model.dart';
import 'package:speakmatch_v2/presentation/authentication/authentication_view.dart';
import 'package:speakmatch_v2/presentation/authentication/components/custom_divider.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key key}) : super(key: key);

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  TextEditingController emailTextController = TextEditingController();
  AuthenticationController authenticationController =
      AuthenticationController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: appBarWidget(),
        body: bodyWidget(),
      ),
    );
  }

  Widget appBarWidget() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(
        "Forgot Password?",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget bodyWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            memojiImageWidget(),
            commentTextWidget(),
            emailTextFieldWidget(),
            sendButtonWidget(),
          ],
        ),
      ),
    );
  }

  Widget memojiImageWidget() {
    return FractionallySizedBox(
        widthFactor: 0.7,
        child: Image.asset("assets/images/forgot_password.png"));
  }

  Widget commentTextWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              "Enter the email address associated with your account",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "We will email you a link to reset your password",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                color: Colors.white54,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget emailTextFieldWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextField(
            controller: emailTextController,
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
            showCursor: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter Email Address",
              hintStyle: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          CustomDivider()
        ],
      ),
    );
  }

  Widget sendButtonWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
      child: ElevatedButton(
        onPressed: () => sendEmail(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          primary: Theme.of(context).colorScheme.secondary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(
          "Send",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  sendEmail() async {
    if (emailTextController.text.isNotEmpty) {
      ForgotPasswordResponseModel response =
          await authenticationController.forgotPassword(
              ForgotPasswordRequestModel(email: emailTextController.text));
      if (response.success) {
        successForgotPasswordDialog();
      }
    } else {
      customSnackbar(false, "Email field must be filled.");
    }
  }

  void successForgotPasswordDialog() {
    customDialog(
        context: context,
        content: "Password reset email has been sent to your email.",
        onPressed: () => Get.offAll(AuthenticationView(),
            transition: Transition.leftToRightWithFade),
        buttonText: "Got it",
        title: "Email has been sent",
        image: Image.asset("assets/images/sent_email.png"));
  }
}
