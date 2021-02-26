import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:speakmatch_v2/core/components/sm_bottom_navigation_bar.dart';
import 'package:speakmatch_v2/view/main/couple/couple_view.dart';
import 'package:speakmatch_v2/view/main/home/home_view.dart';
import 'package:speakmatch_v2/view/main/pricing/pricing_view.dart';
import 'package:speakmatch_v2/view/main/profile/profile_view.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _view = 0;
  int navigationIndex = 0;
  String currentTitle = 'Home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentView(_view),
      bottomNavigationBar: SMNavigationBar(
        color: Colors.white,
        height: 60,
        items: [
          Icon(FontAwesomeIcons.home,
              color: navigationIndex == 0
                  ? Theme.of(context).accentColor
                  : Colors.grey),
          Icon(FontAwesomeIcons.coins,
              color: navigationIndex == 1
                  ? Theme.of(context).accentColor
                  : Colors.grey),
          Icon(FontAwesomeIcons.solidHeart,
              color: navigationIndex == 2
                  ? Theme.of(context).accentColor
                  : Colors.grey),
          Icon(FontAwesomeIcons.userAlt,
              color: navigationIndex == 3
                  ? Theme.of(context).accentColor
                  : Colors.grey),
        ],
        onTap: (index) {
          setState(() {
            navigationIndex = index;
            _view = index;
            _currentView(_view);
          });
        },
      ),
    );
  }

  Widget _currentView(int view) {
    switch (view) {
      case 0:
        currentTitle = 'Home';
        return HomeView();
      case 1:
        currentTitle = 'Pricing';
        return PricingView();
      case 2:
        currentTitle = 'Couple';
        return CoupleView();
      case 3:
        currentTitle = 'Profile';
        return ProfileView();
      default:
        currentTitle = 'Home';
        return HomeView();
    }
  }
}
