import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:speakmatch_v2/core/components/logo.dart';
import 'package:speakmatch_v2/core/components/username_password.dart';
import 'package:speakmatch_v2/core/extension/device_screen_size.dart';
import 'package:lottie/lottie.dart';

class LoginAndRegisterView extends StatefulWidget {
  @override
  _LoginAndRegisterViewState createState() => _LoginAndRegisterViewState();
}

class _LoginAndRegisterViewState extends State<LoginAndRegisterView>
    with TickerProviderStateMixin {
  String whichButtonIsItClicked;
  AnimationController _loginController;
  AnimationController _registerController;
  Animation<Offset> _starterContainerOffsetAnimation;
  Animation<Offset> _signInContainerOffsetAnimation;
  Animation<Offset> _signUpContainerOffsetAnimation;
  Animation _waterAnimation;
  AnimationController _waterAnimationController;

  @override
  void initState() {
    super.initState();
    _waterAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _waterAnimation =
        Tween(begin: 0.0, end: 0.8).animate(_waterAnimationController)
          ..addListener(() {
            setState(() {});
          });
    _loginController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _registerController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    _waterAnimationController.forward();
    buttonsAnimation();
  }

  @override
  void dispose() {
    _registerController.dispose();
    _loginController.dispose();
    _waterAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(
        children: [
          waterAnimationsFractionallySizedBox("right"),
          waterAnimationsFractionallySizedBox("left"),
          allContainerWithoutBackground(),
        ],
      ),
    );
  }

  Container allContainerWithoutBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            logoContainer(),
            processContainer(),
          ],
        ),
      ),
    );
  }

  Align waterAnimationsFractionallySizedBox(String whichAnimation) {
    return Align(
      alignment:
          whichAnimation == "right" ? Alignment.topRight : Alignment.bottomLeft,
      child: FractionallySizedBox(
          widthFactor: _waterAnimation.value,
          child: Lottie.asset(
              "assets/animations/${whichAnimation == "right" ? "login-top-right" : "login-bottom-left"}.json",
              reverse: true)),
    );
  }

  Container processContainer() {
    return Container(
      height: context.deviceHeight() * 0.5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          loginSlideTransition(),
          starterSlideTransition(),
          registerSlideTransition(),
        ],
      ),
    );
  }

  Container logoContainer() {
    return Container(
      height: context.deviceHeight() * 0.5,
      child: LogoComponents(widhtFactor: 0.5),
    );
  }

  SlideTransition loginSlideTransition() {
    return SlideTransition(
      position: _signInContainerOffsetAnimation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UsernamePasswordButton(
              whichProcess: "Sign In",
              controller: _loginController,
            ),
          ],
        ),
      ),
    );
  }

  SlideTransition starterSlideTransition() {
    return SlideTransition(
      position: _starterContainerOffsetAnimation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 4),
          signInAndSignUpButtons("Sign In With Google"),
          Spacer(),
          signInAndSignUpButtons("Sign In"),
          Spacer(),
          signInAndSignUpButtons("Sign Up"),
          Spacer(flex: 4),
        ],
      ),
    );
  }

  SlideTransition registerSlideTransition() {
    return SlideTransition(
      position: _signUpContainerOffsetAnimation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UsernamePasswordButton(
                whichProcess: "Sign Up",
                controller: _registerController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  FractionallySizedBox signInAndSignUpButtons(String text) {
    return FractionallySizedBox(
      widthFactor: 0.75,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 15),
        color: text == "Sign In"
            ? Color(0xfff3b000)
            : text == "Sign In With Google"
                ? Colors.white
                : Color(0xffD64565),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {
          if (text == "Sign In") {
            setState(() {
              whichButtonIsItClicked = "login";
              buttonsAnimation();
            });
            _loginController.forward();
          } else if (text == "Sign Up") {
            setState(() {
              whichButtonIsItClicked = "register";
              buttonsAnimation();
            });
            _registerController.forward();
          }
        },
        child: text == "Sign In With Google"
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(width: 10),
                  Text(
                    text,
                    style: buttonTextStyle(text),
                  ),
                ],
              )
            : Text(
                text,
                style: buttonTextStyle(text),
              ),
      ),
    );
  }

  TextStyle buttonTextStyle(String text) {
    return TextStyle(
      color: text == "Sign In With Google" ? Colors.blueGrey : Colors.white,
      fontSize: 16,
    );
  }

  void buttonsAnimation() {
    _starterContainerOffsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: whichButtonIsItClicked == "login" ? Offset(2, 0) : Offset(-2, 0),
    ).animate(CurvedAnimation(
      curve: Curves.easeInOutBack,
      parent: whichButtonIsItClicked == "login"
          ? _loginController
          : _registerController,
    ));

    _signInContainerOffsetAnimation = Tween<Offset>(
      begin: Offset(-2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      curve: Curves.easeInOutBack,
      parent: _loginController,
    ));

    _signUpContainerOffsetAnimation = Tween<Offset>(
      begin: Offset(2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      curve: Curves.easeInOutBack,
      parent: _registerController,
    ));
  }
}
