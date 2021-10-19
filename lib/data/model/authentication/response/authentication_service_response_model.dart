import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServiceResponseModel {
  bool success;
  String message;
  User user;

  AuthenticationServiceResponseModel({this.success, this.message, this.user});
}
