class RegisterResponseMessage {
  bool success;
  String messages;

  RegisterResponseMessage({this.success, this.messages});

  RegisterResponseMessage.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    messages = json['Messages'];
  }
}
