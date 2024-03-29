import 'dart:typed_data';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/data/model/profile/request/delete_user_request_model.dart';
import 'package:speakmatch_v2/data/model/profile/request/update_email_request_model.dart';
import 'package:speakmatch_v2/data/model/profile/request/update_password_request_model.dart';
import 'package:speakmatch_v2/data/model/profile/response/delete_user_response_model.dart';
import 'package:speakmatch_v2/data/model/profile/response/signout_response_model.dart';
import 'package:speakmatch_v2/data/model/profile/response/update_email_response_model.dart';
import 'package:speakmatch_v2/data/model/profile/response/update_passowrd_response_model.dart';
import 'package:speakmatch_v2/data/service/authentication_service.dart';
import 'package:speakmatch_v2/data/service/firebase_storage_service.dart';
import 'package:speakmatch_v2/data/service/firestore_service.dart';

class ProfileRepository {
  FirestoreService _firestoreService = FirestoreService();
  AuthenticationService _authenticationService = AuthenticationService();
  FirebaseStorageService _firebaseStorageService = FirebaseStorageService();

  Future<SignOutResponseModel> signOut() async {
    try {
      return await _authenticationService.signOut();
    } catch (e) {
      print("profile repo error:" + e.toString());
      return null;
    }
  }

  Future<UpdatePasswordResponseModel> changePassword(
      UpdatePasswordRequestModel model) async {
    try {
      return _authenticationService.changePassword(model);
    } catch (e) {
      print("profile repository error: " + e.toString());
      return null;
    }
  }

  Future<bool> changeVipStatus() async =>
      await _firestoreService.updateUserWithMap({'isVip': true});

  Future<UpdateEmailResponseModel> changeEmail(
      UpdateEmailRequestModel model) async {
    try {
      await _firestoreService.updateUserWithMap({'email': '${model.email}'});
      return _authenticationService.changeEmail(model);
    } catch (e) {
      print("profile repository error: " + e.toString());
      return null;
    }
  }

  Future<UserResponseModel> currentUser() async {
    try {
      final responseUser = await _firestoreService.getUserData();
      final model = UserResponseModel.fromJson(responseUser.data());
      return model;
    } catch (e) {
      print("profile repository error: " + e.toString());
      return null;
    }
  }

  Future<bool> changeUserInformation(UserResponseModel model) async {
    try {
      return await _firestoreService.updateUserData(model);
    } catch (e) {
      print("profile repository error: " + e.toString());
      return null;
    }
  }

  Future<bool> uploadPhoto(Uint8List photo) async {
    try {
      final response = await _firebaseStorageService.uploadImage(photo);
      if (response != null) {
        return await _firestoreService
            .updateUserWithMap({'imageUrl': '$response'});
      }
      return false;
    } catch (e) {
      print("profile repository error: " + e.toString());
      return null;
    }
  }

  Future<DeleteUserResponseModel> deleteUser(
      [DeleteUserRequestModel model]) async {
    try {
      await _firestoreService.deleteUser();
      final deleteAuthentication =
          await _authenticationService.deleteUser(model);

      return deleteAuthentication;
    } catch (e) {
      print("profile repository error: " + e.toString());
      return null;
    }
  }
}
