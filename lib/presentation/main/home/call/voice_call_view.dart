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
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:speakmatch_v2/cubit/home/call/call_cubit.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/presentation/main/home/call/agora_settings.dart';
import 'package:speakmatch_v2/presentation/main/page_router_view.dart';
import 'package:speakmatch_v2/shared-prefs.dart';
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
  RtcEngine _engine;
  CountDownController _controller = CountDownController();
  Rx<bool> userJoined = false.obs;
  String _defaultUserImageNetworkUrl =
      "https://firebasestorage.googleapis.com/v0/b/speakmatch-30ca9.appspot.com/o/user.png?alt=media&token=6c742266-21ba-4dab-b30e-086152cdaa08";

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
      print(code);
    }, joinChannelSuccess: (channel, uid, elapsed) {
      print("successful to join the channel");
    }, userOffline: (uid, elapsed) {
      userJoined = false.obs;
      _users.remove(uid);
      _onCallEnd();
      _controller.pause();
      print("2nd user offline");
    }, leaveChannel: (stats) {
      userJoined = false.obs;
      _users.clear();
    }, userJoined: (uid, elapsed) {
      userJoined.value = true;
      _users.add(uid);
      _controller.start();
      print("2nd user joined");
    }));
  }

  void _onToggleMute() {
    muted.toggle();
    _engine.muteLocalAudioStream(muted.value);
  }

  void _onCallEnd() {
    context.read<CallCubit>().removeMeetingRoom().whenComplete(
          () => Get.offAll(() => PageRouterView(),
              transition: Transition.noTransition),
        );
    /*context.read<CallCubit>().deleteUserAtWaitingRoom().whenComplete(() =>
        Get.offAll(() => PageRouterView(),
            transition: Transition.noTransition));*/
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
                  backgroundImage: NetworkImage(
                      SharedPrefs.getProfileDisplayStatus
                          ? widget.matchedUser.imageUrl
                          : _defaultUserImageNetworkUrl),
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
              Obx(() => Text(
                    userJoined.value ? "Online" : "Offline",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          Spacer(flex: 2),
          CircularCountDownTimer(
            onComplete: () => _onCallEnd(),
            duration: 60,
            autoStart: false,
            isReverse: true,
            controller: _controller,
            ringColor: Colors.white54,
            fillColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Colors.white,
            strokeWidth: 20.0,
            textFormat: CountdownTextFormat.S,
            strokeCap: StrokeCap.round,
            height: context.height / 4,
            width: context.width / 2,
            textStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 40,
                fontWeight: FontWeight.w600),
          ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Obx(
            () => RawMaterialButton(
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
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(),
            child: Icon(
              FontAwesomeIcons.phone,
              color: Theme.of(context).colorScheme.secondary,
              size: 35.0,
            ),
            elevation: 10,
            shape: CircleBorder(),
            fillColor: Theme.of(context).primaryColor,
            padding: const EdgeInsets.all(12.0),
          ),
        ],
      ),
    );
  }
}
