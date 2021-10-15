import 'package:firebase_auth/firebase_auth.dart';
import 'package:speakmatch_v2/controller/iauthentication.dart';
import 'package:speakmatch_v2/data/model/authentication/response/forgot_password_response_model.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/data/model/authentication/request/forgot_password_request_model.dart';
import 'package:speakmatch_v2/data/model/authentication/request/authentication_request_model.dart';
import 'package:speakmatch_v2/service/authentication_service.dart';
import 'package:speakmatch_v2/service/firestore_service.dart';

class AuthenticationRepository extends IAuthentication {
  AuthenticationService _authenticationService = AuthenticationService();
  FirestoreService _firestoreService = FirestoreService();

  @override
  Future<AuthenticationResponseModel> signUp(
      AuthenticationRequestModel model) async {
    try {
      User user = await _authenticationService.signUp(model);
      await user.updateDisplayName(model.name);
      AuthenticationResponseModel responseModel = AuthenticationResponseModel(
          creationTime: user.metadata.creationTime,
          lastSignInTime: user.metadata.lastSignInTime,
          displayName: model.name,
          email: user.email,
          emailVerified: user.emailVerified,
          uid: user.uid);
      bool responseFirestoreService =
          await _firestoreService.saveUser(responseModel);
      if (responseFirestoreService) {
        return responseModel;
      } else {
        return null;
      }
    } catch (e) {
      print("authentication repo error:" + e.toString());
      return null;
    }
  }

  @override
  Future<AuthenticationResponseModel> login(
      AuthenticationRequestModel model) async {
    try {
      User user = await _authenticationService.login(model);
      AuthenticationResponseModel responseModel = AuthenticationResponseModel(
          creationTime: user.metadata.creationTime,
          lastSignInTime: user.metadata.lastSignInTime,
          displayName: user.displayName,
          email: user.email,
          emailVerified: user.emailVerified,
          uid: user.uid);
      bool response = await _firestoreService.updateUserData(responseModel);
      if (response) {
        return responseModel;
      } else {
        return null;
      }
    } catch (e) {
      print("authentication repo error:" + e.toString());
      return null;
    }
  }

  @override
  Future<ForgotPasswordResponseModel> forgotPassword(
      ForgotPasswordRequestModel model) async {
    try {
      bool response = await _authenticationService.forgotPassword(model);
      return ForgotPasswordResponseModel(success: response);
    } catch (e) {
      print("authentication repo error:" + e.toString());
      return null;
    }
  }

  @override
  Future<AuthenticationResponseModel> loginWithGoogle() async {
    try {
      var user = await _authenticationService.loginWithGoogle();
      if (user != null) {
        AuthenticationResponseModel responseModel = AuthenticationResponseModel(
            creationTime: user.metadata.creationTime,
            lastSignInTime: user.metadata.lastSignInTime,
            displayName: user.displayName,
            email: user.email,
            emailVerified: user.emailVerified,
            uid: user.uid);
        bool response = await _firestoreService.saveUser(responseModel);
        await _firestoreService.updateUserData(responseModel);
        if (response) {
          return responseModel;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("authentication repo error:" + e.toString());
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      return await _authenticationService.signOut();
    } catch (e) {
      print("authentication repo error:" + e.toString());
      return false;
    }
  }
}
