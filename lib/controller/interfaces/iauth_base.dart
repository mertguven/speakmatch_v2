import 'package:speakmatch_v2/model/signin_signup/request/LoginRequestMessage.dart';
import 'package:speakmatch_v2/model/signin_signup/request/RegisterRequestMessage.dart';
import 'package:speakmatch_v2/model/signin_signup/response/LoginResponseMessage.dart';
import 'package:speakmatch_v2/model/signin_signup/response/RegisterResponseMessage.dart';

abstract class IAuthBase {
  Future<LoginResponseMessage> signIn(LoginRequestMessage request);
  Future<RegisterResponseMessage> signUp(RegisterRequestMessage request);
}
