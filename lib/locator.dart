import 'package:get_it/get_it.dart';
import 'package:speakmatch_v2/controller/signin-signup/auth_controller.dart';
import 'package:speakmatch_v2/service/web_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => WebService());
  locator.registerLazySingleton(() => AuthController());
}
