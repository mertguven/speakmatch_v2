import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/data/model/home/request/agora_access_token_request_model.dart';
import 'package:speakmatch_v2/data/model/home/response/agora_access_token_response_model.dart';
import 'package:speakmatch_v2/data/repositories/call_repo.dart';

class CallController {
  CallRepository _callRepository = CallRepository();

  Future<void> calling() async {
    try {
      return await _callRepository.calling();
    } catch (e) {
      print("call controller error:" + e.toString());
      return null;
    }
  }

  Future<void> deleteUserAtWaitingRoom() async {
    try {
      await _callRepository.deleteUserAtWaitingRoom();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserResponseModel> getMatchingUsersInfo(String userUid) async {
    try {
      return await _callRepository.getMatchingUsersInfo(userUid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> removeMeetingRoom() async {
    try {
      await _callRepository.removeMeetingRoom();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<AgoraAccessTokenResponseModel> getAgoraAccessToken(
      AgoraAccessTokenRequestModel model) async {
    try {
      return await _callRepository.getAgoraAccessToken(model);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listeningToMeetingRooms() async* {
    try {
      yield* _callRepository.listeningToMeetingRooms();
    } catch (e) {
      print("call controller error:" + e.toString());
      yield null;
    }
  }
}
