import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAuthenticationTextField extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final bool obscureText;
  final FocusNode firstFocusNode;
  final FocusNode secondFocusNode;
  final GestureDetector suffixIcon;
  final TextEditingController textEditingController;
  const CustomAuthenticationTextField({
    Key key,
    @required this.hintText,
    @required this.prefixIcon,
    this.obscureText,
    this.suffixIcon,
    this.firstFocusNode,
    this.secondFocusNode,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obscureText != null
          ? obscureText
              ? true
              : false
          : false,
      focusNode: firstFocusNode,
      onFieldSubmitted: (term) {
        firstFocusNode.unfocus();
        FocusScope.of(context).requestFocus(secondFocusNode);
      },
      textInputAction:
          secondFocusNode != null ? TextInputAction.next : TextInputAction.done,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 20),
        border: InputBorder.none,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
