import 'package:speakmatch_v2/core/constants/app_constant.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void emailSender() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: AppConstant.helpEmail,
      query: _encodeQueryParameters(<String, String>{'subject': ''}),
    );

    launcher(emailLaunchUri.toString());
  }

  Future launcher(String url) async => await launch(url);
}
