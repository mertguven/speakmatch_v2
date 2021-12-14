import 'dart:typed_data';

import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/data/model/profile/request/delete_user_request_model.dart';
import 'package:speakmatch_v2/data/model/profile/request/update_email_request_model.dart';
import 'package:speakmatch_v2/data/model/profile/request/update_password_request_model.dart';
import 'package:speakmatch_v2/data/model/profile/response/delete_user_response_model.dart';
import 'package:speakmatch_v2/data/model/profile/response/signout_response_model.dart';
import 'package:speakmatch_v2/data/model/profile/response/update_email_response_model.dart';
import 'package:speakmatch_v2/data/model/profile/response/update_passowrd_response_model.dart';
import 'package:speakmatch_v2/data/repositories/profile_repo.dart';

class ProfileController {
  ProfileRepository _profileRepository = ProfileRepository();

  Future<SignOutResponseModel> signOut() async {
    try {
      return await _profileRepository.signOut();
    } catch (e) {
      print("profile controller error:" + e.toString());
      return null;
    }
  }

  Future<UserResponseModel> currentUser() async {
    try {
      return await _profileRepository.currentUser();
    } catch (e) {
      print("profile controller error:" + e.toString());
      return null;
    }
  }

  Future<bool> changeUserInformation(UserResponseModel model) async {
    try {
      return await _profileRepository.changeUserInformation(model);
    } catch (e) {
      print("profile controller error:" + e.toString());
      return null;
    }
  }

  Future<UpdateEmailResponseModel> changeEmail(
      UpdateEmailRequestModel model) async {
    try {
      return await _profileRepository.changeEmail(model);
    } catch (e) {
      print("profile controller error:" + e.toString());
      return null;
    }
  }

  Future<UpdatePasswordResponseModel> changePassword(
      UpdatePasswordRequestModel model) async {
    try {
      return await _profileRepository.changePassword(model);
    } catch (e) {
      print("profile controller error:" + e.toString());
      return null;
    }
  }

  Future<bool> changeVipStatus() async =>
      await _profileRepository.changeVipStatus();

  Future<bool> uploadPhoto(Uint8List photo) async {
    try {
      return await _profileRepository.uploadPhoto(photo);
    } catch (e) {
      print("profile controller error:" + e.toString());
      return null;
    }
  }

  Future<DeleteUserResponseModel> deleteUser(
      [DeleteUserRequestModel model]) async {
    try {
      return await _profileRepository.deleteUser(model);
    } catch (e) {
      print("profile controller error:" + e.toString());
      return null;
    }
  }
}
