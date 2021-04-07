import 'package:speakmatch_v2/controller/interfaces/ihome_base.dart';
import 'package:speakmatch_v2/model/home/call/request/ListenFreezeTimeRequestMessage.dart';
import 'package:speakmatch_v2/model/home/call/request/TrackMeetTimeRequestMessage.dart';
import 'package:speakmatch_v2/model/home/call/response/GenerateAgoraTokenResponseMessage.dart';
import 'package:speakmatch_v2/model/home/call/response/ListenFreezeTimeResponseMessage.dart';
import 'package:speakmatch_v2/model/home/call/response/SelectOnlineUserResponseMessage.dart';
import 'package:speakmatch_v2/model/home/call/response/TrackMeetTimeResponseMessage.dart';
import 'package:speakmatch_v2/model/home/request/UserStatusChangeRequestMessage.dart';
import 'package:speakmatch_v2/model/home/response/GetOnlineUsersResponseMessage.dart';
import 'package:speakmatch_v2/model/home/response/UserStatusChangeResponseMessage.dart';
import 'package:speakmatch_v2/service/web_service.dart';

class HomeController extends IHomeBase {
  WebService _webService = WebService();
  dynamic _requestBody;

  @override
  Future<UserStatusChangeResponseMessage> changeUserStatus(
      UserStatusChangeRequestMessage request) async {
    _requestBody = {"status": request.status};
    final item = await _webService.sendRequestWithPostAndToken(
        "UserStatusChange", _requestBody);
    var userStatusChangeResponseMessage =
        UserStatusChangeResponseMessage.fromJson(item);
    return userStatusChangeResponseMessage;
  }

  @override
  Future<GetOnlineUsersResponseMessage> getOnlineUsers() async {
    final item = await _webService.sendRequestWithGet("GetOnlineUsers");
    var getOnlineUsersResponseMessage =
        GetOnlineUsersResponseMessage.fromJson(item);
    return getOnlineUsersResponseMessage;
  }

  @override
  Future<SelectOnlineUserResponseMessage> selectOnlineUser() async {
    final item = await _webService.sendRequestWithGet("SelectOnlineUser");
    var selectOnlineUserResponseMessage =
        SelectOnlineUserResponseMessage.fromJson(item);
    return selectOnlineUserResponseMessage;
  }

  @override
  Future<GenerateAgoraTokenResponseMessage> generateAgoraToken() async {
    final item = await _webService.sendRequestWithPostAndToken(
        "GenerateAgoraToken", _requestBody);
    var generateAgoraTokenResponseMessage =
        GenerateAgoraTokenResponseMessage.fromJson(item);
    return generateAgoraTokenResponseMessage;
  }

  @override
  Future<TrackMeetTimeResponseMessage> trackMeetTime(
      TrackMeetTimeRequestMessage request) async {
    _requestBody = {
      "oda_no": request.odaNo,
      "freezeTime": request.freezeTime,
    };
    final item = await _webService.sendRequestWithPostAndToken(
        "TrackMeetTime", _requestBody);
    var trackMeetTimeResponseMessage =
        TrackMeetTimeResponseMessage.fromJson(item);
    return trackMeetTimeResponseMessage;
  }

  @override
  Future<ListenFreezeTimeResponseMessage> listenFreezeTime(
      ListenFreezeTimeRequestMessage request) async {
    _requestBody = {"oda_no": request.odaNo};
    final item = await _webService.sendRequestWithPostAndToken(
        "ListenFreezeTime", _requestBody);
    var listenFreezeTimeResponseMessage =
        ListenFreezeTimeResponseMessage.fromJson(item);
    return listenFreezeTimeResponseMessage;
  }
}
