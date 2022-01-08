import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  static Future<bool> saveLocale(Locale locale) =>
      _prefs.setString("locale", locale.languageCode);
  static String get getLocale =>
      _prefs.getString("locale") ?? Get.deviceLocale.languageCode;

  static Future<void> saveUid(String uid) async => _prefs.setString('uid', uid);

  static Future<void> saveIdToken(String idToken) async =>
      _prefs.setString('idToken', idToken);

  static Future<void> saveAccessToken(String accessToken) async =>
      _prefs.setString('accessToken', accessToken);

  static Future<void> saveVisibilityOfProfile(bool visibility) async =>
      _prefs.setBool("visibilityOfProfile", visibility);

  static Future<void> sharedClear() async => _prefs.clear();

  static Future<void> login() async => _prefs.setBool('login', true);

  static bool get getLogin => _prefs.getBool('login') ?? false;

  static Future<void> changeAdStatus() async =>
      _prefs.setBool("adStatus", !getAdStatus);
  static bool get getAdStatus => _prefs.getBool("adStatus") ?? true;

  static Future<void> changeProfileDisplayStatus() async =>
      _prefs.setBool("profileDisplayStatus", !getProfileDisplayStatus);
  static bool get getProfileDisplayStatus =>
      _prefs.getBool("profileDisplayStatus") ?? true;

  static bool get getVisibilityOfProfile =>
      _prefs.getBool('visibilityOfProfile') ?? true;
  static String get getUid => _prefs.getString('uid') ?? null;
  static String get getidToken => _prefs.getString('idToken') ?? null;
  static String get getAccessToken => _prefs.getString('accessToken') ?? null;
}
