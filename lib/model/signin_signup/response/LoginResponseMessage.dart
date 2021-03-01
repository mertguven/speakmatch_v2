class LoginResponseMessage {
  bool success;
  String token;
  String messages;

  LoginResponseMessage({this.success, this.messages, this.token});

  LoginResponseMessage.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    token = json['token'];
    messages = json['Messages'];
  }
}
