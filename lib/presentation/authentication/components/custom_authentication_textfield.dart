import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAuthenticationTextField extends StatefulWidget {
  final String hintText;
  final Icon prefixIcon;
  final bool obscureText;
  final FocusNode firstFocusNode;
  final FocusNode secondFocusNode;
  final GestureDetector suffixIcon;
  final TextInputType keyboardType;
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
    this.keyboardType,
  }) : super(key: key);

  @override
  State<CustomAuthenticationTextField> createState() =>
      _CustomAuthenticationTextFieldState();
}

class _CustomAuthenticationTextFieldState
    extends State<CustomAuthenticationTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      keyboardType: widget.keyboardType == null
          ? TextInputType.text
          : widget.keyboardType,
      obscureText: widget.obscureText != null
          ? widget.obscureText
              ? true
              : false
          : false,
      focusNode: widget.firstFocusNode,
      onFieldSubmitted: (term) {
        widget.firstFocusNode.unfocus();
        FocusScope.of(context).requestFocus(widget.secondFocusNode);
      },
      textInputAction: widget.secondFocusNode != null
          ? TextInputAction.next
          : TextInputAction.done,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 20),
        border: InputBorder.none,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}
