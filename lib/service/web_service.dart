import 'dart:convert';
import 'package:speakmatch_v2/shared-prefs.dart';
import 'package:speakmatch_v2/utilities/GlobalVariables.dart';
import 'package:http/http.dart' as http;

class WebService {
  Future<dynamic> sendRequestWithPost(String url, dynamic body) async {
    var result =
        await http.post(GlobalVariables.baseUrl(url), body: json.encode(body));
    var jsonResponse = json.decode(result.body);
    return jsonResponse;
  }

  Future<dynamic> sendRequestWithPostAndToken(String url, dynamic body) async {
    var result = await http.post(
      GlobalVariables.baseUrl(url),
      headers: {'Authorization': 'Bearer ' + SharedPrefs.getToken},
      body: json.encode(body),
    );
    var jsonResponse = json.decode(result.body);
    return jsonResponse;
  }

  Future<dynamic> sendRequestWithGet(String url) async {
    var result = await http.get(GlobalVariables.baseUrl(url),
        headers: {'Authorization': 'Bearer ' + SharedPrefs.getToken});
    var jsonResponse = json.decode(result.body);
    return jsonResponse;
  }
}
