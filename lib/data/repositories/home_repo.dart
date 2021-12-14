import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/data/service/firestore_service.dart';

class HomeRepository {
  FirestoreService _firestoreService = FirestoreService();

  Future<UserResponseModel> currentUser() async {
    try {
      final responseUser = await _firestoreService.getUserData();
      return UserResponseModel.fromJson(responseUser.data());
    } catch (e) {
      print("profile repository error: " + e.toString());
      return null;
    }
  }
}
