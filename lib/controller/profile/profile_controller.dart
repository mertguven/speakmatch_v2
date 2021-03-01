import 'dart:io';
import 'package:dio/dio.dart';
import 'package:speakmatch_v2/controller/interfaces/iprofile_base.dart';
import 'package:speakmatch_v2/locator.dart';
import 'package:speakmatch_v2/model/profile/request/ChangeUserInformationRequestMessage.dart';
import 'package:speakmatch_v2/model/profile/response/ChangePasswordResponseMessage.dart';
import 'package:speakmatch_v2/model/profile/request/ChangePasswordRequestMessage.dart';
import 'package:speakmatch_v2/model/profile/response/ChangeUserInformationResponseMessage.dart';
import 'package:speakmatch_v2/model/profile/response/GetUserInformationResponseMessage.dart';
import 'package:speakmatch_v2/model/profile/response/UploadImageResponseMessage.dart';
import 'package:speakmatch_v2/service/web_service.dart';
import 'package:speakmatch_v2/shared-prefs.dart';

class ProfileController implements IProfileBase {
  WebService _webService = locator<WebService>();
  dynamic _requestBody;
  @override
  Future<GetUserInformationResponseMessage> getUserInformation() async {
    final item = await _webService.sendRequestWithGet("GetUserByToken");
    var getUserInformationResponseMessage =
        GetUserInformationResponseMessage.fromJson(item);
    return getUserInformationResponseMessage;
  }

  @override
  Future<UploadImageResponseMessage> changeProfilePhoto(File file) async {
    var uploadImageResponseMessage;
    Dio dio = new Dio();
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "img_data": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    dio
        .post("http://45.55.44.174/SM/UploadImage",
            options: Options(
                headers: {'Authorization': 'Bearer ' + SharedPrefs.getToken}),
            data: data)
        .then((response) {
      uploadImageResponseMessage =
          UploadImageResponseMessage.fromJson(response.data);
    }).catchError((error) => print(error));

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
