import 'package:speakmatch_v2/data/model/authentication/request/authentication_request_model.dart';
import 'package:speakmatch_v2/data/model/authentication/request/forgot_password_request_model.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_service_response_model.dart';

abstract class IAuthentication {
  Future<AuthenticationServiceResponseModel> signUp(
      AuthenticationRequestModel model);
  Future<AuthenticationServiceResponseModel> login(
      AuthenticationRequestModel model);
  Future<AuthenticationServiceResponseModel> forgotPassword(
      ForgotPasswordRequestModel model);
  Future<AuthenticationServiceResponseModel> loginWithGoogle();
}
