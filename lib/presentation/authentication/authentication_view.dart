import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/controller/authentication_controller.dart';
import 'package:speakmatch_v2/core/utilities/custom_dialog.dart';
import 'package:speakmatch_v2/core/utilities/custom_snackbar.dart';
import 'package:speakmatch_v2/cubit/authentication/authentication_cubit.dart';
import 'package:speakmatch_v2/data/model/authentication/request/authentication_request_model.dart';
import 'package:speakmatch_v2/presentation/authentication/forgot_password_view.dart';
import 'package:speakmatch_v2/presentation/main/page_router_view.dart';

import 'components/custom_authentication_textfield.dart';
import '../../core/utilities/custom_divider.dart';
import 'components/google_button.dart';
import 'components/login_signUp_button.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({Key key}) : super(key: key);

  @override
  _AuthenticationViewState createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView>
    with TickerProviderStateMixin {
  TabController _tabController;
  bool isLoginPasswordVisible = true;
  bool isSignupPasswordVisible = true;
  bool isSignupConfirmationVisible = true;
  var loginNodes = <FocusNode>[];
  var registerNodes = <FocusNode>[];
  var loginTextController = <TextEditingController>[];
  var registerTextController = <TextEditingController>[];
  AuthenticationController authenticationController =
      AuthenticationController();

  AnimationController animationController;
  Animation<Offset> tabBarOffset;
  Animation<Offset> tabViewOffset;

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    //Animation initializer
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    tabBarOffset = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero)
        .animate(CurvedAnimation(
      curve: Curves.easeOutCubic,
      parent: animationController,
    ));
    tabViewOffset = Tween<Offset>(begin: Offset(-3.0, 0.0), end: Offset.zero)
        .animate(CurvedAnimation(
      curve: Curves.easeOutCubic,
      parent: animationController,
    ));
    animationController.forward();
    for (var i = 0; i < 2; i++) {
      loginNodes.add(FocusNode());
      loginTextController.add(TextEditingController());
    }
    for (var i = 0; i < 4; i++) {
      registerNodes.add(FocusNode());
      registerTextController.add(TextEditingController());
    }
    _tabController = TabController(length: 2, vsync: this);
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
            if (state is AuthenticationLoginOrGoogleSuccessfulState) {
              Get.offAll(() => PageRouterView());
            } else if (state is AuthenticationLoginOrGoogleUnsuccessfulState) {
              customSnackbar(false, state.errorMessage);
            } else if (state is AuthenticationSignupSuccessfulState) {
              customDialog(context,
                  content: "verificationEmailHasBeenSentPleaseConfirmYourEmail"
                      .tr, onPressed: () {
                Get.back();
                _tabController.animateTo(0, curve: Curves.easeInOutBack);
              },
                  buttonText: "gotIt".tr,
                  title: "emailHasBeenSent".tr,
                  image: Image.asset("assets/images/sent_email.png",
                      width: context.width * 0.5));
            } else if (state is AuthenticationSignupUnsuccessfulState) {
              customSnackbar(false, state.errorMessage);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            body: bodyWidget(),
          );
        },
      ),
    );
  }

  Widget bodyWidget() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 40),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: context.height - 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Hero(
                  tag: "logo",
                  child: Image.asset("assets/images/speakmatch_logo.png")),
            ),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                      position: tabBarOffset, child: customTabBar()),
                  customTabBarView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container customTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.black45,
      ),
      child: TabBar(
        controller: _tabController,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.secondary,
        ),
        tabs: [
          Tab(
            child: Text(
              "existing".tr,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Tab(
            child: Text(
              "new".tr,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Expanded customTabBarView() {
    return Expanded(
      child: SlideTransition(
        position: tabViewOffset,
        child: TabBarView(
          controller: _tabController,
          children: [
            loginView(),
            registerView(),
          ],
        ),
      ),
    );
  }

  Container loginView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Spacer(),
          //White Container
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListView.separated(
              itemCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) => CustomAuthenticationTextField(
                textEditingController: loginTextController[index],
                keyboardType: index == 0 ? TextInputType.emailAddress : null,
                hintText: index == 0 ? 'emailAddress'.tr : 'password'.tr,
                prefixIcon: index == 0
                    ? Icon(FontAwesomeIcons.solidEnvelope)
                    : Icon(FontAwesomeIcons.lock),
                firstFocusNode: loginNodes[index],
                obscureText: index == 1 ? isLoginPasswordVisible : null,
                secondFocusNode: index == 0 ? loginNodes[index + 1] : null,
                suffixIcon: index == 1
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            isLoginPasswordVisible = !isLoginPasswordVisible;
                          });
                        },
                        child: Icon(
                          isLoginPasswordVisible
                              ? FontAwesomeIcons.solidEye
                              : FontAwesomeIcons.solidEyeSlash,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    : null,
              ),
            ),
          ),
          Spacer(flex: 2),
          forgotPasswordButton(),
          Spacer(flex: 2),
          Container(
            width: double.infinity,
            child: LoginAndSignUpButton(
              buttonText: "login".tr,
              onPressed: () => loginButtonEvent(),
            ),
          ),
          Spacer(flex: 2),
          CustomDivider(centerText: "or".tr),
          Spacer(flex: 2),
          GoogleButton(onPressed: () => loginWithGoogle()),
          Spacer(flex: 2),
        ],
      ),
    );
  }

  Align forgotPasswordButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => Get.to(() => ForgotPasswordView(),
            transition: Transition.rightToLeft),
        child: Text(
          "forgotPassword".tr,
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
        ),
      ),
    );
  }

  Container registerView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Spacer(),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: 4,
              padding: EdgeInsets.all(8),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => CustomAuthenticationTextField(
                textEditingController: registerTextController[index],
                keyboardType: index == 1 ? TextInputType.emailAddress : null,
                obscureText: index == 2
                    ? isSignupPasswordVisible
                    : index == 3
                        ? isSignupConfirmationVisible
                        : null,
                hintText: index == 0
                    ? 'name'.tr
                    : index == 1
                        ? 'emailAddress'.tr
                        : index == 2
                            ? 'password'.tr
                            : "confirmation".tr,
                prefixIcon: index == 0
                    ? Icon(FontAwesomeIcons.userAlt)
                    : index == 1
                        ? Icon(FontAwesomeIcons.solidEnvelope)
                        : Icon(FontAwesomeIcons.lock),
                suffixIcon: index == 2 || index == 3
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            if (index == 2) {
                              isSignupPasswordVisible =
                                  !isSignupPasswordVisible;
                            } else {
                              isSignupConfirmationVisible =
                                  !isSignupConfirmationVisible;
                            }
                          });
                        },
                        child: Icon(
                          (index == 2 && isSignupPasswordVisible) ||
                                  (index == 3 && isSignupConfirmationVisible)
                              ? FontAwesomeIcons.solidEye
                              : FontAwesomeIcons.solidEyeSlash,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    : null,
                firstFocusNode: registerNodes[index],
                secondFocusNode: index != 3 ? registerNodes[index + 1] : null,
              ),
            ),
          ),
          Spacer(flex: 2),
          Container(
            width: double.infinity,
            child: LoginAndSignUpButton(
              buttonText: "signUp".tr,
              onPressed: () => signUpButtonEvent(),
            ),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }

  Future signUpButtonEvent() async {
    if (registerTextController[0].text.isNotEmpty &&
        registerTextController[1].text.isNotEmpty &&
        registerTextController[2].text.isNotEmpty &&
        registerTextController[3].text.isNotEmpty) {
      if (registerTextController[2].text == registerTextController[3].text) {
        context.read<AuthenticationCubit>().signUp(AuthenticationRequestModel(
            name: registerTextController[0].text,
            email: registerTextController[1].text,
            password: registerTextController[2].text));
      } else {
        customSnackbar(false, "passwordsMustBeTheSame".tr);
      }
    } else {
      customSnackbar(false, "allFieldsMustBeFilled".tr);
    }
  }

  Future loginButtonEvent() async {
    if (loginTextController[0].text.isNotEmpty &&
        loginTextController[1].text.isNotEmpty) {
      context.read<AuthenticationCubit>().login(AuthenticationRequestModel(
          email: loginTextController[0].text,
          password: loginTextController[1].text));
    } else {
      customSnackbar(false, "allFieldsMustBeFilled".tr);
    }
  }

  Future loginWithGoogle() async {
    context.read<AuthenticationCubit>().loginWithGoogle();
  }
}
