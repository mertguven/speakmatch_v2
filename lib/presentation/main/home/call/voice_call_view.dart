import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
/*
class VoiceCallView extends StatefulWidget {
  const VoiceCallView({Key key}) : super(key: key);

  @override
  _VoiceCallViewState createState() => _VoiceCallViewState();
}

class _VoiceCallViewState extends State<VoiceCallView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Text("Voice Call View"),
      ),
    );
  }
}*/

import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart';
import 'package:speakmatch_v2/cubit/home/call/call_cubit.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/presentation/main/home/call/agora_settings.dart';
import 'package:speakmatch_v2/presentation/main/page_router_view.dart';
import 'package:wakelock/wakelock.dart';

class VoiceCallView extends StatefulWidget {
  final UserResponseModel matchedUser;

  final ClientRole role = ClientRole.Broadcaster;
  final String token, roomName;

  /// Creates a call page with given channel name.
  const VoiceCallView({Key key, this.matchedUser, this.token, this.roomName})
      : super(key: key);

  @override
  _VoiceCallViewState createState() => _VoiceCallViewState();
}

class _VoiceCallViewState extends State<VoiceCallView> {
  Rx<bool> muted = false.obs;
  final _users = <int>[];
  final _infoStrings = <String>[];
  RtcEngine _engine;
  CountDownController _controller = CountDownController();
  Rx<bool> userJoined = false.obs;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
    initialize();
  }

  Future<void> initialize() async {
    if (AgoraSettings.APP_ID.isEmpty) {
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
    await _engine.joinChannel(widget.token, widget.roomName, null, 0);
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(AgoraSettings.APP_ID);
    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role);
  }

  // Initialize the app
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'Lütfen kanala tekrar katılın!';
        //_snackbar(info, Colors.red);
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      /*setState(() {
        final info = 'Kanala katıldın.';
        _snackbar(info, Colors.green);
        _infoStrings.add(info);
      });*/
    }, userOffline: (uid, elapsed) {
      setState(() {
        _users.remove(uid);
        userJoined = false.obs;
      });
    }, leaveChannel: (stats) {
      setState(() {
        _users.clear();
        userJoined = false.obs;
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        userJoined = true.obs;
        //_infoStrings.add(info);
        _users.add(uid);
      });
    }));
  }

  void _onCallEnd() {
    context.read<CallCubit>().deleteUserAtWaitingRoom().whenComplete(() =>
        Get.offAll(() => PageRouterView(),
            transition: Transition.noTransition));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 2),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: NetworkImage(widget.matchedUser.imageUrl),
                ),
              ),
              Text(
                widget.matchedUser.displayName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5),
              ),
            ],
          ),
          Spacer(flex: 2),
          CircularCountDownTimer(
            duration: 600,
            initialDuration: 0,
            controller: _controller,
            isReverse: true,
            ringColor: Colors.white54,
            ringGradient: null,
            fillColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Colors.white,
            strokeWidth: 20.0,
            strokeCap: StrokeCap.round,
            onComplete: () => _onCallEnd(),
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 2,
            textStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 40,
                fontWeight: FontWeight.w600),
          ),
          /*Stack(
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
                    onComplete: () => _onCallEnd(),
                    fillColor: Colors.white,
                    backgroundColor: Colors.white,
                    height: MediaQuery.of(context).size.height / 4,
                    ringColor: Colors.transparent,
                    width: MediaQuery.of(context).size.width / 2,
                    textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 40,
                        fontWeight: FontWeight.w600),
                  ),
                  /*Visibility(
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
                  ),*/
                ],
              ),
            ],
          ),*/
          Spacer(flex: 6),
        ],
      ),
    ));
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
                onPressed: () {},
                child: Icon(
                  FontAwesomeIcons.plus,
                  color: Theme.of(context).colorScheme.primary,
                  size: 35.0,
                ),
                elevation: 10,
                shape: CircleBorder(),
                fillColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(12.0),
              ),
              RawMaterialButton(
                onPressed: _onToggleMute,
                child: Icon(
                  muted.value ? Icons.mic_off : Icons.mic,
                  color: muted.value
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary,
                  size: 35.0,
                ),
                shape: CircleBorder(),
                elevation: 10,
                fillColor: muted.value
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                padding: const EdgeInsets.all(12.0),
              ),
              RawMaterialButton(
                onPressed: () {},
                child: Icon(
                  FontAwesomeIcons.stopwatch,
                  color: Theme.of(context).colorScheme.primary,
                  size: 35.0,
                ),
                elevation: 10,
                shape: CircleBorder(),
                fillColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(12.0),
              ),
            ],
          ),
          SizedBox(height: 20),
          FractionallySizedBox(
            widthFactor: 0.7,
            child: ElevatedButton(
                onPressed: () => _onCallEnd(),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    primary: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    shadowColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    elevation: 10),
                child: Text(
                  "Exit",
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
    muted.toggle();
    _engine.muteLocalAudioStream(muted.value);
  }
}
