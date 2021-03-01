import 'dart:io';

import 'package:speakmatch_v2/model/profile/request/ChangePasswordRequestMessage.dart';
import 'package:speakmatch_v2/model/profile/request/ChangeUserInformationRequestMessage.dart';
import 'package:speakmatch_v2/model/profile/response/ChangePasswordResponseMessage.dart';
import 'package:speakmatch_v2/model/profile/response/ChangeUserInformationResponseMessage.dart';
import 'package:speakmatch_v2/model/profile/response/GetUserInformationResponseMessage.dart';
import 'package:speakmatch_v2/model/profile/response/UploadImageResponseMessage.dart';

abstract class IProfileBase {
  Future<GetUserInformationResponseMessage> getUserInformation();
  Future<UploadImageResponseMessage> changeProfilePhoto(File file);
  Future<ChangePasswordResponseMessage> changePassword(
      ChangePasswordRequestMessage request);
  Future<ChangeUserInformationResponseMessage> changeUserInformation(
      ChangeUserInformationRequestMessage request);
}
