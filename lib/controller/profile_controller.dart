import 'package:speakmatch_v2/data/model/profile/request/delete_user_request_model.dart';
import 'package:speakmatch_v2/data/model/profile/response/delete_user_response_model.dart';
import 'package:speakmatch_v2/data/repositories/profile_repo.dart';

class ProfileController {
  ProfileRepository _profileRepository = ProfileRepository();

  Future<bool> signOut() async {
    try {
      return await _profileRepository.signOut();
    } catch (e) {
      print("profile controller error:" + e.toString());
      return false;
    }
  }

  Future<DeleteUserResponseModel> deleteUser() async {
    try {
      return await _profileRepository.deleteUser();
    } catch (e) {
      print("profile controller error:" + e.toString());
      return null;
    }
  }
}
