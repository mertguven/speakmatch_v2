import 'package:speakmatch_v2/controller/interfaces/iauth_base.dart';
import 'package:speakmatch_v2/model/signin_signup/request/LoginRequestMessage.dart';
import 'package:speakmatch_v2/model/signin_signup/request/RegisterRequestMessage.dart';
import 'package:speakmatch_v2/model/signin_signup/response/LoginResponseMessage.dart';
import 'package:speakmatch_v2/model/signin_signup/response/RegisterResponseMessage.dart';
import 'package:speakmatch_v2/service/web_service.dart';
import 'package:speakmatch_v2/shared-prefs.dart';

class AuthController implements IAuthBase {
  WebService _webService = WebService();
  dynamic requestBody;
  @override
  Future<LoginResponseMessage> signIn(LoginRequestMessage request) async {
    requestBody = {
      "username": request.username,
      "password": request.password,
    };
    final item = await _webService.sendRequestWithPost("Login", requestBody);
    var loginResponseMessage = LoginResponseMessage.fromJson(item);
    if (loginResponseMessage.success) {
      SharedPrefs.saveToken(loginResponseMessage.token);
      SharedPrefs.login();
    }
    return loginResponseMessage;
  }

  @override
  Future<RegisterResponseMessage> signUp(RegisterRequestMessage request) async {
    requestBody = {
      "username": request.username,
      "password": request.password,
    };
    final item = await _webService.sendRequestWithPost("Register", requestBody);
    var registerResponseMessage = RegisterResponseMessage.fromJson(item);
    return registerResponseMessage;
  }
}
