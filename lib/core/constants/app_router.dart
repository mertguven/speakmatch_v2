import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:speakmatch_v2/core/constants/app_constant.dart';
import 'package:speakmatch_v2/presentation/splash_view.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstant.splashRoute:
        //return GetPage(name: "/", page: () => SplashView());
        break;
      default:
    }
  }
}
