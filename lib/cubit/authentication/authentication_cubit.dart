import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:speakmatch_v2/controller/authentication_controller.dart';
import 'package:speakmatch_v2/data/model/authentication/request/authentication_request_model.dart';
import 'package:speakmatch_v2/data/model/authentication/request/forgot_password_request_model.dart';
import 'package:speakmatch_v2/shared-prefs.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitialState());

  AuthenticationController _authenticationController =
      AuthenticationController();

  Future<void> login(AuthenticationRequestModel requestModel) async {
    emit(AuthenticationLoadingState());
    final response = await _authenticationController.login(requestModel);
    if (response != null && response.success) {
      await SharedPrefs.login();
      await SharedPrefs.saveUid(response.user.uid);
      emit(AuthenticationLoginOrGoogleSuccessfulState());
    } else {
      emit(AuthenticationLoginOrGoogleUnsuccessfulState(
          errorMessage: response.message));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(AuthenticationLoadingState());
    final response = await _authenticationController.loginWithGoogle();
    if (response != null && response.success) {
      await SharedPrefs.login();
      await SharedPrefs.saveUid(response.user.uid);
      emit(AuthenticationLoginOrGoogleSuccessfulState());
    } else {
      emit(AuthenticationLoginOrGoogleUnsuccessfulState(
          errorMessage: response.message));
    }
  }

  Future<void> signUp(AuthenticationRequestModel requestModel) async {
    emit(AuthenticationLoadingState());
    final response = await _authenticationController.signUp(requestModel);
    if (response != null && response.success) {
      emit(AuthenticationSignupSuccessfulState());
    } else {
      emit(AuthenticationSignupUnsuccessfulState(
          errorMessage: response.message));
    }
  }

  Future<void> forgotPassword(ForgotPasswordRequestModel requestModel) async {
    emit(AuthenticationLoadingState());
    final response =
        await _authenticationController.forgotPassword(requestModel);
    if (response != null && response.success) {
      emit(SuccessForgotPasswordState());
    } else {
      emit(UnSuccessForgotPasswordState(errorMessage: response.message));
    }
  }
}
