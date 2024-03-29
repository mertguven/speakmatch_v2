import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/controller/authentication_controller.dart';
import 'package:speakmatch_v2/core/utilities/custom_dialog.dart';
import 'package:speakmatch_v2/core/utilities/custom_snackbar.dart';
import 'package:speakmatch_v2/cubit/authentication/authentication_cubit.dart';
import 'package:speakmatch_v2/data/model/authentication/request/forgot_password_request_model.dart';
import 'package:speakmatch_v2/presentation/authentication/authentication_view.dart';
import 'package:speakmatch_v2/core/utilities/custom_divider.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key key}) : super(key: key);

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  TextEditingController emailTextController = TextEditingController();
  AuthenticationController authenticationController =
      AuthenticationController();

  Future<void> sendEmail() async {
    if (emailTextController.text.isNotEmpty) {
      context.read<AuthenticationCubit>().forgotPassword(
          ForgotPasswordRequestModel(email: emailTextController.text));
    } else {
      customSnackbar(false, "emailFieldMustBeFilled".tr);
    }
  }

  void successForgotPasswordDialog() {
    customDialog(context,
        content: "passwordResetEmailHasBeenSentToYourEmail".tr,
        onPressed: () => Get.offAll(() => AuthenticationView(),
            transition: Transition.leftToRightWithFade),
        buttonText: "gotIt".tr,
        title: "emailHasBeenSent".tr,
        image: Image.asset("assets/images/sent_email.png",
            width: context.width * 0.5));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: bloc.BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationLoadingState) {
            EasyLoading.show(status: "loading".tr);
          } else {
            EasyLoading.dismiss();
            if (state is SuccessForgotPasswordState) {
              successForgotPasswordDialog();
            } else if (state is UnSuccessForgotPasswordState) {
              customSnackbar(false, state.errorMessage);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            appBar: appBarWidget(),
            body: bodyWidget(),
          );
        },
      ),
    );
  }

  Widget appBarWidget() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(
        "forgotPassword".tr,
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
              "enterTheEmailAddressAssociatedWithYourAccount".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "weWillEmailYouALinkToResetYourPassword".tr,
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
              hintText: "enterEmailAddress".tr,
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
          "send".tr,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
