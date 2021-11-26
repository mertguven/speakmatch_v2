import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:speakmatch_v2/controller/profile_controller.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/data/model/profile/request/delete_user_request_model.dart';
import 'package:speakmatch_v2/data/model/profile/request/update_email_request_model.dart';
import 'package:speakmatch_v2/data/model/profile/request/update_password_request_model.dart';
import 'package:speakmatch_v2/shared-prefs.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  ProfileController _profileController = ProfileController();

  Future<UserResponseModel> getUser() async {
    emit(ProfileLoadingState());
    final response = await _profileController.currentUser();
    if (response != null) {
      emit(ProfileLoadedState(model: response));
      return response;
    } else {
      emit(ProfileErrorState());
      return null;
    }
  }

  Future<void> changeUserInformation(UserResponseModel model) async {
    emit(ProfileLoadingState());
    final response = await _profileController.changeUserInformation(model);
    if (response) {
      emit(SuccessChangePersonalInformationState());
      //emit(ProfileLoadedState(model: await getUser()));
    } else {
      emit(ProfileErrorState());
    }
  }

  Future<void> changeEmail(UpdateEmailRequestModel model) async {
    emit(ProfileLoadingState());
    final response = await _profileController.changeEmail(model);
    if (response.success) {
      await signOut();
    } else {
      emit(ProfileErrorState(errorMessage: response.message));
    }
  }

  Future<void> changePassword(UpdatePasswordRequestModel model) async {
    emit(ProfileLoadingState());
    final response = await _profileController.changePassword(model);
    if (response.success) {
      await signOut();
    } else {
      emit(ProfileErrorState(errorMessage: response.message));
    }
  }

  Future<void> uploadPhoto(Uint8List photo) async {
    emit(ProfileLoadingState());
    final response = await _profileController.uploadPhoto(photo);
    if (response) {
      emit(ProfileLoadedState(model: await getUser()));
    } else {
      emit(ProfileErrorState());
    }
  }

  Future<void> signOut() async {
    emit(ProfileLoadingState());
    final response = await _profileController.signOut();
    if (response.success) {
      await SharedPrefs.sharedClear();
      emit(SuccessSignOutState());
    } else {
      emit(ProfileErrorState(errorMessage: response.message));
    }
  }

  Future<void> deleteUser([DeleteUserRequestModel model]) async {
    emit(ProfileLoadingState());
    final response = await _profileController.deleteUser(model);
    if (response.success) {
      await signOut();
    } else {
      emit(ProfileErrorState(errorMessage: response.message));
    }
  }
}
