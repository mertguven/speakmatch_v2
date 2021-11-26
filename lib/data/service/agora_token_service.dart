import 'package:dio/dio.dart';
import 'package:speakmatch_v2/core/constants/app_constant.dart';
import 'package:speakmatch_v2/data/model/home/request/agora_access_token_request_model.dart';

class AgoraAccessTokenService {
  final Dio _dio = Dio();

  Future<Response<dynamic>> getAgoraAccessToken(
      AgoraAccessTokenRequestModel model) async {
    try {
      final response = await _dio.get(AppConstant.agoraAccessTokenBaseUrl,
          queryParameters: {'channelName': '${model.channelName}'});
      return response;
    } on DioError catch (e) {
      print(e.message);
      return null;
    }
  }
}
