import 'package:speakmatch_v2/presentation/main/home/call/agora_settings.dart';

class VoiceCallInitiator {
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
}
