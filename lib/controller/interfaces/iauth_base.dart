import 'package:speakmatch/model/signin_signup/AuthSurrogateRequestMessage.dart';
import 'package:speakmatch/model/signin_signup/LoginResponseMessage.dart';
import 'package:speakmatch/model/signin_signup/RegisterResponseMessage.dart';

abstract class IAuthBase {
  Future<LoginResponseMessage> signIn(AuthSurrogateRequestMessage request);
  Future<RegisterResponseMessage> signUp(AuthSurrogateRequestMessage request);
}
