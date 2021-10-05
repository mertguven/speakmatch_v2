import 'package:flutter/material.dart';

class LoginAndSignInButton extends StatelessWidget {
  final String buttonText;
  const LoginAndSignInButton({
    Key key,
    @required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: Theme.of(context).colorScheme.secondary),
      onPressed: () {},
    );
  }
}
