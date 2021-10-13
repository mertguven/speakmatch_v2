import 'package:firebase_auth/firebase_auth.dart';
import 'package:speakmatch_v2/controller/iauthentication.dart';
import 'package:speakmatch_v2/model/authentication/request/authentication_request_model.dart';
import 'package:speakmatch_v2/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/model/authentication/request/forgot_password_request_model.dart';
import 'package:speakmatch_v2/model/authentication/response/forgot_password_response_model.dart';
import 'package:speakmatch_v2/service/authentication/authentication_service.dart';

class AuthenticationController extends IAuthentication {
  AuthenticationService _service = AuthenticationService();
  @override
  Future<AuthenticationResponseModel> login(
      AuthenticationRequestModel model) async {
    User user = await _service.login(model);
    if (user != null) {
      return AuthenticationResponseModel(
          creationTime: user.metadata.creationTime,
          lastSignInTime: user.metadata.lastSignInTime,
          displayName: user.displayName,
          email: user.email,
          emailVerified: user.emailVerified,
          uid: user.uid);
    } else {
      return null;
    }
  }

  @override
  Future<AuthenticationResponseModel> signUp(
      AuthenticationRequestModel model) async {
    User user = await _service.signUp(model);
    if (user != null) {
      return AuthenticationResponseModel(
          creationTime: user.metadata.creationTime,
          lastSignInTime: user.metadata.lastSignInTime,
          displayName: user.displayName,
          email: user.email,
          emailVerified: user.emailVerified,
          uid: user.uid);
    } else {
      return null;
    }
  }

  @override
  Future<ForgotPasswordResponseModel> forgotPassword(
      ForgotPasswordRequestModel model) async {
    bool response = await _service.forgotPassword(model);
    return ForgotPasswordResponseModel(success: response);
  }

  @override
  Future<AuthenticationResponseModel> loginWithGoogle() async {
    var response = await _service.loginWithGoogle();
    if (response != null) {
      return AuthenticationResponseModel(
          creationTime: response.metadata.creationTime,
          lastSignInTime: response.metadata.lastSignInTime,
          displayName: response.displayName,
          email: response.email,
          emailVerified: response.emailVerified,
          uid: response.uid);
    } else {
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    return await _service.signOut();
  }
}
