import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speakmatch_v2/controller/iauthentication.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_service_response_model.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/data/model/authentication/request/forgot_password_request_model.dart';
import 'package:speakmatch_v2/data/model/authentication/request/authentication_request_model.dart';
import 'package:speakmatch_v2/data/service/authentication_service.dart';
import 'package:speakmatch_v2/data/service/firestore_service.dart';

class AuthenticationRepository extends IAuthentication {
  AuthenticationService _authenticationService = AuthenticationService();
  FirestoreService _firestoreService = FirestoreService();

  @override
  Future<AuthenticationServiceResponseModel> signUp(
      AuthenticationRequestModel model) async {
    try {
      final serviceResponse = await _authenticationService.signUp(model);
      if (serviceResponse.success) {
        await serviceResponse.user.updateDisplayName(model.name);
        await _firestoreService.saveUser(UserResponseModel(
            imageUrl: serviceResponse.user.photoURL,
            gender: null,
            creationTime: serviceResponse.user.metadata.creationTime,
            lastSignInTime: serviceResponse.user.metadata.lastSignInTime,
            displayName: model.name,
            email: serviceResponse.user.email,
            emailVerified: serviceResponse.user.emailVerified,
            uid: serviceResponse.user.uid));
      }
      return serviceResponse;
    } catch (e) {
      print("authentication repo error:" + e.toString());
      return null;
    }
  }

  @override
  Future<AuthenticationServiceResponseModel> login(
      AuthenticationRequestModel model) async {
    try {
      final serviceResponse = await _authenticationService.login(model);
      if (serviceResponse.success) {
        if (!serviceResponse.user.emailVerified) {
          //await serviceResponse.user.sendEmailVerification();
          return AuthenticationServiceResponseModel(
              success: false,
              message:
                  "Your email has not been confirmed. Please confirm your email to login.");
        } else {
          await _firestoreService.updateUserWithMap({
            'lastSignInTime': Timestamp.fromDate(DateTime.now()),
            'emailVerified': true,
            'email': serviceResponse.user.email
          }, serviceResponse.user.uid);
          return serviceResponse;
        }
      } else {
        return serviceResponse;
      }
    } catch (e) {
      print("authentication repo error:" + e.toString());
      return null;
    }
  }

  @override
  Future<AuthenticationServiceResponseModel> forgotPassword(
      ForgotPasswordRequestModel model) async {
    try {
      return await _authenticationService.forgotPassword(model);
    } catch (e) {
      print("authentication repo error:" + e.toString());
      return null;
    }
  }

  @override
  Future<AuthenticationServiceResponseModel> loginWithGoogle() async {
    try {
      var serviceResponse = await _authenticationService.loginWithGoogle();
      if (serviceResponse.success) {
        final model = UserResponseModel(
            imageUrl: serviceResponse.user.photoURL,
            gender: null,
            creationTime: serviceResponse.user.metadata.creationTime,
            lastSignInTime: serviceResponse.user.metadata.lastSignInTime,
            displayName: serviceResponse.user.displayName,
            email: serviceResponse.user.email,
            emailVerified: serviceResponse.user.emailVerified,
            uid: serviceResponse.user.uid);
        await _firestoreService.saveUser(model);
        await _firestoreService.updateUserWithMap({
          'lastSignInTime': Timestamp.fromDate(DateTime.now()),
          'emailVerified': true,
          'email': serviceResponse.user.email
        }, serviceResponse.user.uid);
      }
      return serviceResponse;
    } catch (e) {
      print("authentication repo error:" + e.toString());
      return null;
    }
  }
}
