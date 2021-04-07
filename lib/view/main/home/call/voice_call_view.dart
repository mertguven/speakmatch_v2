import 'dart:async';
import 'dart:ui';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:screen/screen.dart';
import 'package:speakmatch_v2/controller/home/home_controller.dart';
import 'package:speakmatch_v2/model/home/call/request/ListenFreezeTimeRequestMessage.dart';
import 'package:speakmatch_v2/model/home/call/request/TrackMeetTimeRequestMessage.dart';
import 'package:speakmatch_v2/model/home/call/response/ListenFreezeTimeResponseMessage.dart';
import 'package:speakmatch_v2/model/home/call/response/SelectOnlineUserResponseMessage.dart';
import 'package:speakmatch_v2/model/home/request/UserStatusChangeRequestMessage.dart';
import 'package:speakmatch_v2/utilities/settings.dart';
import 'package:speakmatch_v2/view/main/home/call/call_end_view.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class VoiceCallView extends StatefulWidget {
  final ClientRole role = ClientRole.Broadcaster;
  final String token;
  final SelectOnlineUserResponseMessage response;

  const VoiceCallView({Key key, this.token, this.response}) : super(key: key);

  @override
  _VoiceCallViewState createState() => _VoiceCallViewState();
}

class _VoiceCallViewState extends State<VoiceCallView> {
  bool muted = false;
  bool isfreeze = false;
  int freezeCounter = 1;
  final _users = <int>[];
  final _infoStrings = <String>[];
  RtcEngine _engine;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isUserOnline = false;
  CountDownController _controller = CountDownController();
  StreamController<ListenFreezeTimeResponseMessage> streamController =
      StreamController<ListenFreezeTimeResponseMessage>();
  StreamSubscription<ListenFreezeTimeResponseMessage> streamSubscription;
  Stream stream;

  Timer _timer;
  int _freezeCounterTimer = 30;

