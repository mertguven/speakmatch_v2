import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/core/theme/app_theme.dart';
import 'package:speakmatch_v2/shared-prefs.dart';
import 'package:speakmatch_v2/view/splash_view.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.initialize();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SpeakMatch',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: SplashView(),
    );
  }
}
