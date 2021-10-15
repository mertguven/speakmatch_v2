import 'package:speakmatch_v2/controller/iauthentication.dart';
import 'package:speakmatch_v2/data/model/authentication/request/authentication_request_model.dart';
import 'package:speakmatch_v2/data/model/authentication/request/forgot_password_request_model.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/data/model/authentication/response/forgot_password_response_model.dart';
import 'package:speakmatch_v2/data/repositories/authentication_repo.dart';

class AuthenticationController extends IAuthentication {
  AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  @override
  Future<AuthenticationResponseModel> login(
      AuthenticationRequestModel model) async {
    try {
      return await _authenticationRepository.login(model);
    } catch (e) {
      print("authentication controller error:" + e.toString());
      return null;
    }
  }

  @override
  Future<AuthenticationResponseModel> signUp(
      AuthenticationRequestModel model) async {
    try {
      return await _authenticationRepository.signUp(model);
    } catch (e) {
      print("authentication controller error:" + e.toString());
      return null;
    }
  }

  @override
  Future<ForgotPasswordResponseModel> forgotPassword(
      ForgotPasswordRequestModel model) async {
    try {
      return await _authenticationRepository.forgotPassword(model);
    } catch (e) {
      print("authentication controller error:" + e.toString());
      return null;
    }
  }

  @override
  Future<AuthenticationResponseModel> loginWithGoogle() async {
    try {
      return await _authenticationRepository.loginWithGoogle();
    } catch (e) {
      print("authentication controller error:" + e.toString());
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      return await _authenticationRepository.signOut();
    } catch (e) {
      print("authentication controller error:" + e.toString());
      return false;
    }
  }
}
