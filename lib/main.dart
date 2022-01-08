import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:speakmatch_v2/core/constants/app_constant.dart';
import 'package:speakmatch_v2/core/theme/app_theme.dart';
import 'package:speakmatch_v2/cubit/authentication/authentication_cubit.dart';
import 'package:speakmatch_v2/cubit/home/call/call_cubit.dart';
import 'package:speakmatch_v2/cubit/home/home_cubit.dart';
import 'package:speakmatch_v2/cubit/profile/profile_cubit.dart';
import 'package:speakmatch_v2/cubit/sample_bloc_observer.dart';
import 'package:speakmatch_v2/data/service/push_notification_service.dart';
import 'package:speakmatch_v2/shared-prefs.dart';
import 'package:speakmatch_v2/presentation/splash_view.dart';
import 'package:speakmatch_v2/translations/languages.dart';
import 'core/theme/app_theme.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

import 'cubit/home/notification/notification_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SampleBlocObserver();
  MobileAds.instance.initialize();
  await SharedPrefs.initialize();
  await Firebase.initializeApp();
  await PushNotificationService().init();
  if (defaultTargetPlatform == TargetPlatform.android) {
    // ignore: deprecated_member_use
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(create: (_) => AuthenticationCubit()),
        BlocProvider<ProfileCubit>(create: (_) => ProfileCubit()),
        BlocProvider<CallCubit>(create: (_) => CallCubit()),
        BlocProvider<NotificationCubit>(create: (_) => NotificationCubit()),
        BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
      ],
      child: GetMaterialApp(
        translations: Languages(),
        locale: Locale(SharedPrefs.getLocale),
        fallbackLocale: AppConstant.supportedLocales.first,
        title: AppConstant.appName,
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: SplashView(),
      ),
    );
  }
}
