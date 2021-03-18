import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screen/screen.dart';
import 'package:speakmatch_v2/model/home/call/response/SelectOnlineUserResponseMessage.dart';
import 'package:speakmatch_v2/utilities/settings.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:speakmatch_v2/view/main/home/call/call_end_view.dart';

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
  final _users = <int>[];
  RtcEngine _engine;
  CountdownTimerController controller;
  bool isConsultantOnline = false;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = CountdownTimerController(endTime: 60000);
    Screen.keepOn(true);
    initialize();
  }

  Future<void> initialize() async {
    await _initAgoraRtcEngine();
    _engine.setEventHandler(RtcEngineEventHandler());
    await _engine.joinChannel(widget.token, "oda2", null, 0);
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role);
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onCallEnd(context);
        return true;
      },
      child: Scaffold(
        /*appBar: AppBar(
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CountdownTimer(
                  controller: controller,
                  widgetBuilder: (context, currentRemainingTime) {
                    if (currentRemainingTime.min == 5 &&
                        currentRemainingTime.sec == 00) {
                      Future.delayed(Duration(seconds: 1),
                          () => fillInfoString(_infoStrings));
                      return Text(
                        "${currentRemainingTime.min == null ? 00 : currentRemainingTime.min}:${currentRemainingTime.sec}",
                        style: customTextStyle(),
                      );
                    } else if (currentRemainingTime.min == 4 &&
                        currentRemainingTime.sec == 53) {
                      Future.delayed(Duration(seconds: 1),
                          () => deleteInfoString(_infoStrings));
                      return Text(
                        "${currentRemainingTime.min == null ? 00 : currentRemainingTime.min}:${currentRemainingTime.sec}",
                        style: customTextStyle(),
                      );
                    } else if (currentRemainingTime.sec == 1 &&
                        currentRemainingTime.min == null) {
                      Future.delayed(
                          Duration(milliseconds: 500),
                          () => Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => SessionCompletePage(),
                                ),
                                (_) => false,
                              ));

                      return Text(
                        "${currentRemainingTime.min == null ? 00 : currentRemainingTime.min}:${currentRemainingTime.sec == null ? 00 : currentRemainingTime.sec}",
                        style: customTextStyle(),
                      );
                    } else {
                      return Text(
                        "${currentRemainingTime.min == null ? 00 : currentRemainingTime.min}:${currentRemainingTime.sec == null ? 00 : currentRemainingTime.sec}",
                        style: customTextStyle(),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),*/
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            children: <Widget>[
              CountdownTimer(
                controller: controller,
                widgetBuilder: (context, currentRemainingTime) {
                  if (currentRemainingTime.sec == 1) {
                    Future.delayed(
                        Duration(milliseconds: 500),
                        () => Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => CallEndView(),
                              ),
                              (_) => false,
                            ));

                    return Text(
                      "${currentRemainingTime.sec == null ? 00 : currentRemainingTime.sec}",
                      style: customTextStyle(),
                    );
                  } else {
                    return Text(
                      "${currentRemainingTime.sec == null ? 00 : currentRemainingTime.sec}",
                      style: customTextStyle(),
                    );
                  }
                },
              ),
              _toolbar(),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle customTextStyle() {
    return TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 20);
  }

  Widget _toolbar() {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 30.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
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

  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }
}
