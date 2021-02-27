import 'package:speakmatch_v2/controller/interfaces/iauth_base.dart';
import 'package:speakmatch_v2/locator.dart';
import 'package:speakmatch_v2/model/signin_signup/AuthSurrogateRequestMessage.dart';
import 'package:speakmatch_v2/model/signin_signup/LoginResponseMessage.dart';
import 'package:speakmatch_v2/model/signin_signup/RegisterResponseMessage.dart';
import 'package:speakmatch_v2/service/web_service.dart';
import 'package:speakmatch_v2/shared-prefs.dart';

class AuthController implements IAuthBase {
  WebService _webService = locator<WebService>();
  dynamic requestBody;
  @override
  Future<LoginResponseMessage> signIn(
      AuthSurrogateRequestMessage request) async {
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
  Future<RegisterResponseMessage> signUp(
      AuthSurrogateRequestMessage request) async {
    requestBody = {
      "username": request.username,
      "password": request.password,
    };
    final item = await _webService.sendRequestWithPost("Register", requestBody);
    var registerResponseMessage = RegisterResponseMessage.fromJson(item);
    return registerResponseMessage;
  }
}
