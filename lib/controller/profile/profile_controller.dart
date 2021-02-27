import 'package:speakmatch_v2/controller/interfaces/iprofile_base.dart';
import 'package:speakmatch_v2/locator.dart';
import 'package:speakmatch_v2/model/profile/GetUserInformationResponseMessage.dart';
import 'package:speakmatch_v2/service/web_service.dart';

class ProfileController implements IProfileBase {
  WebService _webService = locator<WebService>();
  @override
  Future<GetUserInformationResponseMessage> getUserInformation() async {
    final item = await _webService.sendRequestWithGet("GetUserByToken");
    var getUserInformationResponseMessage =
        GetUserInformationResponseMessage.fromJson(item);
    return getUserInformationResponseMessage;
  }
}
