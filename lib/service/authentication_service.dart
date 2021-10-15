import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:speakmatch_v2/core/utilities/custom_snackbar.dart';
import 'package:speakmatch_v2/data/model/authentication/request/authentication_request_model.dart';
import 'package:speakmatch_v2/data/model/authentication/request/forgot_password_request_model.dart';
import 'package:speakmatch_v2/shared-prefs.dart';

class AuthenticationService {
  UserCredential _userCredential;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User> signUp(AuthenticationRequestModel model) async {
    try {
      _userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: model.email, password: model.password);

      if (UserCredential != null && !_userCredential.user.emailVerified) {
        await _userCredential.user.sendEmailVerification();
      }
      return _userCredential.user;
    } on FirebaseAuthException catch (e) {
      customSnackbar(false, e.message);
      return null;
    } catch (e) {
      print("authentication service error:" + e.toString());
      return null;
    }
  }

  Future<User> login(AuthenticationRequestModel model) async {
    try {
      //burayı repoya taşu
      _userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: model.email, password: model.password);
      if (UserCredential != null && !_userCredential.user.emailVerified) {
        customSnackbar(false,
            "Your email has not been confirmed. Please confirm your email to login.");
        return null;
      } else {
        await SharedPrefs.login();
        return _userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      customSnackbar(false, e.message);
      return null;
    } catch (e) {
      print("authentication service error:" + e.toString());
      return null;
    }
  }

  User currentUser() {
    try {
      return _firebaseAuth.currentUser;
    } catch (e) {
      print("authentication service error:" + e.toString());
      return null;
    }
  }

  Future<bool> forgotPassword(ForgotPasswordRequestModel model) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: model.email);
      return true;
    } on FirebaseAuthException catch (e) {
      customSnackbar(false, e.message);
      return false;
    } catch (e) {
      print("authentication service error:" + e.toString());
      return false;
    }
  }

  Future<User> loginWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final responseCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      await SharedPrefs.login();
      return responseCredential.user;
    } on FirebaseAuthException catch (e) {
      customSnackbar(false, e.message);
      return null;
    } catch (e) {
      print("authentication service error:" + e.toString());
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      await SharedPrefs.sharedClear();
      if (_googleSignIn.currentUser != null) {
        await _googleSignIn.disconnect();
      }
      if (_firebaseAuth.currentUser != null) {
        await _googleSignIn.signOut();
        await _firebaseAuth.signOut();
      }
      return true;
    } catch (e) {
      print("authentication service error:" + e.toString());
      return false;
    }
  }
}
