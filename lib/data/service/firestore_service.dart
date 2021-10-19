import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/data/model/profile/response/delete_user_response_model.dart';
import 'package:speakmatch_v2/shared-prefs.dart';

class FirestoreService {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _fireStore.collection("users").doc(SharedPrefs.getUid).get();
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

  Future<bool> saveUser(AuthenticationResponseModel model) async {
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

  Future<AuthenticationResponseModel> readUser(
      AuthenticationResponseModel model) async {
    try {
      DocumentSnapshot _documentSnapshot =
          await _fireStore.doc("users/${model.uid}").get();
      Map<String, dynamic> _readMap = _documentSnapshot.data();
      return AuthenticationResponseModel.fromJson(_readMap);
    } catch (e) {
      print("firestore service error:" + e.toString());
      return null;
    }
  }

  Future<bool> updateUserData(AuthenticationResponseModel model) async {
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
}
