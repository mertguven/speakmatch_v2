import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/core/theme/app_theme.dart';
import 'package:speakmatch_v2/core/utilities/loading_dialog.dart';
import 'package:speakmatch_v2/cubit/authentication/authentication_cubit.dart';
import 'package:speakmatch_v2/cubit/profile/profile_cubit.dart';
import 'package:speakmatch_v2/cubit/sample_bloc_observer.dart';
import 'package:speakmatch_v2/shared-prefs.dart';
import 'package:speakmatch_v2/presentation/splash_view.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SampleBlocObserver();
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
  void initState() {
    loadingDialogInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(create: (_) => AuthenticationCubit()),
        BlocProvider<ProfileCubit>(create: (_) => ProfileCubit()),
      ],
      child: GetMaterialApp(
        title: 'SpeakMatch',
        //onGenerateRoute: AppRouter.onGenerateRoute,
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: SplashView(),
      ),
    );
  }
}
