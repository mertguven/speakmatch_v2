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

  static Future<void> saveUid(String uid) async {
    return _prefs.setString('uid', uid);
  }

  static Future<void> saveVisibilityOfProfile(bool visibility) async {
    return _prefs.setBool("visibilityOfProfile", visibility);
  }

  static Future<void> sharedClear() async {
    return _prefs.clear();
  }

  static Future<void> login() async {
    return _prefs.setBool('login', true);
  }

  static bool get getLogin => _prefs.getBool('login') ?? false;
  static bool get getVisibilityOfProfile =>
      _prefs.getBool('visibilityOfProfile') ?? true;
  static String get getUid => _prefs.getString('uid') ?? null;
}
