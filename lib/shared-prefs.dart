import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _prefs;
  static initialize() async {
    if (_prefs != null) {
      return _prefs;
    } else {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  static Future<void> saveToken(String token) async {
    return _prefs.setString('token', token);
  }

  static Future<void> sharedClear() async {
    return _prefs.clear();
  }

  static Future<void> login() async {
    return _prefs.setBool('login', true);
  }

  static bool get getLogin => _prefs.getBool('login') ?? false;
  static String get getToken => _prefs.getString('token') ?? null;
}
