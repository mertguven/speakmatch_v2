import 'package:flutter/material.dart';
import 'package:speakmatch_v2/model/home/request/UserStatusChangeRequestMessage.dart';
import 'package:speakmatch_v2/model/home/response/GetOnlineUsersResponseMessage.dart';
import 'package:speakmatch_v2/model/home/response/UserStatusChangeResponseMessage.dart';

abstract class IHomeBase {
  Future<UserStatusChangeResponseMessage> changeUserStatus(
      UserStatusChangeRequestMessage request);
  Future<GetOnlineUsersResponseMessage> getOnlineUsers();
}
