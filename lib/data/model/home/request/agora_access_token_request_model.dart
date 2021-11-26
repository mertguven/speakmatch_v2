class AgoraAccessTokenRequestModel {
  String channelName;

  AgoraAccessTokenRequestModel({this.channelName});

  AgoraAccessTokenRequestModel.fromJson(Map<String, dynamic> json) {
    channelName = json['channelName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channelName'] = this.channelName;
    return data;
  }
}
