import 'package:speakmatch_v2/model/profile/GetUserInformationResponseMessage.dart';

abstract class IProfileBase {
  Future<GetUserInformationResponseMessage> getUserInformation();
}
