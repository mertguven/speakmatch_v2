import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SMNavigationBar extends StatefulWidget {
  final double height;
  final int index;
  List<Icon> items;
  final Color color;
  final ValueChanged<int> onTap;

  SMNavigationBar(
      {Key key, this.height, this.color, this.index, this.items, this.onTap});

  @override
  _SMNavigationBarState createState() => _SMNavigationBarState();
}

class _SMNavigationBarState extends State<SMNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
          color: widget.color,
          border: Border(top: BorderSide(color: Colors.grey, width: 0.3))),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          widget.items.length,
          (index) {
            return Expanded(
              child: InkWell(
                onTap: () => widget.onTap(index),
                child: Ink(child: widget.items[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
