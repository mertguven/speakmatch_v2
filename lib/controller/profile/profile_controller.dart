import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:speakmatch_v2/controller/interfaces/iprofile_base.dart';
import 'package:speakmatch_v2/model/profile/request/ChangeUserInformationRequestMessage.dart';
import 'package:speakmatch_v2/model/profile/response/ChangePasswordResponseMessage.dart';
import 'package:speakmatch_v2/model/profile/request/ChangePasswordRequestMessage.dart';
import 'package:speakmatch_v2/model/profile/response/ChangeUserInformationResponseMessage.dart';
import 'package:speakmatch_v2/model/profile/response/GetUserInformationResponseMessage.dart';
import 'package:speakmatch_v2/model/profile/response/UploadImageResponseMessage.dart';
import 'package:speakmatch_v2/service/web_service.dart';
import 'package:speakmatch_v2/shared-prefs.dart';

class ProfileController with ChangeNotifier implements IProfileBase {
  WebService _webService = WebService();
  dynamic _requestBody;
  String changePhotoUrl;
  @override
  Future<GetUserInformationResponseMessage> getUserInformation() async {
    final item = await _webService.sendRequestWithGet("GetUserByToken");
    var getUserInformationResponseMessage =
        GetUserInformationResponseMessage.fromJson(item);
    notifyListeners();
    return getUserInformationResponseMessage;
  }

  @override
  Future<UploadImageResponseMessage> changeProfilePhoto(File file) async {
    Dio dio = new Dio();
    String fileName = file.path.split('/').last;
    dio.options = BaseOptions(
        baseUrl: "http://45.55.44.174/SM/",
        method: "POST",
        headers: {'Authorization': 'Bearer ' + SharedPrefs.getToken});

    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    var response = await dio.post("UploadImage", data: data);
    var uploadImageResponseMessage =
        UploadImageResponseMessage.fromJson(response.data);
    changePhotoUrl = uploadImageResponseMessage.url;
    notifyListeners();
    return uploadImageResponseMessage;
  }

  @override
  Future<ChangePasswordResponseMessage> changePassword(
      ChangePasswordRequestMessage request) async {
    _requestBody = {
      "password": request.password,
    };
    final item = await _webService.sendRequestWithPostAndToken(
        "ChangePassword", _requestBody);
    var changePasswordResponseMessage =
        ChangePasswordResponseMessage.fromJson(item);
    return changePasswordResponseMessage;
  }

  @override
  Future<ChangeUserInformationResponseMessage> changeUserInformation(
      ChangeUserInformationRequestMessage request) async {
    _requestBody = {
      "username": request.username,
      "sex": request.sex,
      "age": request.age,
      "email": request.email
    };
    final item = await _webService.sendRequestWithPostAndToken(
        "ChangeUserInformation", _requestBody);
    var changeUserInformationResponseMessage =
        ChangeUserInformationResponseMessage.fromJson(item);
    return changeUserInformationResponseMessage;
  }
}
