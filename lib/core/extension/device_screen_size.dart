import 'package:flutter/material.dart';

extension DeviceSizeExtension on BuildContext {
  double deviceWidth() => MediaQuery.of(this).size.width;
  double deviceHeight() => MediaQuery.of(this).size.height;
}
