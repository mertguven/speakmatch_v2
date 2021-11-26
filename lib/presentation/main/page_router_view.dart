import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/presentation/main/home/home_view.dart';
import 'package:speakmatch_v2/presentation/main/messages/messages_view.dart';
import 'package:speakmatch_v2/presentation/main/profile/profile_view.dart';

class PageRouterView extends StatefulWidget {
  final int pageToShow;
  const PageRouterView({Key key, this.pageToShow}) : super(key: key);

  @override
  _PageRouterViewState createState() => _PageRouterViewState();
}

class _PageRouterViewState extends State<PageRouterView> {
  PageController _pageController;
  Rx<int> _selectedIndex = 1.obs;

  @override
  void initState() {
    _pageController = PageController(
        initialPage: widget.pageToShow != null ? widget.pageToShow : 1);
    _pageController.addListener(() {
      _selectedIndex.value = _pageController.page.toInt();
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void changePage(int page) => _pageController.jumpToPage(page);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: _selectedIndex.value.toInt() == 1
              ? Theme.of(context).colorScheme.primary
              : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
                "assets/images/${_selectedIndex.value.toInt() == 1 ? "active_bnb_logo" : "inactive_bnb_logo"}.png"),
          ),
          onPressed: () => changePage(1),
        ),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: _buildScreens(),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            height: kBottomNavigationBarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _bottomNavbarItem(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      MessagesView(),
      HomeView(),
      ProfileView(),
    ];
  }

  List<Widget> _bottomNavbarItem() {
    return [
      Expanded(
        flex: 2,
        child: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () => changePage(0),
          icon: Icon(FontAwesomeIcons.solidComments),
          color: _selectedIndex.value.toInt() == 0
              ? Theme.of(context).colorScheme.primary
              : Colors.grey,
        ),
      ),
      Expanded(child: SizedBox()),
      Expanded(
        flex: 2,
        child: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () => changePage(2),
          icon: Icon(FontAwesomeIcons.solidUser),
          color: _selectedIndex.value.toInt() == 2
              ? Theme.of(context).colorScheme.primary
              : Colors.grey,
        ),
      )
    ];
  }
}

/*class PageRouterView extends StatefulWidget {
  final int pageToShow;
  const PageRouterView({Key key, this.pageToShow}) : super(key: key);

  @override
  _PageRouterViewState createState() => _PageRouterViewState();
}

class _PageRouterViewState extends State<PageRouterView> {
  PersistentTabController _controller;
  bool isSpeakmatchLogoActive = true;

  @override
  void initState() {
    _controller = PersistentTabController(
        initialIndex: widget.pageToShow == null ? 1 : widget.pageToShow);
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
        icon: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset("assets/images/active_bnb_logo.png"),
        ),
        activeColorPrimary: isSpeakmatchLogoActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).primaryColor,
        inactiveIcon: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset("assets/images/inactive_bnb_logo.png"),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesomeIcons.solidUser),
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
*/