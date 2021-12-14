import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/data/repositories/home_repo.dart';

class HomeController {
  HomeRepository _homeRepository = HomeRepository();

  Future<UserResponseModel> currentUser() async {
    try {
      return await _homeRepository.currentUser();
    } catch (e) {
      print("profile controller error:" + e.toString());
      return null;
    }
  }
}
