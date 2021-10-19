import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:speakmatch_v2/controller/profile_controller.dart';
import 'package:speakmatch_v2/core/utilities/custom_snackbar.dart';
import 'package:speakmatch_v2/data/model/profile/request/delete_user_request_model.dart';
import 'package:speakmatch_v2/shared-prefs.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  ProfileController _profileController = ProfileController();

  Future<void> signOut() async {
    emit(ProfileLoadingState());
    final response = await _profileController.signOut();
    if (response) {
      await SharedPrefs.sharedClear();
      emit(SuccessSignOutState());
    } else {
      emit(UnSuccessSignOutState());
    }
  }

  Future<void> deleteUser() async {
    emit(ProfileLoadingState());
    final response = await _profileController.deleteUser();
    if (response.success) {
      await SharedPrefs.sharedClear();
      await signOut();
    } else {
      emit(ProfileInitialState());
      customSnackbar(false, response.message);
    }
  }
}
