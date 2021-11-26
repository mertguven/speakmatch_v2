import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:speakmatch_v2/controller/call_controller.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/data/model/home/request/agora_access_token_request_model.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit() : super(CallInitialState());

  CallController _callController = CallController();

  Future<void> calling() async {
    emit(CallLoadingState());
    await _callController.calling();
  }

  Future<UserResponseModel> getMatchingUsersInfo(String userUid) async {
    try {
      return await _callController.getMatchingUsersInfo(userUid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> deleteUserAtWaitingRoom() async {
    try {
      await _callController.deleteUserAtWaitingRoom();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getAgoraAccessToken(AgoraAccessTokenRequestModel model) async {
    final response = await _callController.getAgoraAccessToken(model);
    if (response != null && response.errorMessage == null) {
      emit(SuccessAgoraTokenState(response.token));
    } else {
      emit(UnSuccessAgoraTokenState(response.errorMessage));
    }
  }

  Future<void> removeMeetingRoom() async {
    try {
      await _callController.removeMeetingRoom();
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listeningToMeetingRooms() async* {
    yield* _callController.listeningToMeetingRooms();
  }
}
