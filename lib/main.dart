import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:speakmatch_v2/controller/home/home_controller.dart';
import 'package:speakmatch_v2/controller/profile/profile_controller.dart';
import 'package:speakmatch_v2/controller/signin-signup/auth_controller.dart';
import 'package:speakmatch_v2/service/web_service.dart';
import 'package:speakmatch_v2/shared-prefs.dart';
import 'package:speakmatch_v2/view/splash/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WebService>(create: (_) => WebService()),
        Provider<AuthController>(create: (_) => AuthController()),
        Provider<ProfileController>(create: (_) => ProfileController()),
        Provider<HomeController>(create: (_) => HomeController()),
      ],
      child: GetMaterialApp(
        title: 'SpeakMatch',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.white,
          brightness: Brightness.light,
          accentColor: Color(0xff1F2A5D),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
