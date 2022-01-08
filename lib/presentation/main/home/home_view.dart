import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:speakmatch_v2/core/utilities/ad_view.dart';
import 'package:speakmatch_v2/core/utilities/custom_dialog.dart';
import 'package:speakmatch_v2/cubit/home/home_cubit.dart';
import 'package:speakmatch_v2/presentation/main/home/call/calling_view.dart';
import 'package:speakmatch_v2/presentation/main/home/notification/notification_view.dart';
import 'package:speakmatch_v2/presentation/main/page_router_view.dart';
import 'package:speakmatch_v2/shared-prefs.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Rx<bool> _adsStatus = true.obs;
  Rx<bool> _profileDisplayStatus = true.obs;

  @override
  void initState() {
    _adsStatus.value = SharedPrefs.getAdStatus;
    _profileDisplayStatus.value = SharedPrefs.getProfileDisplayStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          _redContainer(context),
          _whiteContainer(context),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () => _redirectNotificationView(),
            icon: Icon(FontAwesomeIcons.solidBell)),
      ],
    );
  }

  Expanded _redContainer(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              offset: Offset(0, 5),
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
            ),
          ],
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(context.width, context.height * 0.15),
          ),
        ),
        child: Column(
          children: [
            Text(
              "call".tr,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
            _callButton(context),
            Text(
              "andMeetNewPeople".tr,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Padding _callButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: AvatarGlow(
        endRadius: context.width / 3.5,
        duration: Duration(seconds: 3),
        child: InkWell(
          onTap: () => _callMethod(),
          child: Material(
            elevation: 8.0,
            shape: CircleBorder(),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                FontAwesomeIcons.phone,
                color: Theme.of(context).colorScheme.primary,
                size: context.width / 10,
              ),
              radius: context.width / 8,
            ),
          ),
        ),
      ),
    );
  }

  Expanded _whiteContainer(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _adStatusContainer(),
              _hideProfileContainer(),
            ],
          ),
        ));
  }

  Container _adStatusContainer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 50),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.ad,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(
              _adsStatus.value ? "adsOn".tr : "adsOff".tr,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Switch.adaptive(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: _adsStatus.value,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (change) => changeAdStatus(),
            ),
          ],
        ),
      ),
    );
  }

  Container _hideProfileContainer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 50),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.shieldAlt,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(
              _profileDisplayStatus.value ? "showProfile".tr : "hideProfile".tr,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Switch.adaptive(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: _profileDisplayStatus.value,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (change) => changeProfileDisplayStatus(),
            ),
          ],
        ),
      ),
    );
  }

  void _redirectNotificationView() {
    Get.to(() => NotificationView(), transition: Transition.cupertino);
  }

  void _callMethod() {
    Permission.microphone.request().then((value) {
      if (value == PermissionStatus.granted) {
        if (SharedPrefs.getAdStatus) {
          AdView().loadInterstitialAd(CallingView());
        } else {
          Get.to(() => CallingView(), transition: Transition.fadeIn);
        }
      }
    });
  }

  Future<void> changeAdStatus() async {
    final user = await context.read<HomeCubit>().getUser();
    if (user.isVip) {
      _adsStatus.toggle();
      SharedPrefs.changeAdStatus();
    } else {
      customDialog(
        context,
        lottiePath: "assets/animations/go_premium_now.json",
        onPressed: () => Get.offAll(() => PageRouterView(pageToShow: 0),
            transition: Transition.leftToRightWithFade),
        buttonText: "upgradeNow".tr,
        title: "vipMembershipRequired".tr,
        content: "youMustHaveAVipMembershipToBeAbleToTurnOffAds".tr,
      );
    }
  }

  Future<void> changeProfileDisplayStatus() async {
    _profileDisplayStatus.toggle();
    SharedPrefs.changeProfileDisplayStatus();
  }
}
