import 'package:speakmatch_v2/data/model/authentication/request/authentication_request_model.dart';
import 'package:speakmatch_v2/data/model/authentication/request/forgot_password_request_model.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/data/model/authentication/response/forgot_password_response_model.dart';

abstract class IAuthentication {
  Future<AuthenticationResponseModel> signUp(AuthenticationRequestModel model);
  Future<AuthenticationResponseModel> login(AuthenticationRequestModel model);
  Future<ForgotPasswordResponseModel> forgotPassword(
      ForgotPasswordRequestModel model);
  Future<AuthenticationResponseModel> loginWithGoogle();
  Future<bool> signOut();
}
