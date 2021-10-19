import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:speakmatch_v2/data/model/profile/response/delete_user_response_model.dart';

class ProfileService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  /*User currentUser() {
    try {
      return _firebaseAuth.currentUser;
    } catch (e) {
      print("profile service error:" + e.toString());
      return null;
    }
  }*/

  Future<DeleteUserResponseModel> deleteUser() async {
    try {
      await _firebaseAuth.currentUser.delete();
      return DeleteUserResponseModel(success: true);
    } on FirebaseAuthException catch (e) {
      return DeleteUserResponseModel(success: false, message: e.message);
    }
  }

  Future<bool> signOut() async {
    try {
      if (_googleSignIn.currentUser != null) {
        await _googleSignIn.disconnect();
      }
      if (_firebaseAuth.currentUser != null) {
        await _googleSignIn.signOut();
        await _firebaseAuth.signOut();
      }
      return true;
    } catch (e) {
      print("profile service error:" + e.toString());
      return false;
    }
  }
}
