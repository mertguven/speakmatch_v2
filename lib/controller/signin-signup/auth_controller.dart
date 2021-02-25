import 'package:speakmatch/controller/interfaces/iauth_base.dart';
import 'package:speakmatch/locator.dart';
import 'package:speakmatch/model/signin_signup/AuthSurrogateRequestMessage.dart';
import 'package:speakmatch/model/signin_signup/LoginResponseMessage.dart';
import 'package:speakmatch/model/signin_signup/RegisterResponseMessage.dart';
import 'package:speakmatch/service/web_service.dart';
import 'package:speakmatch/shared-prefs.dart';

class AuthController implements IAuthBase {
  WebService authController = locator<WebService>();
  dynamic requestBody;
  @override
  Future<LoginResponseMessage> signIn(
      AuthSurrogateRequestMessage request) async {
    requestBody = {
      "username": request.username,
      "password": request.password,
    };
    final item = await authController.sendRequestWithPost("Login", requestBody);
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
    final item =
        await authController.sendRequestWithPost("Register", requestBody);
    var registerResponseMessage = RegisterResponseMessage.fromJson(item);
    return registerResponseMessage;
  }
}
