class AgoraAccessTokenResponseModel {
  String token;
  String errorMessage;

  AgoraAccessTokenResponseModel({this.token, this.errorMessage});

  AgoraAccessTokenResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}
