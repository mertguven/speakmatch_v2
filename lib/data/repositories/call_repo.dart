import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/data/model/home/request/agora_access_token_request_model.dart';
import 'package:speakmatch_v2/data/model/home/response/agora_access_token_response_model.dart';
import 'package:speakmatch_v2/data/service/agora_token_service.dart';
import 'package:speakmatch_v2/data/service/firestore_service.dart';

class CallRepository {
  FirestoreService _firestoreService = FirestoreService();
  AgoraAccessTokenService _agoraAccessTokenService = AgoraAccessTokenService();

  Future<void> calling() async {
    try {
      await _firestoreService.pairingSystem();
    } catch (e) {
      print("call repository error:" + e.toString());
      return null;
    }
  }

  Future<AgoraAccessTokenResponseModel> getAgoraAccessToken(
      AgoraAccessTokenRequestModel model) async {
    try {
      final response =
          await _agoraAccessTokenService.getAgoraAccessToken(model);
      if (response.statusCode == 200) {
        return AgoraAccessTokenResponseModel.fromJson(response.data);
      } else {
        return AgoraAccessTokenResponseModel(
            errorMessage: "Something went wrong...");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> deleteUserAtWaitingRoom() async {
    try {
      await _firestoreService.deleteUserAtWaitingRoom();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserResponseModel> getMatchingUsersInfo(String userUid) async {
    try {
      final responseUser = await _firestoreService.getUserData(userUid);
      final model = UserResponseModel.fromJson(responseUser.data());
      return model;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> removeMeetingRoom() async {
    try {
      await _firestoreService.removeMeetingRoom();
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listeningToMeetingRooms() async* {
    try {
      yield* _firestoreService.listeningToMeetingRooms();
    } catch (e) {
      print("call repository error:" + e.toString());
      yield null;
    }
  }

  Future<UserResponseModel> currentUser() async {
    try {
      final responseUser = await _firestoreService.getUserData();
      final model = UserResponseModel.fromJson(responseUser.data());
      return model;
    } catch (e) {
      print("call repository error: " + e.toString());
      return null;
    }
  }
}
