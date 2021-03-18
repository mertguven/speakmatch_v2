import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:speakmatch_v2/controller/home/home_controller.dart';
import 'package:speakmatch_v2/core/components/gradient_text.dart';
import 'package:speakmatch_v2/model/home/request/UserStatusChangeRequestMessage.dart';
import 'package:speakmatch_v2/view/main/home/call/calling_view.dart';
import 'package:speakmatch_v2/view/main/home/notification_view.dart';
import 'package:speakmatch_v2/view/main/pricing/pricing_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int numberOfNotification = 0;
  bool showProfile = true;
  bool closeAds = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appbarWithNotification(context),
      body: homeBody(context),
    );
  }

  Container homeBody(BuildContext context) => Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.9],
            colors: [
              Color(0xFFD64565),
              Color(0xffe08791),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(flex: 2, child: topInformationContainer()),
            Expanded(flex: 4, child: callButton()),
            Expanded(
                flex: 2, child: bottomSettingsAndPremiumContainer(context)),
          ],
        ),
      );

  AppBar appbarWithNotification(BuildContext context) => AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Stack(
            children: [
              IconButton(
                iconSize: 30,
                icon: Icon(FontAwesomeIcons.solidBell,
                    color: Theme.of(context).accentColor),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationView())),
              ),
              Visibility(
                visible: numberOfNotification == 0 ? false : true,
                child: Positioned(
                  top: 0,
                  right: 4,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Text(
                      numberOfNotification.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  Container bottomSettingsAndPremiumContainer(BuildContext context) =>
      Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              blurRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Icon(
                            FontAwesomeIcons.solidEye,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Profili Göster",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Switch(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: showProfile,
                            onChanged: (change) {
                              setState(() {
                                showProfile = !showProfile;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Icon(
                              FontAwesomeIcons.ad,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Reklamları Kapat",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Switch(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: closeAds,
                              onChanged: (change) {
                                setState(() {
                                  closeAds = !closeAds;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey.shade100,
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PricingView(isThereAnAppbar: true))),
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Lottie.asset("assets/animations/gem.json"),
                      ),
                      Expanded(
                        child: GradientText("Premium Satın Al", 16,
                            gradient: LinearGradient(colors: [
                              Color(0xffe08791),
                              Color(0xffffe400)
                            ])),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );

  GestureDetector callButton() => GestureDetector(
        onTap: () {
          _changeTheStatus();
        },
        child: Lottie.asset("assets/animations/call.json"),
      );

  Container topInformationContainer() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Arama Yap",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "ve yeni insanlarla tanış!",
              style: TextStyle(
                  color: Colors.grey.shade300, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  Future<void> _changeTheStatus() async {
    var homeController = Provider.of<HomeController>(context, listen: false);
    var permissionStatus = await _handleMic(Permission.microphone);
    if (permissionStatus.isGranted) {
      UserStatusChangeRequestMessage request =
          UserStatusChangeRequestMessage(status: "Online");
      var response = await homeController.changeUserStatus(request);
      if (response.success) {
        Navigator.push(
            context,
            PageTransition(
                child: CallingView(), type: PageTransitionType.fade));
      }
    }
  }

  Future<PermissionStatus> _handleMic(Permission permission) async {
    final status = await permission.request();
    print(status);
    return status;
  }
}
