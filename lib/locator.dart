import 'package:get_it/get_it.dart';
import 'package:speakmatch/controller/signin-signup/auth_controller.dart';
import 'package:speakmatch/service/web_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => WebService());
  locator.registerLazySingleton(() => AuthController());
}
