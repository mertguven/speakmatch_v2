import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/presentation/main/home/home_view.dart';
import 'package:speakmatch_v2/presentation/main/premium/premium_view.dart';
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

  List<Widget> _buildScreens() => [PremiumView(), HomeView(), ProfileView()];

  List<Widget> _bottomNavbarItem() => [
        Expanded(
          flex: 2,
          child: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () => changePage(0),
            icon: Icon(FontAwesomeIcons.solidGem),
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
