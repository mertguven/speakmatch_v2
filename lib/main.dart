import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/core/theme/app_theme.dart';
import 'package:speakmatch_v2/shared-prefs.dart';
import 'package:speakmatch_v2/view/splash_view.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
