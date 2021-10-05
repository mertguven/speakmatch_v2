// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:speakmatch_v2/core/utilities/screen_size_extension.dart';

import 'components/custom_authentication_textfield.dart';
import 'components/custom_divider.dart';
import 'components/google_button.dart';
import 'components/login_signUp_button.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({Key key}) : super(key: key);

  @override
  _AuthenticationViewState createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isPasswordVisible = true;
  FocusNode loginEmailNode = FocusNode();
  FocusNode loginPasswordNode = FocusNode();
  FocusNode registerNameNode = FocusNode();
  FocusNode registerEmailNode = FocusNode();
  FocusNode registerPasswordNode = FocusNode();
  FocusNode registerConfirmationNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //controllerları yap!
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SingleChildScrollView(
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
                      child: Image.asset("assets/images/login_screen.png")),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customTabBar(),
                      customTabBarView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
              "Existing",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Tab(
            child: Text(
              "New",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Expanded customTabBarView() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          loginView(),
          registerView(),
        ],
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
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomAuthenticationTextField(
                  textEditingController: emailController,
                  hintText: 'Email Address',
                  prefixIcon: Icon(FontAwesomeIcons.solidEnvelope),
                  firstFocusNode: loginEmailNode,
                  secondFocusNode: loginPasswordNode,
                ),
                Divider(),
                CustomAuthenticationTextField(
                  textEditingController: passwordController,
                  hintText: 'Password',
                  firstFocusNode: loginPasswordNode,
                  prefixIcon: Icon(FontAwesomeIcons.lock),
                  obscureText: isPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    child: Icon(
                      isPasswordVisible
                          ? FontAwesomeIcons.solidEye
                          : FontAwesomeIcons.solidEyeSlash,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(flex: 2),
          forgotPasswordButton(),
          Spacer(flex: 2),
          Container(
            width: double.infinity,
            child: LoginAndSignInButton(buttonText: "LOGIN"),
          ),
          Spacer(flex: 2),
          CustomDivider(centerText: "Or"),
          Spacer(flex: 2),
          GoogleButton(),
          Spacer(flex: 2),
        ],
      ),
    );
  }

  Align forgotPasswordButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          print("basıldı");
        },
        child: Text(
          "Forgot Password?",
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
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomAuthenticationTextField(
                  hintText: 'Name',
                  prefixIcon: Icon(FontAwesomeIcons.userAlt),
                  firstFocusNode: registerNameNode,
                  secondFocusNode: registerEmailNode,
                ),
                Divider(),
                CustomAuthenticationTextField(
                  hintText: 'Email Address',
                  prefixIcon: Icon(FontAwesomeIcons.solidEnvelope),
                  firstFocusNode: registerEmailNode,
                  secondFocusNode: registerPasswordNode,
                ),
                Divider(),
                CustomAuthenticationTextField(
                  hintText: 'Password',
                  prefixIcon: Icon(FontAwesomeIcons.lock),
                  firstFocusNode: registerPasswordNode,
                  secondFocusNode: registerConfirmationNode,
                ),
                Divider(),
                CustomAuthenticationTextField(
                  hintText: 'Confirmation',
                  prefixIcon: Icon(FontAwesomeIcons.lock),
                  firstFocusNode: registerConfirmationNode,
                ),
              ],
            ),
          ),
          Spacer(flex: 2),
          Container(
            width: double.infinity,
            child: LoginAndSignInButton(buttonText: "SIGN UP"),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
