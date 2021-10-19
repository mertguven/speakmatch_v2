import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/data/model/profile/response/delete_user_response_model.dart';
import 'package:speakmatch_v2/data/service/firestore_service.dart';
import 'package:speakmatch_v2/data/service/profile_service.dart';

class ProfileRepository {
  ProfileService _profileService = ProfileService();
  FirestoreService _firestoreService = FirestoreService();

  Future<bool> signOut() async {
    try {
      return await _profileService.signOut();
    } catch (e) {
      print("profile repo error:" + e.toString());
      return false;
    }
  }

  Future<AuthenticationResponseModel> currentUser() async {
    try {
      final responseUser = await _firestoreService.getUserData();
      final model = AuthenticationResponseModel.fromJson(responseUser.data());
      return model;
    } catch (e) {
      print("profile repository error: " + e.toString());
      return null;
    }
  }

  Future<DeleteUserResponseModel> deleteUser() async {
    try {
      FirebaseAuth.instance.currentUser.reload();
      final deleteAuthentication = await _profileService.deleteUser();

      final deleteFirestore = await _firestoreService.deleteUser();
      if (deleteAuthentication.success && deleteFirestore.success) {
        return DeleteUserResponseModel(success: true);
      } else {
        return DeleteUserResponseModel(
            success: false, message: deleteAuthentication.message);
      }
    } catch (e) {
      print("profile repository error: " + e.toString());
      return null;
    }
  }
}