  void startFreezeTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (_freezeCounterTimer == 1) {
          var homeController =
              Provider.of<HomeController>(context, listen: false);
          TrackMeetTimeRequestMessage request = TrackMeetTimeRequestMessage(
              odaNo: widget.response.roomNo, freezeTime: 0);
          await homeController.trackMeetTime(request);
          setState(() {
            timer.cancel();
            isfreeze = false;
            _controller.resume();
          });
        } else {
          setState(() {
            _freezeCounterTimer--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
    _timer.cancel();
    streamSubscription?.cancel();
  }

  @override
  void initState() {
    super.initState();
    changeStatus();
    Screen.keepOn(true);
    print(widget.token);
    initialize();
    stream = streamController.stream;
    listenToFreeze();
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await _engine.joinChannel(widget.token, "pUWVRYAEouEPNnTz", null, 0);
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role);
  }

  _snackbar(bool success, String content) {
    Get.snackbar(null, null,
        margin: EdgeInsets.all(15),
        duration: Duration(seconds: 5),
        borderRadius: 7,
        messageText: Text(
          content,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        icon: Icon(
          success ? Icons.done : Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: success ? Colors.lightGreen : Color(0xffD64565),
        snackPosition: SnackPosition.TOP);
  }

  // Initialize the app
  void _addAgoraEventHandlers() {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'Lütfen kanala tekrar katılın!';
        _snackbar(false, code.toString());
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = 'Kanala katıldın.';
        _snackbar(true, info);
        _infoStrings.add(info);
      });
      Future.delayed(
          Duration(seconds: 5), () => deleteInfoString(_infoStrings));
    }, userOffline: (uid, elapsed) {
      setState(() {
        _users.remove(uid);
        _onCallEnd(context);
        isUserOnline = false;
      });
    }, leaveChannel: (stats) {
      setState(() {
        _users.clear();
        isUserOnline = false;
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = '${widget.response.username} giriş yaptı.';
        _snackbar(true, info);
        _infoStrings.add(info);
        _users.add(uid);
        isUserOnline = true;
      });
      Future.delayed(
          Duration(seconds: 5), () => deleteInfoString(_infoStrings));
    }));
  }

  void _onCallEnd(BuildContext context) async {
    var homeController = Provider.of<HomeController>(context, listen: false);
    UserStatusChangeRequestMessage request =
        UserStatusChangeRequestMessage(status: "Idle");
    await homeController.changeUserStatus(request);
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => CallEndView(response: widget.response),
      ),
      (_) => false,
    );
  }

  // Create a simple chat UI
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        body: Center(
          child: Stack(
            children: <Widget>[
              _viewRows(),
              _toolbar(),
            ],
          ),
        ),
      ),
    );
  }

  deleteInfoString(List<String> infoStrings) {
    _infoStrings.clear();
  }

  TextStyle customTextStyle() {
    return TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 20);
  }

  Widget _toolbar() {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RawMaterialButton(
                onPressed: _onToggleMute,
                child: Icon(
                  muted ? Icons.mic_off : Icons.mic,
                  color: muted ? Colors.white : Theme.of(context).accentColor,
                  size: 35.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: muted ? Theme.of(context).accentColor : Colors.white,
                padding: const EdgeInsets.all(12.0),
              ),
              Column(
                children: [
                  Text(
                    freezeCounter.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: freezeCounter == 0
                        ? null
                        : () {
                            _controller.pause();
                            setState(() {
                              isfreeze = true;
                              freezeCounter--;
                              trackMeetTime();
                            });
                          },
                    child: Icon(
                      FontAwesomeIcons.snowflake,
                      color: isfreeze
                          ? Colors.white
                          : Theme.of(context).accentColor,
                      size: 35.0,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor:
                        isfreeze ? Theme.of(context).accentColor : Colors.white,
                    padding: const EdgeInsets.all(12.0),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          FractionallySizedBox(
            widthFactor: 0.7,
            child: ElevatedButton(
                onPressed: () => _onCallEnd(context),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    primary: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    shadowColor: Theme.of(context).accentColor.withOpacity(0.5),
                    elevation: 10),
                child: Text(
                  "Bitir",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[_videoView(views[0])],
        ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
          ],
        ));
    }
    return Container();
  }

  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  Widget _videoView(view) {
    return Expanded(
        child: Container(
      alignment: Alignment.center,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 3),
          Text(
            widget.response.username,
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5),
          ),
          Spacer(),
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.width / 3,
                backgroundColor: Colors.white.withOpacity(0.05),
              ),
              CircleAvatar(
                radius: MediaQuery.of(context).size.width / 3.5,
                backgroundColor: Colors.white.withOpacity(0.15),
              ),
              CircleAvatar(
                radius: MediaQuery.of(context).size.width / 4,
                backgroundColor: Colors.white.withOpacity(0.25),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircularCountDownTimer(
                    duration: 60,
                    initialDuration: 0,
                    controller: _controller,
                    isReverse: true,
                    onComplete: () => _onCallEnd(context),
                    fillColor: Colors.white,
                    backgroundColor: Colors.white,
                    height: MediaQuery.of(context).size.height / 4,
                    ringColor: Colors.transparent,
                    width: MediaQuery.of(context).size.width / 2,
                    textStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w600),
                  ),
                  Visibility(
                    visible: isfreeze ? true : false,
                    child: Center(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.4,
                          height: MediaQuery.of(context).size.height / 4.4,
                          decoration: new BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Text(
                            "+" + "$_freezeCounterTimer",
                            style: TextStyle(
                                color: Colors.cyan,
                                fontSize: 40,
                                fontWeight: FontWeight.w600),
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(flex: 6),
        ],
      ),
    ));
  }

  changeStatus() async {
    var homeController = Provider.of<HomeController>(context, listen: false);
    UserStatusChangeRequestMessage request =
        UserStatusChangeRequestMessage(status: "Busy");
    await homeController.changeUserStatus(request);
  }

  listenToFreeze() async {
    var homeController = Provider.of<HomeController>(context, listen: false);

    while (true) {
      ListenFreezeTimeRequestMessage request =
          ListenFreezeTimeRequestMessage(odaNo: widget.response.roomNo);
      var response = await homeController.listenFreezeTime(request);
      if (response.freezeTime == "1") {
        streamController.add(response);
        streamSubscription = stream.listen((value) async {
          streamSubscription?.cancel();
          setState(() {
            isfreeze = true;
            startFreezeTimer();
          });
        });
        break;
      }
    }
  }

  trackMeetTime() async {
    var homeController = Provider.of<HomeController>(context, listen: false);
    TrackMeetTimeRequestMessage request = TrackMeetTimeRequestMessage(
        odaNo: widget.response.roomNo, freezeTime: 1);
    await homeController.trackMeetTime(request);
  }
}
