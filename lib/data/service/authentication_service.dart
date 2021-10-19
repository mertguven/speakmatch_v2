import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:speakmatch_v2/controller/iauthentication.dart';
import 'package:speakmatch_v2/data/model/authentication/request/authentication_request_model.dart';
import 'package:speakmatch_v2/data/model/authentication/request/forgot_password_request_model.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_service_response_model.dart';

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
      return AuthenticationServiceResponseModel(
          success: true, user: responseCredential.user);
    } on FirebaseAuthException catch (e) {
      return AuthenticationServiceResponseModel(
          success: false, message: e.message);
    }
  }
}
