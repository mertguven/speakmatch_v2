import 'package:flutter/material.dart';

class LogoComponents extends StatelessWidget {
  final double widhtFactor;

  const LogoComponents({Key key, this.widhtFactor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widhtFactor,
      child: Hero(
        tag: "route",
        child: Image.asset(
          "assets/images/login_screen.png",
        ),
      ),
    );
  }
}
