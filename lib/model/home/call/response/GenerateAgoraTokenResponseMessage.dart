class GenerateAgoraTokenResponseMessage {
  bool success;
  String token;

  GenerateAgoraTokenResponseMessage({this.success, this.token});

  GenerateAgoraTokenResponseMessage.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['token'] = this.token;
    return data;
  }
}
