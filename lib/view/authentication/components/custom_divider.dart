import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final String centerText;
  final Color color;
  const CustomDivider({
    Key key,
    this.centerText,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[
                    color == null ? Colors.white10 : color.withOpacity(0.10),
                    color == null ? Colors.white : color,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 1.0),
                  stops: <double>[0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            height: 1.0,
          ),
        ),
        centerText == null || centerText == ""
            ? SizedBox()
            : Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text(
                  centerText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[
                    color == null ? Colors.white : color,
                    color == null ? Colors.white10 : color.withOpacity(0.10),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 1.0),
                  stops: <double>[0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
