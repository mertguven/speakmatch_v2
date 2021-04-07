import 'package:speakmatch_v2/model/home/call/request/ListenFreezeTimeRequestMessage.dart';
import 'package:speakmatch_v2/model/home/call/request/TrackMeetTimeRequestMessage.dart';
import 'package:speakmatch_v2/model/home/call/response/GenerateAgoraTokenResponseMessage.dart';
import 'package:speakmatch_v2/model/home/call/response/ListenFreezeTimeResponseMessage.dart';
import 'package:speakmatch_v2/model/home/call/response/SelectOnlineUserResponseMessage.dart';
import 'package:speakmatch_v2/model/home/call/response/TrackMeetTimeResponseMessage.dart';
import 'package:speakmatch_v2/model/home/request/UserStatusChangeRequestMessage.dart';
import 'package:speakmatch_v2/model/home/response/GetOnlineUsersResponseMessage.dart';
import 'package:speakmatch_v2/model/home/response/UserStatusChangeResponseMessage.dart';

abstract class IHomeBase {
  Future<UserStatusChangeResponseMessage> changeUserStatus(
      UserStatusChangeRequestMessage request);
  Future<GetOnlineUsersResponseMessage> getOnlineUsers();
  Future<SelectOnlineUserResponseMessage> selectOnlineUser();
  Future<GenerateAgoraTokenResponseMessage> generateAgoraToken();
  Future<TrackMeetTimeResponseMessage> trackMeetTime(
      TrackMeetTimeRequestMessage request);
  Future<ListenFreezeTimeResponseMessage> listenFreezeTime(
      ListenFreezeTimeRequestMessage request);
}
