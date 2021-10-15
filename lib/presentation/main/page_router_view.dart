import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:speakmatch_v2/presentation/main/home/home_view.dart';
import 'package:speakmatch_v2/presentation/main/messages/messages_view.dart';
import 'package:speakmatch_v2/presentation/main/profile/profile_view.dart';

class PageRouterView extends StatefulWidget {
  const PageRouterView({Key key}) : super(key: key);

  @override
  _PageRouterViewState createState() => _PageRouterViewState();
}

class _PageRouterViewState extends State<PageRouterView> {
  PersistentTabController _controller;
  bool isSpeakmatchLogoActive = true;

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 1);
    _controller.addListener(() {
      if (_controller.index == 1) {
        setState(() {
          isSpeakmatchLogoActive = true;
        });
      } else {
        setState(() {
          isSpeakmatchLogoActive = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      decoration: NavBarDecoration(
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        //colorBehindNavBar: Colors.black,
      ),
      navBarStyle: NavBarStyle.style15,
      screens: _buildScreens(),
      items: _navBarsItems(),
    );
  }

  List<Widget> _buildScreens() {
    return [
      MessagesView(),
      HomeView(),
      ProfileView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesomeIcons.solidComments),
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/images/active_bnb_logo.png"),
        activeColorPrimary: isSpeakmatchLogoActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).primaryColor,
        inactiveIcon: Image.asset("assets/images/inactive_bnb_logo.png"),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesomeIcons.solidUser),
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
