import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  GradientText(
    this.text,
    this.fontSize, {
    @required this.gradient,
  });

  final double fontSize;
  final String text;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
