import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:speakmatch_v2/controller/iauthentication.dart';
import 'package:speakmatch_v2/data/model/authentication/request/authentication_request_model.dart';
import 'package:speakmatch_v2/data/model/authentication/request/forgot_password_request_model.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_service_response_model.dart';
import 'package:speakmatch_v2/data/model/profile/request/delete_user_request_model.dart';
import 'package:speakmatch_v2/data/model/profile/request/update_email_request_model.dart';
import 'package:speakmatch_v2/data/model/profile/request/update_password_request_model.dart';
import 'package:speakmatch_v2/data/model/profile/response/delete_user_response_model.dart';
import 'package:speakmatch_v2/data/model/profile/response/signout_response_model.dart';
import 'package:speakmatch_v2/data/model/profile/response/update_email_response_model.dart';
import 'package:speakmatch_v2/data/model/profile/response/update_passowrd_response_model.dart';
import 'package:speakmatch_v2/shared-prefs.dart';

class AuthenticationService extends IAuthentication {
  UserCredential _userCredential;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<AuthenticationServiceResponseModel> signUp(
      AuthenticationRequestModel model) async {
    try {
      _userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: model.email, password: model.password);
      if (UserCredential != null && !_userCredential.user.emailVerified) {
        await _userCredential.user.sendEmailVerification();
      }
      return AuthenticationServiceResponseModel(
          success: true, user: _userCredential.user);
    } on FirebaseAuthException catch (e) {
      return AuthenticationServiceResponseModel(
          success: false, message: e.message);
    }
  }

  Future<AuthenticationServiceResponseModel> login(
      AuthenticationRequestModel model) async {
    try {
      _userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: model.email, password: model.password);
      return AuthenticationServiceResponseModel(
          success: true, user: _userCredential.user);
    } on FirebaseAuthException catch (e) {
      return AuthenticationServiceResponseModel(
          success: false, message: e.message);
    }
  }

  Future<AuthenticationServiceResponseModel> forgotPassword(
      ForgotPasswordRequestModel model) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: model.email);
      return AuthenticationServiceResponseModel(success: true);
    } on FirebaseAuthException catch (e) {
      return AuthenticationServiceResponseModel(
          success: false, message: e.message);
    }
  }

  Future<AuthenticationServiceResponseModel> loginWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      final responseCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      SharedPrefs.saveIdToken(googleAuth.idToken);
      SharedPrefs.saveAccessToken(googleAuth.accessToken);
      return AuthenticationServiceResponseModel(
          success: true, user: responseCredential.user);
    } on FirebaseAuthException catch (e) {
      return AuthenticationServiceResponseModel(
          success: false, message: e.message);
    }
  }

  Future<UpdatePasswordResponseModel> changePassword(
      UpdatePasswordRequestModel model) async {
    try {
      await _firebaseAuth.currentUser.reauthenticateWithCredential(
          EmailAuthProvider.credential(
              email: _firebaseAuth.currentUser.email,
              password: model.oldPassword));

      await _firebaseAuth.currentUser.updatePassword(model.newPassword);
      return UpdatePasswordResponseModel(success: true);
    } on FirebaseAuthException catch (e) {
      return UpdatePasswordResponseModel(success: false, message: e.message);
    }
  }

  Future<UpdateEmailResponseModel> changeEmail(
      UpdateEmailRequestModel model) async {
    try {
      await _firebaseAuth.currentUser.reauthenticateWithCredential(
          EmailAuthProvider.credential(
              email: _firebaseAuth.currentUser.email,
              password: model.password));

      await _firebaseAuth.currentUser.updateEmail(model.email);
      return UpdateEmailResponseModel(success: true);
    } on FirebaseAuthException catch (e) {
      return UpdateEmailResponseModel(success: false, message: e.message);
    }
  }

  Future<DeleteUserResponseModel> deleteUser(
      [DeleteUserRequestModel model]) async {
    try {
      if (model != null) {
        await _firebaseAuth.currentUser.reauthenticateWithCredential(
            EmailAuthProvider.credential(
                email: _firebaseAuth.currentUser.email,
                password: model.password));
      } else {
        await _firebaseAuth.currentUser.reauthenticateWithCredential(
            GoogleAuthProvider.credential(
                idToken: SharedPrefs.getidToken,
                accessToken: SharedPrefs.getAccessToken));
      }
      await _firebaseAuth.currentUser.delete();
      return DeleteUserResponseModel(success: true);
    } on FirebaseAuthException catch (e) {
      return DeleteUserResponseModel(success: false, message: e.message);
    }
  }

  Future<SignOutResponseModel> signOut() async {
    try {
      if (_firebaseAuth.currentUser != null) {
        await _googleSignIn.signOut();
        await _firebaseAuth.signOut();
      }
      return SignOutResponseModel(success: true);
    } on FirebaseAuthException catch (e) {
      print("profile service error:" + e.toString());
      return SignOutResponseModel(success: false, message: e.message);
    }
  }
}
