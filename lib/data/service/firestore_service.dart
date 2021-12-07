import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/data/model/profile/response/delete_user_response_model.dart';
import 'package:speakmatch_v2/shared-prefs.dart';

class FirestoreService {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(
      [String userUid]) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await _fireStore
          .collection("users")
          .doc(userUid == null ? SharedPrefs.getUid : userUid)
          .get();
      return documentSnapshot;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<DeleteUserResponseModel> deleteUser() async {
    try {
      await _fireStore.collection("users").doc(SharedPrefs.getUid).delete();
      return DeleteUserResponseModel(success: true);
    } on FirebaseException catch (e) {
      return DeleteUserResponseModel(success: false, message: e.message);
    }
  }

  Future<void> deleteUserAtWaitingRoom() async {
    try {
      await _fireStore
          .collection("voice_match")
          .doc("waiting_room")
          .collection("users")
          .doc(SharedPrefs.getUid)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> removeMeetingRoom() async {
    try {
      await _fireStore
          .collection("voice_match")
          .doc("meeting_rooms")
          .collection("rooms")
          .get()
          .then((value) => value.docs.every((element) {
                if (element.id.contains(SharedPrefs.getUid)) {
                  _fireStore
                      .collection("voice_match")
                      .doc("meeting_rooms")
                      .collection("rooms")
                      .doc(element.id)
                      .delete()
                      .whenComplete(() => true);
                }
                return false;
              }));
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listeningToMeetingRooms() async* {
    try {
      yield* FirebaseFirestore.instance
          .collection("voice_match")
          .doc("meeting_rooms")
          .collection("rooms")
          .snapshots();
    } catch (e) {
      print(e.toString());
      yield null;
    }
  }

  Future<void> pairingSystem() async {
    try {
      var response = await _fireStore
          .collection("voice_match")
          .doc("waiting_room")
          .collection("users")
          .get();

      if (response == null || response.size == 0) {
        await _fireStore
            .collection("voice_match")
            .doc("waiting_room")
            .collection("users")
            .doc(SharedPrefs.getUid)
            .set({'uid': '${SharedPrefs.getUid}'});
      } else {
        if (!(response.docs
            .any((element) => element.id.contains(SharedPrefs.getUid)))) {
          await _fireStore
              .collection("voice_match")
              .doc("meeting_rooms")
              .collection("rooms")
              .doc("${response.docs.last.id}-${SharedPrefs.getUid}")
              .set({
            'roomNo': '${response.docs.last.id}-${SharedPrefs.getUid}',
            'user1': '${SharedPrefs.getUid}',
            'user2': '${response.docs.last.id}'
          });
        }
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<bool> saveUser(UserResponseModel model) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _fireStore.doc("users/${model.uid}").get();
      if (documentSnapshot.data() == null) {
        await _fireStore.collection("users").doc(model.uid).set(model.toJson());
      }
      return true;
    } catch (e) {
      print("firestore service error:" + e.toString());
      return false;
    }
  }

  Future<UserResponseModel> readUser(UserResponseModel model) async {
    try {
      DocumentSnapshot _documentSnapshot =
          await _fireStore.doc("users/${model.uid}").get();
      Map<String, dynamic> _readMap = _documentSnapshot.data();
      return UserResponseModel.fromJson(_readMap);
    } catch (e) {
      print("firestore service error:" + e.toString());
      return null;
    }
  }

  Future<bool> updateUserData(UserResponseModel model) async {
    try {
      await _fireStore
          .collection("users")
          .doc(model.uid)
          .update(model.toJson());
      return true;
    } catch (e) {
      print("firestore service error:" + e.toString());
      return false;
    }
  }

  Future<bool> updateUserWithMap(Map<String, dynamic> json,
      [String uid = ""]) async {
    try {
      await _fireStore
          .collection("users")
          .doc(SharedPrefs.getUid ?? uid)
          .update(json);
      return true;
    } catch (e) {
      print("firestore service error:" + e.toString());
      return false;
    }
  }
}
