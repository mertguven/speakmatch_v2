import 'package:flutter/material.dart';

class PricingView extends StatefulWidget {
  final bool isThereAnAppbar;

  const PricingView({this.isThereAnAppbar});

  @override
  _PricingViewState createState() => _PricingViewState();
}

class _PricingViewState extends State<PricingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.isThereAnAppbar ? AppBar() : AppBar(elevation: 0),
      body: Center(
        child: Container(
          child: Text("Pricing View"),
        ),
      ),
    );
  }
}
